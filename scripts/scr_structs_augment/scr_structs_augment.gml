/// @param {Struct.infoAugmentLine} augInfo Augment info line
function augmentObj(augInfo) constructor {
	augID = augInfo.augDataID;
	augUniqueID = random(999999999);
	augName = augInfo.augDataName;
	augDesc = augInfo.augDataDesc;
	augSpr = augInfo.augDataSpr;
	augFunctions = augInfo.augDataFunctions;
	augStats = augInfo.augDataStats;
	
	formsEquipped = [];
	slotEquipped = -1;
	
	destroyListeners = function() {
		for (var i = 0; i < array_length(augFunctions); i += 1) {
			var augFunc = augFunctions[i];
			global.ctrlBC.deregisterListener(augFunc.funcCode, augFunc.eventID, augFunc.priority, formsEquipped);
		}
	}
}