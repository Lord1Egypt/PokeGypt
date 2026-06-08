# PokeGypt — Build & Conversion Plan

> TFS 1.2 (protocol 10.98) Pokemon edit → renamed **PokeGypt**, converted **MySQL → SQLite**,
> in-game **account manager** added, builds on **Linux + Windows**, published to GitHub.

Source origin: `pokedashpota1.02_release` (Pokemon ATS edit of The Forgotten Server 1.2).
Engine copyright (Mark Samman, GPLv2) **must be preserved** — only project branding is changed.

---

## Phase 0 — Toolchain (BLOCKER: needs sudo)
```bash
sudo apt update && sudo apt install -y git cmake build-essential \
  libluajit-5.1-dev default-libmysqlclient-dev libboost-system-dev \
  libpugixml-dev libgmp-dev libsqlite3-dev
```
- [ ] deps installed

## Phase 1 — Baseline compile (MySQL, as-is) to prove buildability ✅ DONE
- [x] `mkdir build && cd build && cmake .. && make -j$(nproc)`
- [x] fix gcc-13 issues: connection.h enum→constexpr (+ODR defs), lockfree allocator rebind, dropped -Werror

## Phase 2 — SQLite conversion (the core work) ✅ DONE & VERIFIED
- [x] `src/database.h`  — sqlite3*; DBResult buffers rows into vectors
- [x] `src/database.cpp` — connect/exec/store/escape(blob=X'')/transactions via sqlite3 API
- [x] `src/databasemanager.cpp` — sqlite_master; OPTIMIZE → VACUUM
- [x] `schema.sql` → `schema_sqlite.sql` via tools/mysql2sqlite_schema.py (26 core tables, structure-only)
- [x] `CMakeLists.txt` — find_package(SQLite3), link SQLite3
- [x] `config.lua` — `sqliteDatabase = "pokegypt.sqlite"`
- [x] otserv.cpp auto-imports schema on first launch; "SQLite" banner
- [x] startup.lua TRUNCATE → DELETE
- [x] RESULT: server boots → "PokeGypt Server Online!", creates pokegypt.sqlite, 0 SQLite errors

## Phase 3 — In-game Account Manager (1/1 login)
- [ ] account/character creation via login protocol (re-add TFS-0.x style flow)
- [ ] works alongside AAC website (both create accounts in same SQLite DB)

## Phase 4 — Rebrand pokedashpota → PokeGypt
- [ ] config.lua: serverName, motd, url
- [ ] src/definitions.h: STATUS_SERVER_NAME
- [ ] data/npc/scripts/Eva.lua, data/creaturescripts/scripts/login.lua
- [ ] binary name tfs → pokegypt

## Phase 5 — Cross-platform
- [x] Linux build (here, WSL)
- [ ] Windows: vcpkg + Visual Studio instructions (documented in README)

## Phase 6 — GitHub repo
- [ ] repo `Lord1Egypt/PokeGypt`, .gitignore (exclude vc14/boost, build/, *.sqlite)
- [ ] detailed README + About tab + LICENSE (GPLv2)

## Later — GOD tool
- VIP, teleport players, group upgrade (tutor/GM/god), add money/pokeballs/levels
