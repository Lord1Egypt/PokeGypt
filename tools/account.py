#!/usr/bin/env python3
"""
PokeGypt account manager (standalone) -- works directly on the SQLite database.

Use this to bootstrap the first GOD account (the in-game /createacc talkaction
requires an existing GOD). After that you can manage everything in-game.

Examples:
  python3 tools/account.py create-account god 123456 --god
  python3 tools/account.py create-character god MyGod --god --town 1
  python3 tools/account.py create-account player1 secret
  python3 tools/account.py create-character player1 Hero --vocation 0 --town 1
  python3 tools/account.py list
  python3 tools/account.py set-type player1 5

Password hashing matches config.lua passwordType = "sha1".
"""
import argparse
import hashlib
import os
import sqlite3
import sys
import time

DEFAULT_DB = "pokegypt.sqlite"

# account.type (enums.h): 1 NORMAL, 2 TUTOR, 4 GAMEMASTER, 5 GOD
# player.group_id (groups.xml): 1 player, 2 gamemaster, 3 god
ACCOUNT_TYPE_GOD = 5
GROUP_PLAYER = 1
GROUP_GOD = 3


def sha1(text: str) -> str:
    return hashlib.sha1(text.encode("utf-8")).hexdigest()


def connect(db_path: str) -> sqlite3.Connection:
    if not os.path.exists(db_path):
        sys.exit(f"Database '{db_path}' not found. Start the server once to create it, "
                 f"or pass --db <path>.")
    conn = sqlite3.connect(db_path)
    conn.execute("PRAGMA foreign_keys = ON")
    return conn


def cmd_create_account(conn, args):
    name = args.name.strip()
    acc_type = ACCOUNT_TYPE_GOD if args.god else args.type
    cur = conn.execute("SELECT id FROM accounts WHERE name = ?", (name,))
    if cur.fetchone():
        sys.exit(f"Account '{name}' already exists.")
    conn.execute(
        "INSERT INTO accounts (name, password, type, premdays, lastday, email, creation) "
        "VALUES (?, ?, ?, 0, 0, '', ?)",
        (name, sha1(args.password), acc_type, int(time.time())),
    )
    conn.commit()
    print(f"Account '{name}' created (type {acc_type}).")


def cmd_create_character(conn, args):
    acc = conn.execute("SELECT id FROM accounts WHERE name = ?", (args.account.strip(),)).fetchone()
    if not acc:
        sys.exit(f"Account '{args.account}' does not exist. Create it first.")
    account_id = acc[0]

    char = args.name.strip()
    if conn.execute("SELECT id FROM players WHERE name = ?", (char,)).fetchone():
        sys.exit(f"Character '{char}' already exists.")

    group_id = GROUP_GOD if args.god else args.group
    # posx/posy/posz = 0 -> server places the character at the town temple on login.
    conn.execute(
        """INSERT INTO players
        (name, group_id, account_id, level, vocation, health, healthmax,
         experience, lookbody, lookfeet, lookhead, looklegs, looktype, lookaddons,
         maglevel, mana, manamax, manaspent, soul, town_id, posx, posy, posz,
         cap, sex, lastlogin, lastip, save, conditions, balance, stamina)
        VALUES (?, ?, ?, ?, ?, ?, ?, 0, ?, ?, ?, ?, ?, 0, 0, ?, ?, 0, 100, ?,
                0, 0, 0, ?, ?, 0, 0, 1, X'', 0, 2520)""",
        (char, group_id, account_id, args.level, args.vocation,
         args.health, args.health, args.lookbody, args.lookfeet, args.lookhead,
         args.looklegs, args.looktype, args.mana, args.mana, args.town,
         args.cap, args.sex),
    )
    conn.commit()
    role = "GOD" if args.god else f"group {group_id}"
    print(f"Character '{char}' created on account '{args.account}' ({role}, town {args.town}).")


def cmd_set_type(conn, args):
    if not conn.execute("SELECT id FROM accounts WHERE name = ?", (args.account.strip(),)).fetchone():
        sys.exit(f"Account '{args.account}' does not exist.")
    conn.execute("UPDATE accounts SET type = ? WHERE name = ?", (args.type, args.account.strip()))
    conn.commit()
    print(f"Account '{args.account}' type set to {args.type}.")


def cmd_list(conn, args):
    rows = conn.execute(
        "SELECT a.id, a.name, a.type, "
        "(SELECT group_concat(p.name, ', ') FROM players p WHERE p.account_id = a.id) "
        "FROM accounts a ORDER BY a.id"
    ).fetchall()
    if not rows:
        print("No accounts.")
        return
    print(f"{'ID':<5}{'ACCOUNT':<24}{'TYPE':<6}CHARACTERS")
    for aid, name, atype, chars in rows:
        print(f"{aid:<5}{name:<24}{atype:<6}{chars or '-'}")


def main():
    p = argparse.ArgumentParser(description="PokeGypt SQLite account manager")
    p.add_argument("--db", default=DEFAULT_DB, help=f"path to SQLite db (default: {DEFAULT_DB})")
    sub = p.add_subparsers(dest="command", required=True)

    a = sub.add_parser("create-account", help="create a new account")
    a.add_argument("name")
    a.add_argument("password")
    a.add_argument("--type", type=int, default=1, help="account type (1 normal .. 5 god)")
    a.add_argument("--god", action="store_true", help="shortcut for --type 5")
    a.set_defaults(func=cmd_create_account)

    c = sub.add_parser("create-character", help="create a character on an account")
    c.add_argument("account")
    c.add_argument("name")
    c.add_argument("--vocation", type=int, default=0)
    c.add_argument("--town", type=int, default=42)  # 42 = Pallet Town on global_dash.otbm
    c.add_argument("--sex", type=int, default=1, help="0 female, 1 male")
    c.add_argument("--level", type=int, default=1)
    c.add_argument("--health", type=int, default=150)
    c.add_argument("--mana", type=int, default=0)
    c.add_argument("--cap", type=int, default=400)
    c.add_argument("--group", type=int, default=GROUP_PLAYER)
    c.add_argument("--god", action="store_true", help="make character a god (group 3)")
    c.add_argument("--looktype", type=int, default=128)
    c.add_argument("--lookhead", type=int, default=78)
    c.add_argument("--lookbody", type=int, default=69)
    c.add_argument("--looklegs", type=int, default=58)
    c.add_argument("--lookfeet", type=int, default=76)
    c.set_defaults(func=cmd_create_character)

    s = sub.add_parser("set-type", help="change an account's type")
    s.add_argument("account")
    s.add_argument("type", type=int)
    s.set_defaults(func=cmd_set_type)

    l = sub.add_parser("list", help="list accounts and characters")
    l.set_defaults(func=cmd_list)

    args = p.parse_args()
    conn = connect(args.db)
    try:
        args.func(conn, args)
    finally:
        conn.close()


if __name__ == "__main__":
    main()
