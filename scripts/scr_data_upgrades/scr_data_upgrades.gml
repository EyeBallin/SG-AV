/// @param {Array<Struct.infoShipUpgrade>} upgradeInfoArr Array of upgrade info lines
function dpUpgrades(upgradeInfoArr) {
	//Fire Form Upgrades
	populateShipUpgradeInfoLine(upgradeInfoArr[shipUpgradeIDs.ugFireAbilQ], getString("formFireQName"), getString("formFireQDesc"), getString("formFireQDescLong"),
		-1, sgForm.formFire, 5, [], false, []);
}