local damageMultiplier = damageMultiplierMoves.singletarget
local damageEffect = 10
local teleportEffect = 331
local combat = COMBAT_NORMALDAMAGE

function onCastSpell(creature, variant)
	local target = creature:getTarget()
	if not target then return true end

	local damage = damageMultiplier * creature:getTotalMagicAttack()

	local initialTargetPos = target:getPosition()
	local targetPos = target:getPosition()
	local random = math.random(0,4)
	targetPos:getNextPosition(random)

	local tmp = Tile(targetPos)
	if tmp and not (tmp:getHouse() or tmp:hasFlag(TILESTATE_PROTECTIONZONE) or tmp:hasFlag(TILESTATE_FLOORCHANGE) or tmp:hasFlag(TILESTATE_BLOCKSOLID)) then
		targetPos:sendMagicEffect(teleportEffect)
		creature:teleportTo(targetPos)
	else
		initialTargetPos:sendMagicEffect(teleportEffect)
		creature:teleportTo(initialTargetPos)
	end

	doTargetCombatHealth(creature.uid, target, combat, -damage, -damage, damageEffect)
	return true
end
