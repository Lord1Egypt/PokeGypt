local damageMultiplier = damageMultiplierMoves.singletarget
local areaEffect = 819
local area = createCombatArea(NO_AREA)
local combat = COMBAT_NORMALDAMAGE

function onCastSpell(creature, variant)
	local target = creature:getTarget()
	if not target then return true end

	local damage = damageMultiplier * creature:getTotalMagicAttack()
	local creaturePosition = creature:getPosition()
	local targetPosition = target:getPosition()
	local dir = creature:getDirection()


	return true
end

--target lost attacks
