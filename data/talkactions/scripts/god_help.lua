-- PokeGypt GOD tool: list available GOD commands
-- Usage: /god
function onSay(player, words, param)
	if player:getAccountType() < ACCOUNT_TYPE_GOD then
		return true
	end

	local help = {
		"=== PokeGypt GOD tool ===",
		"/createacc name, password        - create an account",
		"/addmoney player, amount         - give gold",
		"/addlevel player, levels         - add (or remove) levels",
		"/addvip player, days             - give VIP/premium days",
		"/promote player, rank            - rank: player | tutor | gm | god",
		"/givepokeball player, pokemon, level, boost, love",
		"--- built-in admin commands ---",
		"/goto player        /c player (bring here)     /t town",
		"/addtutor player    /addskill player, skill, n /addpremium player, days",
		"/cb pokemon, level  (pokeball for yourself)    /save  /clean  /ghost",
	}
	player:showTextDialog(1949, table.concat(help, "\n"))
	return false
end
