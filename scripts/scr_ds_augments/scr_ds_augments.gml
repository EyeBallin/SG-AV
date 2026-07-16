/// @param {Enum.augIDs} augIDArg augIDs enum of which aug ID this struct will be for
function infoAugmentLine(augIDArg) constructor {
	augDataID = augIDArg;
	augDataName = "UNDEFINED";
	augDataDesc = "Whoops.";
	augDataStatsStr = "";
	
	augScrName = scribble("");
	augScrDesc = scribble("");
	augScrStats = scribble("");
	
	augDataSpr = spr_singlePixel;
	augDataBuildCost = 0;
	augDataComponents = [augIDs.aGlimmerShard];
	augDataFunctions = [new augFunction(sysEvent.evAugEquip, 0, function(){})];
	augDataStats = new augStatsStruct([new augStatLineCreator("hp", 0.1, true)]);
	
	/// @description Add info to the augment
	/// @param {String} augName Name of the augment
	/// @param {String} augDesc Description of the augment
	/// @param {Asset.GMSprite} augSpr Augment icon
	/// @param {Real} augBuildCost Base Packet cost for building this augment
	/// @param {Array<Enum.augIDs>} augComponents Array of augIDs enums indicating which augments build into this augment
	/// @param {Array<Struct.augFunction>} augFunctions Array of functions that this augment performs via broadcast listening
	/// @param {Struct.augStats} augStatsArg Struct of stat structs that this augment provides - which stats, and how much of each
	function addAugInfo(augName, augDesc, augSpr, augBuildCost, augComponents, augFunctions, augStatsArg) {
		augDataName = augName;
		augDataDesc = augDesc;
		augDataSpr = augSpr;
		augDataBuildCost = augBuildCost;
		augDataComponents = augComponents;
		augDataFunctions = augFunctions;
		augDataStats = augStatsArg;
		
		var statStructKeys = struct_get_names(augStatsArg);
		for (var statLine = 0; statLine < array_length(statStructKeys); statLine += 1) {
			var statKey = statStructKeys[statLine];
			var statVal = augStatsArg[$ statKey].val;
			var statPerc = augStatsArg[$ statKey].percentMod;
			augDataStatsStr += $"[#DDDDDD]+[#FFFFFF]{statVal}{statPerc ? "%" : ""} [#DDDDDD]{statKey}\r\n";
			augScrStats = scribble(augDataStatsStr).starting_format("fnt_normal_bold", #FFFFFF);
			augScrStats.build(true);
		}
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