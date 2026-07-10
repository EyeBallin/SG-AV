/// @param {Struct.infoShipUpgrade} upgradeInfo Info line struct for this upgrade
function shipUpgrade(upgradeInfo) constructor {
	upgradeID = upgradeInfo.infoUpgradeID;
	upgradeName = upgradeInfo.infoUpgradeName;
	upgradeDesc = upgradeInfo.infoUpgradeDesc;
	upgradeDescLong = upgradeInfo.infoUpgradeDescLong;
	upgradeIcon = upgradeInfo.infoUpgradeIcon;
	upgradeForm = upgradeInfo.infoUpgradeForm;
	upgradeMaxLevels = upgradeInfo.infoUpgradeMaxLevels;
	upgradePreReqs = upgradeInfo.infoUpgradePreReqs;
	upgradeIsCombo = upgradeInfo.infoUpgradeIsCombo;
	var reassignedFuncs = [];
	for (var func = 0; func < array_length(upgradeInfo.infoUpgradeFunctions); func += 1) {
		var gotFunc = upgradeInfo.infoUpgradeFunctions[func];
		var clonedFunc = new upgradeFunction(gotFunc.eventID, gotFunc.priority, method(self, gotFunc.funcCode));
		reassignedFuncs[func] = clonedFunc;
	};
	upgradeFunctions = reassignedFuncs;
	
	upgradeCurrLevel = 0;
	
	destroyListeners = function() {
		for (var i = 0; i < array_length(upgradeFunctions); i += 1) {
			var upgradeFunc = upgradeFunctions[i];
			global.ctrlBC.deregisterListener(upgradeFunc.funcCode, upgradeFunc.eventID, upgradeFunc.priority, [upgradeForm]);
		}
	}
}

/// @param {Enum.sgForm} formID the Ship form ID to make the upgrades for
/// @returns {Array<Struct.shipUpgrade>}
function createAllFormUpgrades(formID) {
	var upgradeRetArr = [];
	for (var i = 0; i < array_length(global.ctrlInfo.infoUpgrades); i += 1) {
		var gotUpgradeInfo = global.ctrlInfo.infoUpgrades[i];	
		if (gotUpgradeInfo.infoUpgradeForm == formID) {
			array_push(upgradeRetArr, new shipUpgrade(gotUpgradeInfo));
		}
	}
	return upgradeRetArr;
}

function getUpgradeLevel(formID, upgradeID) {	
	var formInfo = global.ctrlPlayer.formsLoaded;
	var formStruct;
	for (var i = 0; i < array_length(formInfo); i += 1) {
		if (formInfo[i].formID == formID) {
			formStruct = formInfo[i];
			break;
		}
	}
	
	if (is_undefined(formStruct)) {
		return 0;
	} else {
		var upgradeToCheck = -1;
		for (var i = 0; i < array_length(formStruct.formUpgrades); i += 1) {
			if (formStruct.formUpgrades[i].upgradeID == upgradeID) {
				return formStruct.formUpgrades[i].upgradeCurrLevel;
			}
		}
		return 0;
	}
}