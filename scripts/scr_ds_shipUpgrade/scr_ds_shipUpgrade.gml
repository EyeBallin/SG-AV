/// @param {Enum.shipUpgradeIDs} upgradeIDArg shipupgradeIDs enum of upgrade ID
/// @return {Struct.infoShipUpgrade} Ship upgrade info line
function infoShipUpgrade(upgradeIDArg) constructor {
	infoUpgradeID = upgradeIDArg;
	infoUpgradeName = "";
	infoUpgradeDesc = "";
	infoUpgradeDescLong = "";
	infoUpgradeIcon = spr_singlePixel;
	infoUpgradeForm = sgForm.formFire;
	infoUpgradeMaxLevels = 1;
	infoUpgradePreReqs = [new shipUpgradePreReqInfo(shipUpgradeIDs.ugFireAbilQ, 1)];
	infoUpgradeIsCombo = false;
	infoUpgradeFunctions = [new upgradeFunction(sysEvent.evAugEquip, 0, function(){})];
}

/// @param {Struct.infoShipUpgrade} upgradeInfoStruct Base info struct to populate
/// @param {String} nameArg Name of this upgrade
/// @param {String} descArg Description of this upgrade
/// @param {String} descLongArg Long-form description of this upgrade
/// @param {Asset.GMSprite} iconArg Icon of this upgrade
/// @param {Enum.sgForm} formArg The sgForm enum value for which forn this upgrade is for
/// @param {Real} maxLevelsArg Max amount of levels for this upgrade, min 1
/// @param {Array<Struct.shipUpgradePreReqInfo>} preReqsArg The array of prerequisites this upgrade needs before it can be offered
/// @param {Bool} isComboArg Whether this upgrade is a "combo" upgrade
/// @param {Array<Struct.upgradeFunction>} upgradeFunctionsArg The array of functions that this upgrade has that listen for broadcasts
function populateShipUpgradeInfoLine(upgradeInfoStruct, nameArg, descArg, descLongArg, iconArg, formArg, maxLevelsArg, preReqsArg, isComboArg, upgradeFunctionsArg) {
	upgradeInfoStruct.infoUpgradeName = nameArg;
	upgradeInfoStruct.infoUpgradeDesc = descArg;
	upgradeInfoStruct.infoUpgradeIcon = iconArg;
	upgradeInfoStruct.infoUpgradeMaxLevels = maxLevelsArg;
	upgradeInfoStruct.infoUpgradePreReqs = preReqsArg;
	upgradeInfoStruct.infoUpgradeIsCombo = isComboArg;
	upgradeInfoStruct.infoUpgradeFunctions = upgradeFunctionsArg;
}

/// @desc An upgrade that is a prereq for another upgrade - stores the upgrade ID and its min. required level
/// @param {Enum.shipUpgradeIDs} upgradeIDArg The shipUpgradeIDs enum ID
/// @param {Real} minLevelArg The minimum level this upgrade needs to be at
/// @returns {Struct.shipUpgradePreReqInfo} PreReq info piece
function shipUpgradePreReqInfo(upgradeIDArg, minLevelArg) constructor {
	upgradeID = upgradeIDArg;
	minLevel = minLevelArg;
}

/// @param {Enum.sysEvent} eventIDArg The sysEvent enum value that determines which broadcast this function should listen for
/// @param {Real} priorityArg The priority of this function over others in the same broadcast response (0 is default)
/// @param {Function.Struct} funcCodeArg The function code that's run upon receiving a broadcast
/// @returns {Struct.upgradeFunction} Upgrade function struct
function upgradeFunction(eventIDArg, priorityArg, funcCodeArg) constructor {
	eventID = eventIDArg;
	priority = priorityArg;
	funcCode = funcCodeArg;
}

/// @return {Array<Struct.infoShipUpgrade>} Array of upgrade info lines
function initUpgradeInfo() {
	var upgradeInfoInt = [];
	upgradeInfoInt[countUpgrades-1] = 0;
	for (var i = 0; i < countUpgrades; i += 1) {
		upgradeInfoInt[i] = new infoShipUpgrade(i);
	}
	
	dpUpgrades(upgradeInfoInt);
	
	return upgradeInfoInt;
}