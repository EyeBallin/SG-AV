function entityDebuffResDataList(stsSlow, stsStun, stsDisplace, stsBleed, stsDmgDown, stsResDown, stsAttSpdDown,
	stsBurn, stsStaticShock, stsPsn, stsFrostFreeze, stsSeal, stsEntropy, stsShred, stsOverload) constructor {
		
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
	eStatBase = statInitVal;
	eStatMult = 1;
	
	eStatIsRes = false;	//Resource-type stat (HP, Mana, Shield)
	eStatResMaxBase = statInitVal;
	eStatResMaxCurr = statInitVal;
	eStatResMaxIsMod = false;
	
	eStatCalcMin = statMin;
	eStatCalcMax = statMax;
	eStatHardMin = statMin;
	eStatHardMax = statMax;
	
	eStatCurr = eStatInitVal;
	eStatIsMod = false;
	eStatCanBreakBounds = true;
	
	/// @func getStatCurr()
	/// @desc Returns the current value of the stat, clamped to the hard min and max.
	getStatCurr = function() {
		// Feather disable once GM1041
		return clamp(eStatCurr * eStatMult, eStatCalcMin, eStatCalcMax);
	}
	
	/// @func modifyStat(changeAmt, percBase)
	/// @desc Changes a stat by either adding/removing a flat amount, or multiplying it by an amount.
	modifyStat = function(changeAmt, percBase) {
		var tmpNewAmount = eStatCurr;
		if (percBase)
			changeAmt *= eStatBase;
		tmpNewAmount += changeAmt;
		
		if (eStatCanBreakBounds)
			eStatCurr = tmpNewAmount;
		else
			eStatCurr = clamp(tmpNewAmount, eStatCalcMin, eStatIsRes ? eStatResMaxCurr : eStatCalcMax);
		eStatCurr = clamp(eStatCurr, eStatHardMin, eStatHardMax);
		eStatIsModified = (eStatCurr != eStatBase);
	}
	
	/// @func modifyResMax(changeAmt, isPercBase, alsoChangeCurr)
	/// @desc Modifies the resource maximum of this stat. Does nothing if this stat isn't a resource.
	modifyResMax = function(changeAmt, isPercBase, alsoChangeCurr) {
		var initAmt = eStatResMaxCurr;
		var tmpAmt = eStatResMaxCurr;
		if (isPercBase)
			changeAmt *= eStatResMaxBase;
		tmpAmt += changeAmt;
		eStatResMaxCurr = clamp(tmpAmt, eStatHardMin, eStatHardMax);
		if (tmpAmt > 0)
			eStatCurr += tmpAmt-initAmt;
		eStatCurr = min(eStatCurr, eStatResMaxCurr);
		eStatResMaxIsMod = (eStatResMaxCurr != eStatResMaxBase);
	}
	
	/// @func modifyMult(changeAmt, relative)
	/// @desc Modifies the multiplier for the stat, either by setting it directly or adding/subtracting from it.
	modifyMult = function(changeAmt, relative) {
		eStatMult = relative ? eStatMult + changeAmt : changeAmt;
	}
}