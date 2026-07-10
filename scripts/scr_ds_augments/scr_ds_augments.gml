function infoAugmentLine(augID) constructor {
	augDataID = augID;
	augDataName = "UNDEFINED";
	augDataDesc = "Whoops.";
	augDataSpr = -1;
	augDataBuildCost = 0;
	augDataComponents = [];
	augDataFunctions = [];
	augDataStats = {};
	
	/// @description Add info to the augment
	/// @param {String} augName Name of the augment
	/// @param {String} augDesc Description of the augment
	/// @param {Asset.GMSprite} augSpr Augment icon
	/// @param {Real} augBuildCost Base Packet cost for building this augment
	/// @param {Array<Enum.augIDs>} augComponents Array of augIDs enums indicating which augments build into this augment
	/// @param {Array<>} augFunctions Array of functions that this augment performs via broadcast listening
	/// @param {Struct} augStats Struct of stat structs that this augment provides - which stats, and how much of each
	function addAugInfo(augName, augDesc, augSpr, augBuildCost, augComponents, augFunctions, augStats) {
		augDataName = augName;
		augDataDesc = augDesc;
		augDataSpr = augSpr;
		augDataBuildCost = augBuildCost;
		augDataComponents = augComponents;
		augDataFunctions = augFunctions;
		augDataStats = augStats;
	}
}

function initAugmentInfo() {
	infoAugments[countAugs-1] = 0;
	for (var i = 0; i < countAugs; i += 1)
		infoAugments[i] = new infoAugmentLine(i);
		
	dpAugments(infoAugments);
}