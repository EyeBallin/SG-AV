/// @desc Gets the given string from the dictionary, given an ID. Returns an error string if none found.
/// @param {string} strKey The ID of the string to fetch
/// @return {string} The found string, or "--ERROR--" if no string with given ID is found.
function getString(strKey) {
    var foundStr = variable_struct_get(global.ctrlStr.strDictEng, strKey);
    return (!is_undefined(foundStr)? foundStr : "--ERROR--");
}


/// @desc Using a 2-width array of placeholders and actual values, replaces all found placeholders in the given string with their actual value.
/// @param {string} str The core string that will be parsed
/// @param {array} Width 2, Length Any. [x][0] is the placeholder to target, [x][1] is the string to replace it with
function fillStringInfo(str, keyValMapArr) {
	for (var mapI = 0; mapI < array_length(keyValMapArr); i += 1) {
		str = string_replace_all(str, keyValMapArr[mapI][0], keyValMapArr[mapI][1]);
	}
	return str;
}

/// @desc Takes in an aug stat, returns the stat name & player desc strings
/// @param {String} augStatName The name of the stat as displayed in the augment
/// @returns {Struct.statStringBatch} Stat name & descs
function getStringsForAugStat(augStatName) {
	var statIntName = "";
	var statIntDesc = "";
	var statIntDescPlayer = "";
	switch(augStatName) {
		case "hp":
			statIntName = getString("statHPMaxName");
			statIntDesc = getString("statHPMaxDesc");
			statIntDescPlayer = getString("statHPMaxDescPlayer");
			break;
		case "hpRegen": 
			statIntName = getString("statHPRegenName");
			statIntDesc = getString("statHPRegenDesc");
			statIntDescPlayer = getString("statHPRegenDescPlayer");
			break;
		case "mana": 
			statIntName = getString("statManaMaxName");
			statIntDesc = getString("statManaMaxDesc");
			statIntDescPlayer = getString("statManaMaxDescPlayer");
			break;
		case "manaRegen": 
			statIntName = getString("statManaRegenName");
			statIntDesc = getString("statManaRegenDesc");
			statIntDescPlayer = getString("statManaRegenDescPlayer");
			break;
		case "shield": 
			statIntName = getString("statShieldMaxName");
			statIntDesc = getString("statShieldMaxDesc");
			statIntDescPlayer = getString("statShieldMaxDescPlayer");
			break;
		case "physDmg":
			statIntName = getString("statDmgPhysName");
			statIntDesc = getString("statDmgPhysDesc");
			statIntDescPlayer = getString("statDmgPhysDescPlayer");
			break;
		case "energyDmg":
			statIntName = getString("statDmgEnerName");
			statIntDesc = getString("statDmgEnerDesc");
			statIntDescPlayer = getString("statDmgEnerDescPlayer");
			break;
		case "projRes": 
			statIntName = getString("statResProjName");
			statIntDesc = getString("statResProjDesc");
			statIntDescPlayer = getString("statResProjDesc");
			break;
		case "collRes": 
			statIntName = getString("statResCollName");
			statIntDesc = getString("statResCollDesc");
			statIntDescPlayer = getString("statResCollDesc");
			break;
		case "elemResFire": 
			statIntName = getString("statResElemFireName");
			statIntDesc = getString("statResElemFireDesc");
			statIntDescPlayer = getString("statResElemFireDescPlayer");
			break;
		case "elemResElec":
			statIntName = getString("statResElemElecName");
			statIntDesc = getString("statResElemElecDesc");
			statIntDescPlayer = getString("statResElemElecDescPlayer");
			break;
		case "elemResPsn":
			statIntName = getString("statResElemPsnName");
			statIntDesc = getString("statResElemPsnDesc");
			statIntDescPlayer = getString("statResElemPsnDescPlayer");
			break;
		case "elemResIce":
			statIntName = getString("statResElemIceName");
			statIntDesc = getString("statResElemIceDesc");
			statIntDescPlayer = getString("statResElemIceDescPlayer");
			break;
		case "elemResLight":
			statIntName = getString("statResElemLightName");
			statIntDesc = getString("statResElemLightDesc");
			statIntDescPlayer = getString("statResElemLightDescPlayer");
			break;
		case "elemResDark":
			statIntName = getString("statResElemDarkName");
			statIntDesc = getString("statResElemDarkDesc");
			statIntDescPlayer = getString("statResElemDarkDescPlayer");
			break;
		case "ccRes":
			statIntName = getString("statResCCName");
			statIntDesc = getString("statResCCDesc");
			statIntDescPlayer = getString("statResCCDescPlayer");
			break;
		case "attSpd":
			statIntName = getString("statSpdAttName");
			statIntDesc = getString("statSpdAttDesc");
			statIntDescPlayer = getString("statSpdAttPlayer");
			break;
		case "spellSpd":
			statIntName = getString("statSpdSpellName");
			statIntDesc = getString("statSpdSpellDesc");
			statIntDescPlayer = getString("statSpdSpellPlayer");
			break;
		case "moveSpd":
			statIntName = getString("statSpdMoveName");
			statIntDesc = getString("statSpdMoveDesc");
			statIntDescPlayer = getString("statSpdMovePlayer");
			break;
		case "attLS":
			statIntName = getString("statLSAttName");
			statIntDesc = getString("statLSAttDesc");
			statIntDescPlayer = getString("statLSAttPlayer");
			break;
		case "spellLS":
			statIntName = getString("statLSSpellName");
			statIntDesc = getString("statLSSpellDesc");
			statIntDescPlayer = getString("statLSSpellPlayer");
			break;
		case "debuffDur":
			statIntName = getString("statDbfDurName");
			statIntDesc = getString("statDbfDurDesc");
			statIntDescPlayer = getString("statDbfDurPlayer");
			break;
		case "vuln": 
			statIntName = getString("statVulnName");
			statIntDesc = getString("statVulnDesc");
			statIntDescPlayer = getString("statVulnPlayer");
			break;
	}
	return new statStringBatch(statIntName, statIntDesc, statIntDescPlayer);
}

/// @desc Struct holding string information about a given stat in a referrable format.
/// @param {String} statNameArg The name of the stat
/// @param {String} statDescArg The description of the stat as it applies to anything not the player
/// @param {String} statDescPlayerArg The description of the stat as it applies to the player
/// @returns {Struct.statStringBatch} Stat name & descs
function statStringBatch(statNameArg, statDescArg, statDescPlayerArg) constructor {
	statName = statNameArg;
	statDesc = statDescArg;
	statDescPlayer = statDescPlayerArg;
}

/// @desc Returns the text colour associated with a given aug tier
/// @param {Real} augTier The tier of augment to get the colour for, from 0 to 3 inclusive.
/// @returns {string} The ##RRGGBB hex code of the colour associated with the given tier.
function getAugTierCol(augTier) {
	switch (augTier) {
		case 0: return "#FFFFFF";
		case 1: return "#95D679";
		case 2: return "#96BDFB";
		case 3: return "#ffdced";
		default: return "#FFFFFF";
	}
}