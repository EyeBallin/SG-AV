/// @param {Enum.augIDs} augIDArg augIDs enum of which aug ID this struct will be for
function infoAugmentLine(augIDArg) constructor {
	augDataID = augIDArg;
	augDataName = "UNDEFINED";
	augDataDesc = "Whoops.";
	augDataStatsStr = "";
	augDataPassivesStr = "";
	
	augScrName = scribble("");
	augScrDetails = scribble("");
	
	augDataSpr = spr_singlePixel;
	augDataBuildCost = 0;
	augDataComponents = [augIDs.aGlimmerShard];
	augDataStats = new augStatsStruct([new augStatLineCreator("hp", 0.1, true)]);
	augDataPassives = [new infoAugmentPassive(0, "", "", "", 0, [new augFunction(sysEvent.evAugEquip, 0, function(){})])];
	
	/// @description Add info to the augment
	/// @param {String} augName Name of the augment
	/// @param {String} augDesc Description of the augment
	/// @param {Asset.GMSprite} augSpr Augment icon
	/// @param {Real} augBuildCost Base Packet cost for building this augment
	/// @param {Array<Enum.augIDs>} augComponents Array of augIDs enums indicating which augments build into this augment
	/// @param {Struct.augStats} augStatsArg Struct of stat structs that this augment provides - which stats, and how much of each
	/// @param {Array<Struct.infoAugmentPassive>} augPassives Array of Augment Passive structs
	function addAugInfo(augName, augDesc, augSpr, augBuildCost, augComponents, augStatsArg, augPassives) {
		augDataName = augName;
		augDataDesc = augDesc;
		augDataSpr = augSpr;
		augDataBuildCost = augBuildCost;
		augDataComponents = augComponents;
		augDataPassives = augPassives;
		augDataStats = augStatsArg;
		
		var statStructKeys = struct_get_names(augStatsArg);
		for (var statLine = 0; statLine < array_length(statStructKeys); statLine += 1) {
			var statKey = statStructKeys[statLine];
			var statName = getStringsForAugStat(statKey).statName;
			var statVal = augStatsArg[$ statKey].val;
			var statPerc = augStatsArg[$ statKey].percentMod;
			augDataStatsStr += $"[#DDDDDD]+[#FFFFFF]{statPerc ? string(statVal*100) + "%" : statVal} [#DDDDDD]{statName}\r\n";
		}
		if (array_length(statStructKeys) > 0) {
			augDataStatsStr += "\r\n";
		}
		for (var passLine = 0; passLine < array_length(augPassives); passLine += 1) {
			var passData = augPassives[passLine];
			augDataPassivesStr += $"{passData.augPassName} [[{passData.augPassTier}]: {passData.augPassDesc}\r\n";
		}
		if (array_length(augPassives) > 0) {
			augDataPassivesStr += "\r\n";
		}
		
		var finalText = augDataStatsStr + augDataPassivesStr;
		augScrDetails = scribble(finalText).starting_format("fnt_normal_bold", #FFFFFF).wrap(500);
		augScrDetails.build(true);
	}
}

/// @desc Infomation about a function an augment performs
/// @param {Enum.sysEvent} eventIDArg sysEvent enum that determines which broadcasted event this function runs against
/// @param {Real} piorityArg Priority of this event, typically for addition vs multiplication
/// @param {Function.Struct} funcCodeArg Function to run, taking in a freeform struct as an argument
function augFunction(eventIDArg, priorityArg, funcCodeArg) constructor {
	eventID = eventIDArg;
	priority = priorityArg;
	funcCode = funcCodeArg;
}

/// @desc Struct holding sub-structs, each a stat this augment provides
/// @param {Array<Struct.augStatLine>} statLines Array of stats
function augStatsStruct(statLines) constructor {
	for (var stat = 0; stat < array_length(statLines); stat += 1) {
		var statLineName = statLines[stat].statName;
		var statLineVal = statLines[stat].statVal;
		var statLinePerc = statLines[stat].statPerc;
		var statInfo = new augStatLine(statLineVal, statLinePerc);
		struct_set(self, statLineName, statInfo);
	}
}

/// @desc Singular augment stat line - creator version
/// @param {String} statNameArg The name of the stat
/// @param {Real} statValArg The amount to add to the stat
/// @param {Bool} statPercArg Whether the statValArg is an addition or a multiplier
function augStatLineCreator(statNameArg, statValArg, statPercArg) constructor {
	statName = statNameArg;
	statVal = statValArg;
	statPerc = statPercArg;
}

/// @desc Singular augment stat line - constructed version
/// @param {Real} statValArg The amount to add to the stat
/// @param {Bool} statPercArg Whether the statValArg is an addition or a multiplier
function augStatLine(statValArg, statPercArg) constructor {
	val = statValArg;
	percentMod = statPercArg;
}

/// @desc An Augment passive
/// @param {Enum.augPassIDs} augPassIDArg The ID of the Augment passive, using the augPassIDs enum
/// @param {String} nameArg The passive's name
/// @param {String} descArg The passive's description
/// @param {String} descLongArg The passive's longform description
/// @param {Real} tierArg The tier of this passive, starting at 0 for tier 1, 1 for tier 2, etc.
/// @param {Array<Struct.augFunction>} augFunctions Array of functions that this augment passive performs via broadcast listening
/// @return {Struct.infoAugmentPassive} Augment passive info struct
function infoAugmentPassive(augPassIDArg, nameArg, descArg, descLongArg, tierArg, functionsArg) constructor {
	augPassID = augPassIDArg;
	augPassName = nameArg;
	augPassDesc = descArg;
	augPassDescLong = descLongArg;
	augPassTier = tierArg;
	augPassFunctions = functionsArg;
}

/// @returns {Array<Struct.infoAugmentLine>} Augment info array
function initAugmentInfo() {
	var infoAugmentsInt;
	infoAugmentsInt[countAugs-1] = 0;
	for (var i = 0; i < countAugs; i += 1) {
		infoAugmentsInt[i] = new infoAugmentLine(i);
	}
		
	dpAugments(infoAugmentsInt);
	return infoAugmentsInt;
}

/// @returns {Array<Array<Struct.infoAugmentPassive>>} Augment passive array
function initAugmentPassives() {
	var augPassiveArr;
	augPassiveArr[countAugPassives-1][2] = 0;
	for (var i = 0; i < countAugPassives; i += 1) {
		augPassiveArr[i][0] = new infoAugmentPassive(i, "", "", "", 0, [new augFunction(sysEvent.evAugEquip, 0, function(){})]);
	}
	
	dpAugmentPassives(augPassiveArr);
	return augPassiveArr;
}