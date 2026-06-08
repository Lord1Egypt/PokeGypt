# VHS tape for the PokeGypt terminal demo GIF.
# Regenerate with:  vhs demo.tape   (run from the server root)
Output assets/pokegypt-demo.gif

Set Shell bash
Set FontSize 17
Set Width 1180
Set Height 720
Set Theme "Dracula"
Set TypingSpeed 55ms
Set Padding 18

Type "# PokeGypt  -  Pokemon Open Tibia server on SQLite (no MySQL)"
Enter
Sleep 800ms

Type "# Default GOD account is seeded automatically:"
Enter
Sleep 500ms
Type "python3 tools/account.py list"
Enter
Sleep 2500ms

Type "# Boot it - the DB is created on first run, zero setup:"
Enter
Sleep 500ms
Type "./pokegypt"
Enter
Sleep 17s

Ctrl+C
Sleep 1500ms
