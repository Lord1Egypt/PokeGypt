# PokeGypt

> A Pokémon **Open Tibia** game server based on **The Forgotten Server 1.2** (protocol **10.98**),
> converted to run on **SQLite** out of the box — no MySQL server, no setup. Just build and run.

**Made with ❤️ by [Lord1Egypt](https://github.com/Lord1Egypt)**

<p align="center">
  <img src="assets/pokegypt-demo.gif" alt="PokeGypt — SQLite database auto-created and server booting" width="100%">
</p>

---

## ✨ What makes PokeGypt different

| Feature | Detail |
|---------|--------|
| 🗄️ **SQLite by default** | The whole MySQL layer was rewritten for SQLite. The database is a single `pokegypt.sqlite` file, created **automatically** on first launch. No database server to install or configure. |
| ⚡ **Zero-setup** | First run imports the schema itself — boot the server and it's ready. |
| 👤 **Built-in account manager** | Create accounts in-game (`/createacc`) or with the bundled `tools/account.py` script. No website required. |
| 🐧🪟 **Linux & Windows** | Builds with CMake on both. Tested on Ubuntu/WSL with GCC 13. |
| 🧩 **Modern-compiler ready** | Patched to compile cleanly with GCC 13 / modern Boost. |

---

## 🚀 Quick start (Linux / WSL)

### 1. Install dependencies (Ubuntu/Debian)
```bash
sudo apt update && sudo apt install -y git cmake build-essential \
  libluajit-5.1-dev libboost-system-dev libpugixml-dev libgmp-dev libsqlite3-dev
```

### 2. Build
```bash
git clone https://github.com/Lord1Egypt/PokeGypt.git
cd PokeGypt
mkdir build && cd build
cmake .. -DLUA_INCLUDE_DIR=/usr/include/luajit-2.1
make -j$(nproc)
cp tfs ../pokegypt
cd ..
```
> The `-DLUA_INCLUDE_DIR` flag is only needed if CMake can't find LuaJIT's headers
> (on Ubuntu they live in `/usr/include/luajit-2.1`).

### 3. Run
```bash
./pokegypt
```
On the first launch you'll see:
```
PokeGypt - Version 1.0
Compiled by Lord1Egypt
>> Establishing database connection... SQLite 3.45.1
>> Empty database detected, importing schema_sqlite.sql...
>> Database schema imported successfully.
>> PokeGypt Server Online!
```
That's it — `pokegypt.sqlite` now exists and the server is running on ports **7171/7172**.

---

## 🪟 Building on Windows (Visual Studio + vcpkg)

CMake builds PokeGypt on Windows too. The easiest dependency manager is **vcpkg**.

1. **Install tools**
   - [Visual Studio 2022](https://visualstudio.microsoft.com/) with the *Desktop development with C++* workload
   - [CMake](https://cmake.org/download/) (or the one bundled with VS)
   - [Git for Windows](https://git-scm.com/download/win)

2. **Install vcpkg**
   ```powershell
   git clone https://github.com/microsoft/vcpkg
   .\vcpkg\bootstrap-vcpkg.bat
   ```

3. **Install the libraries** (x64)
   ```powershell
   .\vcpkg\vcpkg install luajit boost-system pugixml gmp sqlite3 --triplet x64-windows
   ```

4. **Configure & build PokeGypt**
   ```powershell
   git clone https://github.com/Lord1Egypt/PokeGypt.git
   cd PokeGypt
   cmake -B build -S . -DCMAKE_TOOLCHAIN_FILE=C:/path/to/vcpkg/scripts/buildsystems/vcpkg.cmake -DCMAKE_BUILD_TYPE=Release
   cmake --build build --config Release
   ```

5. **Run** — copy `build\Release\tfs.exe` next to `config.lua` (the server root) and run it.
   The required vcpkg DLLs are placed beside the executable automatically; if any are
   missing, copy them from `vcpkg\installed\x64-windows\bin`.

> Tip: keep `config.lua`, `schema_sqlite.sql` and the `data/` folder in the same directory
> as the executable — the server uses relative paths.

---

## 👤 Account manager

PokeGypt does **not** need an external website to create accounts.

### Default GOD account (ready out of the box)
A fresh database is seeded with a ready-to-use GOD account:

| Account | Password | Characters |
|---------|----------|------------|
| `LordEgypt` | `123456` | **LordEgypt** (GOD) · **Trainer** (normal) |

Just log in and play. **Change the password after your first login.**

### Or bootstrap your own GOD account
```bash
python3 tools/account.py create-account god 123456 --god
python3 tools/account.py create-character god TheGod --god --town 1
```

### In-game (GOD only)
```
/createacc accountName, password
```

### More tool commands
```bash
python3 tools/account.py create-account ash pikachu          # normal account
python3 tools/account.py create-character ash Ash --town 1   # add a character
python3 tools/account.py set-type ash 5                      # promote to GOD
python3 tools/account.py list                                # list everything
```
Passwords are hashed with **sha1** (matching `config.lua`'s `passwordType`).

> New characters spawn at the **town temple** (`town_id`, default `1`). If login fails with
> an invalid-town error, pick a town id that exists on your map with `--town <id>`.

---

## 🛡️ GOD tool (in-game admin commands)

All commands are **GOD-only** (account type 5). Type `/god` in-game for the full list.

| Command | Description |
|---------|-------------|
| `/god` | Show all GOD commands |
| `/createacc name, password` | Create an account |
| `/addmoney player, amount` | Give gold to a player |
| `/addlevel player, levels` | Add (or remove with a negative number) levels |
| `/addvip player, days` | Give VIP / premium days |
| `/promote player, rank` | Set rank: `player` \| `tutor` \| `gm` \| `god` (sets group + account type) |
| `/givepokeball player, pokemon, level, boost, love` | Give a pokéball with a captured pokémon |

Plus the engine's built-in admin commands: `/goto`, `/c` (bring player), `/t` (go to town),
`/addtutor`, `/addskill`, `/addpremium`, `/cb` (pokéball for yourself), `/save`, `/clean`,
`/ghost`, and more.

## ⚙️ Configuration

Key options in `config.lua`:
```lua
sqliteDatabase = "pokegypt.sqlite"   -- database file (created automatically)
serverName     = "PokeGypt"
ip             = "127.0.0.1"          -- change to your public IP to host online
loginProtocolPort = 7171
gameProtocolPort  = 7172
```

---

## 🗺️ Editing the map

The world (`data/world/global_dash.otbm`) is a binary Open Tibia map. To edit it visually,
use **[Remere's Map Editor (RME)](https://github.com/hampusborgos/rme)** — open the `.otbm`
with the 10.98 client assets. Spawns and houses can also be tuned in
`data/world/map-spawn.xml` and `data/world/map-house.xml`.

---

## 🌐 About the AAC website (Znote)

The original distribution shipped a **Znote AAC** website, which is PHP + **MySQL**. Because
PokeGypt runs on SQLite, the Znote site can't share the same database file. You have two options:

- **Use the built-in account manager** (recommended) — no website needed.
- **Run a website with MySQL** — keep a separate MySQL database for the AAC and create
  accounts there; this is independent of the SQLite game server.

---

## 🛠️ Tech notes

- **Engine:** The Forgotten Server 1.2 (C++ / LuaJIT), client protocol **10.98**
- **Database:** SQLite 3 (WAL journal mode). Conversion lives in
  `src/database.cpp`, `src/databasemanager.cpp`, and `tools/mysql2sqlite_schema.py`.
- **Regenerate the schema** from a MySQL dump: `python3 tools/mysql2sqlite_schema.py`
- See `BUILD_PLAN.md` for the full conversion log.

---

## 📜 License

PokeGypt is released under the **GNU General Public License v2.0** — see [LICENSE](LICENSE).
It is based on [The Forgotten Server](https://github.com/otland/forgottenserver)
© Mark Samman, also GPLv2. The original engine copyright notices are preserved as required.

---

**Made with ❤️ by [Lord1Egypt](https://github.com/Lord1Egypt)** 🇪🇬
