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
	upgradeValues = upgradeInfo.infoUpgradeValues;
	
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

/// @param {Enum.sgForm} formID the Ship form ID to check (cuts back on searches)
/// @param {Enum.shipUpgradeIDs} upgradeID The Upgrade ID to find
/// @returns {Struct.shipUpgrade}
function fetchUpgradeStruct(formID, upgradeID) {
	var formInfo = global.ctrlPlayer.formsLoaded;
	var formStruct;
	for (var i = 0; i < array_length(formInfo); i += 1) {
		if (formInfo[i].formID == formID) {
			formStruct = formInfo[i];
			break;
		}
	}
	
	if (is_undefined(formStruct)) {
		return undefined;
	} else {
		for (var i = 0; i < array_length(formStruct.formUpgrades); i += 1) {
			if (formStruct.formUpgrades[i].upgradeID == upgradeID) {
				return formStruct.formUpgrades[i];
			}
		}
		return undefined;
	}
}

function getUpgradeLevel(formID, upgradeID) {	
	var upgradeStruct = fetchUpgradeStruct(formID, upgradeID);
	if (is_undefined(upgradeStruct)) {
		return 0;
	} else {
		return upgradeStruct.upgradeCurrLevel;
	}
}

/// @param {Enum.sgForm} formID the Ship form ID to check (cuts back on searches)
/// @param {Enum.shipUpgradeIDs} upgradeID The Upgrade ID to find
/// @param {Enum.shipUpgradeValueIDs} valueID The ID of the changing value
function getUpgradeValue(formID, upgradeID, valueID) {
	var upgradeStruct = fetchUpgradeStruct(formID, upgradeID);
	if (is_undefined(upgradeStruct)) {
		return undefined;
	} else {
		var arrIndex = array_find_index(upgradeStruct.upgradeValues, method({valueID}, function(a) { return a.valueID == valueID }));
		if (arrIndex == -1) {
			return undefined;
		}
		var valueStruct = upgradeStruct.upgradeValues[arrIndex];
		return valueStruct.valueBase + (valueStruct.valueDelta * upgradeStruct.upgradeCurrLevel);
	}
}

/// @desc Purchases an upgrade, given the upgrade & form IDs. Can either give relative levels in the upgrade, or set it to an absolute value.
/// @param {Enum.sgForm} formID The Ship form ID from the `sgForm` enum.
/// @param {Enum.shipUpgradeIDs} upgradeID The upgrade ID from the `shipUpgradeIDs` enum.
/// @param {Real} level Level to set the upgrade to (or increase/decrease by if rel is true)
/// @param {Bool} rel If this is relatively increasing the level (true), or setting the level to be an exact number (false)
/// @returns {bool} Whether the upgrade level was changed or not. False means either an invalid upgrade, invalid form, or the level didn't change.
function setUpgradeLevel(formID, upgradeID, level, rel) {
	var upgradeToCheck = fetchUpgradeStruct(formID, upgradeID);
	if (is_undefined(upgradeToCheck)) {
		return false;
	} else if (
		(upgradeToCheck.upgradeCurrLevel == level && !rel) ||
		(rel && 
			(upgradeToCheck.upgradeCurrLevel == upgradeToCheck.upgradeMaxLevels && level >= 0) ||
			(upgradeToCheck.upgradeCurrLevel == 0 && level <= 0)
		)
	) {
		return false;
	} else {
		var newLevel = rel ? upgradeToCheck + level : level;
		upgradeToCheck.upgradeCurrLevel = clamp(newLevel, 0, upgradeToCheck.upgradeMaxLevels);
		return true;
	}
}