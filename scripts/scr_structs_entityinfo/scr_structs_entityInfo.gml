/// @desc The stat list for an entity. When an entity is created, many entityStat structs are made and populated with info from this list.
/// @arg {struct} statHP The HP data for the entity.
/// @arg {struct} statMana The Mana data for the entity.
/// @arg {struct} statShield The Shield data for the entity.
/// @arg {struct} statMoveSpd The Move Speed data for the entity.
/// @arg {struct} statAttSpd The Attack Speed data for the entity.
/// @arg {struct} statSpellSpd The Spell Speed data for the entity.
/// @arg {struct} statCCRes The CC Resistance data for the entity.
/// @arg {struct} statResAll The Global Resistance data for the entity.
/// @arg {struct} statResProj The Projectile (any non-collision) Resistance data for the entity.
/// @arg {struct} statResColl The Collision Resistance data for the entity.
/// @arg {struct} statResElem The Global Elemental Resistance data for the entity.

function entityStatDataList(statHP, statMana, statShield, statMoveSpd, statAttSpd, statSpellSpd, statCCRes, statResAll, statResProj, statResColl, statResElem) constructor {
	
}

global.test = new entityStatDataList(
	{a: 1}, {a: 1}, {a: 1}, {a: 1}, {a: 1}, {a: 1}, {a: 1}, {a: 1}, {a: 1}, {a: 1}, {a: 1}
)

function entityDebuffResDataList(stsSlow, stsStun, stsDisplace, stsBleed, stsDmgDown, stsResDown, stsAttSpdDown,
	stsBurn, stsStaticShock, stsPsn, stsFrostFreeze, stsSeal, stsEntropy, stsShred, stsOverload) constructor {
		
}

///@desc A small object used by entityStatList. Used to populate entityStat structs when they're created.
///@arg {real} statBase The starting value for the stat.
///@arg {real} statMin The base minimum value for the stat.
///@arg {real} statMax The base maximum value for the stat.
function entityStatInfo(statBase, statMin, statMax) constructor {
	
}

/// @func entityStat(statOwner, statType, statName, statDesc, statInitVal, statMin, statMax)
/// @desc Creates a new stat object for an entity (HP, Mana, etc.). Keeps tracks of mins, maxes, etc.
/// @arg {real} statOwner The owning object of this stat. -1 for 
/// @arg {real} statType The ID of the stat.
/// @arg {string} statName The name of the stat.
/// @arg {string} statDesc The description of the stat.
/// @arg {real} statInitVal What this stat initialises at.
/// @arg {real} statMin The base minimum for this stat.
/// @arg {real} statMax The base maximum for this stat.
function entityStat(statOwner, statType, statName, statDesc, statInitVal, statMin, statMax) constructor {
	eStatOwner = statOwner;
	eStatType = statType;
	eStatName = statName;
	eStatDesc = statDesc;
	eStatInitVal = statInitVal;
	eStatCalcMin = statMin;
	eStatCalcMax = statMax;
	
	eStatCurr = eStatInitVal;
	
	/// @func getStatCurr()
	/// @desc Returns the current value of the stat, clamped to the hard min and max.
	getStatCurr = function() {
		return clamp(eStatCurr, eStatCalcMin, eStatCalcMax);
	}
}