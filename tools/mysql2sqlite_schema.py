#!/usr/bin/env python3
"""
Convert the MySQL schema dump (schema.sql) into a clean, structure-only
SQLite schema (schema_sqlite.sql) for PokeGypt.

- Keeps only the core TFS tables (skips znote_* AAC website tables, which
  require MySQL anyway).
- Emits table structure only (no player/account data) -> fresh server +
  removes leftover personal data.
- Seeds server_config so the DB starts at db_version 19 (no migrations run).
"""
import re
import sys

SRC = "schema.sql"
DST = "schema_sqlite.sql"

SKIP_PREFIXES = ("znote",)  # AAC website tables -> skip


def convert_type(coldef: str) -> str:
    s = coldef
    # integer family (with optional unsigned / display width)
    s = re.sub(r"\b(?:big|medium|small|tiny)?int(?:\s+unsigned)?(?:\(\d+\))?", "INTEGER", s, flags=re.I)
    # char / varchar
    s = re.sub(r"\b(?:var)?char\(\d+\)", "TEXT", s, flags=re.I)
    # text family
    s = re.sub(r"\b(?:tiny|medium|long)?text\b", "TEXT", s, flags=re.I)
    # blob family
    s = re.sub(r"\b(?:tiny|medium|long)?blob\b", "BLOB", s, flags=re.I)
    # floating point / decimal
    s = re.sub(r"\bdecimal\(\d+,\s*\d+\)", "REAL", s, flags=re.I)
    s = re.sub(r"\b(?:double|float|real)\b", "REAL", s, flags=re.I)
    # date/time -> store as text
    s = re.sub(r"\b(?:datetime|timestamp|date|time)\b", "TEXT", s, flags=re.I)
    # enum/set -> text
    s = re.sub(r"\benum\([^)]*\)", "TEXT", s, flags=re.I)
    s = re.sub(r"\bset\([^)]*\)", "TEXT", s, flags=re.I)
    # column comments (not supported by SQLite)
    s = re.sub(r"\bCOMMENT\s+'(?:[^'\\]|\\.)*'", "", s, flags=re.I)
    # leftovers
    s = re.sub(r"\bunsigned\b", "", s, flags=re.I)
    s = re.sub(r"\bzerofill\b", "", s, flags=re.I)
    s = re.sub(r"\bCOLLATE\s+\w+", "", s, flags=re.I)
    s = re.sub(r"\bCHARACTER SET\s+\w+", "", s, flags=re.I)
    s = re.sub(r"\bon update CURRENT_TIMESTAMP\b", "", s, flags=re.I)
    s = re.sub(r"\s+", " ", s).strip()
    return s


def strip_prefix_lengths(cols: str) -> str:
    # `name`(15) -> `name`  (SQLite indexes don't support prefix lengths)
    return re.sub(r"(`\w+`)\(\d+\)", r"\1", cols)


def convert_table(name: str, body: str) -> str:
    lines = [ln.strip().rstrip(",") for ln in body.splitlines() if ln.strip()]
    col_defs = []
    table_constraints = []
    post_statements = []
    autoinc_col = None

    for ln in lines:
        up = ln.upper()
        m_col = re.match(r"^`(\w+)`\s+(.*)$", ln)
        if up.startswith("PRIMARY KEY"):
            cols = re.match(r"^PRIMARY KEY\s*\((.*)\)$", ln, re.I).group(1)
            cols = strip_prefix_lengths(cols)
            # if single-column PK on the auto-increment col, it's already inline
            single = re.fullmatch(r"`(\w+)`", cols.strip())
            if autoinc_col and single and single.group(1) == autoinc_col:
                continue
            table_constraints.append(f"PRIMARY KEY ({cols})")
        elif up.startswith("UNIQUE KEY") or up.startswith("UNIQUE INDEX"):
            m = re.match(r"^UNIQUE (?:KEY|INDEX)\s+`(\w+)`\s*\((.*)\)$", ln, re.I)
            idx, cols = m.group(1), strip_prefix_lengths(m.group(2))
            post_statements.append(f"CREATE UNIQUE INDEX `{name}_{idx}` ON `{name}` ({cols});")
        elif up.startswith("KEY") or up.startswith("INDEX"):
            m = re.match(r"^(?:KEY|INDEX)\s+`(\w+)`\s*\((.*)\)$", ln, re.I)
            idx, cols = m.group(1), strip_prefix_lengths(m.group(2))
            post_statements.append(f"CREATE INDEX `{name}_{idx}` ON `{name}` ({cols});")
        elif up.startswith("CONSTRAINT") or up.startswith("FOREIGN KEY"):
            fk = ln[ln.upper().index("FOREIGN KEY"):]
            table_constraints.append(fk)
        elif m_col:
            col = m_col.group(1)
            rest = m_col.group(2)
            if "AUTO_INCREMENT" in rest.upper():
                autoinc_col = col
                col_defs.append(f"`{col}` INTEGER PRIMARY KEY AUTOINCREMENT")
            else:
                col_defs.append(f"`{col}` {convert_type(rest)}")
        # else: ignore unknown line

    all_defs = col_defs + table_constraints
    inner = ",\n  ".join(all_defs)
    out = [f"CREATE TABLE `{name}` (\n  {inner}\n);"]
    out.extend(post_statements)
    return "\n".join(out)


def main():
    with open(SRC, "r", encoding="latin-1") as f:
        data = f.read()

    pattern = re.compile(r"CREATE TABLE `(\w+)` \((.*?)\)\s*ENGINE=[^;]*;", re.S)
    tables = []
    for m in pattern.finditer(data):
        name, body = m.group(1), m.group(2)
        if name.startswith(SKIP_PREFIXES):
            continue
        tables.append((name, body))

    if not tables:
        print("ERROR: no tables parsed", file=sys.stderr)
        sys.exit(1)

    out = []
    out.append("-- PokeGypt SQLite schema (auto-generated from schema.sql)")
    out.append("-- Structure only: a fresh database with no player data.")
    out.append("PRAGMA foreign_keys = OFF;")
    out.append("BEGIN TRANSACTION;")
    out.append("")
    for name, body in tables:
        out.append(convert_table(name, body))
        out.append("")

    # clean server_config seed (db_version 19 = no migrations run)
    out.append("DELETE FROM `server_config`;")
    out.append("INSERT INTO `server_config` (`config`,`value`) VALUES "
               "('db_version','19'),('motd_hash',''),('motd_num','1'),('players_record','0');")
    out.append("")
    # default GOD account (LordEgypt / 123456 sha1) + a god char and a normal char
    out.append("-- Default GOD account (login: LordEgypt / password: 123456 -- sha1). Change it after first login!")
    out.append("INSERT INTO `accounts` (`id`,`name`,`password`,`type`,`creation`) "
               "VALUES (1,'LordEgypt','7c4a8d09ca3762af61e59520943dc26494f8941b',5,0);")
    out.append("INSERT INTO `players` (`name`,`group_id`,`account_id`,`town_id`,`looktype`,`cap`,`sex`,`conditions`) "
               "VALUES ('LordEgypt',3,1,42,136,400,1,X'');")
    out.append("INSERT INTO `players` (`name`,`group_id`,`account_id`,`town_id`,`looktype`,`cap`,`sex`,`conditions`) "
               "VALUES ('Trainer',1,1,42,136,400,1,X'');")
    out.append("")
    out.append("-- In-game account manager (login: 1 / password: 1 -- sha1). Use to create/manage accounts in-game.")
    out.append("INSERT INTO `accounts` (`id`,`name`,`password`,`type`,`premdays`,`creation`) "
               "VALUES (2,'1','356a192b7913b04c54574d18c28d46e6395428ab',1,65535,0);")
    out.append("INSERT INTO `players` (`name`,`group_id`,`account_id`,`town_id`,`looktype`,`cap`,`sex`,`conditions`) "
               "VALUES ('Account Manager',1,2,42,130,400,1,X'');")
    out.append("")
    out.append("COMMIT;")
    out.append("PRAGMA foreign_keys = ON;")
    out.append("")

    with open(DST, "w", encoding="utf-8") as f:
        f.write("\n".join(out))

    print(f"Converted {len(tables)} core tables -> {DST}")
    print("Tables:", ", ".join(n for n, _ in tables))


if __name__ == "__main__":
    main()
