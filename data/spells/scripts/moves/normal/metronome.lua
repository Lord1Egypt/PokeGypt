local ultimates = {"hyper voice", "overheat", "leaf storm", "hurricane", "surf", "torment", "bug buzz", "psychic", "earthquake", "thunder", "rock slide", "focus punch", "blizzard", "night shade", "metal sound", "outrage"}

function onCastSpell(creature, variant)

	doCreatureCastSpell(creature, ultimates[math.random(1, #ultimates)])

	return true
end

