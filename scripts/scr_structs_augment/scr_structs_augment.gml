/// @param {Struct.infoAugmentLine} augInfo Augment info line
function augmentObj(augInfo) constructor {
	augID = augInfo.augDataID;
	augUniqueID = random(999999999);
	augName = augInfo.augDataName;
	augDesc = augInfo.augDataDesc;
	augSpr = augInfo.augDataSpr;
	augStats = augInfo.augDataStats;
	augTier = augInfo.augDataTier;
	
	augStrName = augInfo.augDataNameStr;
	augStrDesc = augInfo.augDataDescStr;
	augStrStats = augInfo.augDataStatsStr;
	augStrPassives = augInfo.augDataPassivesStr;
	augStrPassivesLong = augInfo.augDataPassivesLongStr;
	
	augScrDetails = augInfo.augScrDetails;
	augScrDetailsLong = augInfo.augScrDetailsLong;
	
	formsEquipped = [];
	slotEquipped = -1;
	
	for (var pass = 0; pass < array_length(augInfo.augDataPassives); pass += 1) {
		augPassives[pass] = new augmentPassive(augInfo.augDataPassives[pass]);
	}
	
	destroyListeners = function() {
		for (var h = 0; h < array_length(augPassives); h += 1) {
			for (var i = 0; i < array_length(augPassives[h].augPassFunctions); i += 1) {
				var augFunc = augPassives[h].augPassFunctions;
				global.ctrlBC.deregisterListener(augFunc.funcCode, augFunc.eventID, augFunc.priority, formsEquipped);
			}
		}
	}
}