function infoAugmentLine(augID) constructor {
	augDataID = augID;
	augDataName = "UNDEFINED";
	augDataDesc = "Whoops.";
	augDataSpr = -1;
	augDataBuildCost = 0;
	augDataComponents = [];
	augDataFunctions = [];
	
	function addAugInfo(augName, augDesc, augSpr, augBuildCost, augComponents, augFunctions) {
		augDataName = augName;
		augDataDesc = augDesc;
		augDataSpr = augSpr;
		augDataBuildCost = augBuildCost;
		augDataComponents = augComponents;
		augDataFunctions = augFunctions;
	}
}

function initAugmentInfo() {
	infoAugments[countAugs-1] = 0;
	for (var i = 0; i < countAugs; i += 1)
		infoAugments[i] = new infoAugmentLine(i);
		
	dpAugments(infoAugments);
}