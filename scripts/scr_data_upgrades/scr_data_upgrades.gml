/// @param {Array<Struct.infoShipUpgrade>} upgradeInfoArr Array of upgrade info lines
function dpUpgrades(upgradeInfoArr) {
	//Fire Form Upgrades
	var formFireQInfo = ctrlInfo().infoForms[sgForm.formFire].formQInfo;
	var formFireWInfo = ctrlInfo().infoForms[sgForm.formFire].formWInfo;
	var formFireEInfo = ctrlInfo().infoForms[sgForm.formFire].formEInfo;
	
	populateShipUpgradeInfoLine(upgradeInfoArr[shipUpgradeIDs.ugFireAbilQ], getString("formFireQName"), getString("formFireQDesc"), getString("formFireQDescLong"),
		-1, sgForm.formFire, 5, [], false, [], [
			new upgradeChangingValue(shipUpgradeValueIDs.ugvManaCost, "Mana Cost", formFireQInfo.abilCostMana, 5, false),
			new upgradeChangingValue(shipUpgradeValueIDs.ugvCooldown, "Cooldown", formFireQInfo.abilCooldown, -0.2, false),
			new upgradeChangingValue(shipUpgradeValueIDs.ugvDmgBase, "Base Damage", formFireQInfo.abilComponentInfo[0].attCompBaseValue, 50, false),
			new upgradeChangingValue(shipUpgradeValueIDs.ugvDmgPhys, "Physical Damage Scaling", formFireQInfo.abilComponentInfo[0].attCompScaling.scalePhys, 0.1, true),
			new upgradeChangingValue(shipUpgradeValueIDs.ugvDmgEner, "Energy Damage Scaling", formFireQInfo.abilComponentInfo[0].attCompScaling.scaleEner, 0.12, true),
			new upgradeChangingValue(shipUpgradeValueIDs.ugvSize, "Fireball Size", ctrlInfo().infoProjectiles[projIDEnum.spFireFireball].projDataSizeX, 0.2, true)
		]);
	
	populateShipUpgradeInfoLine(upgradeInfoArr[shipUpgradeIDs.ugFireAbilW], getString("formFireWName"), getString("formFireWDesc"), getString("formFireWDescLong"),
		-1, sgForm.formFire, 5, [], false, [], [
			new upgradeChangingValue(shipUpgradeValueIDs.ugvCooldown, "Cooldown", formFireWInfo.abilCooldown, -0.5, false),
			new upgradeChangingValue(shipUpgradeValueIDs.ugvDuration, "Signal Flares Buff Duration", formFireWInfo.abilComponentInfo[0].attCompStatusEffects[0].infoSEDur, 0.2, false),
			new upgradeChangingValue(shipUpgradeValueIDs.ugvDmgBase, "Base Damage", formFireWInfo.abilComponentInfo[0].attCompBaseValue, 10, false),
		]);
		
	populateShipUpgradeInfoLine(upgradeInfoArr[shipUpgradeIDs.ugFireAbilE], getString("formFireEName"), getString("formFireEDesc"), getString("formFireEDescLong"),
		-1, sgForm.formFire, 5, [], false, [], [
			new upgradeChangingValue(shipUpgradeValueIDs.ugvCooldown, "Cooldown", formFireEInfo.abilCooldown, -1, false),
			new upgradeChangingValue(shipUpgradeValueIDs.ugvDmgBase, "Aura Base Damage", formFireEInfo.abilComponentInfo[0].attCompBaseValue, 5, false),
			new upgradeChangingValue(shipUpgradeValueIDs.ugvDmgBase2, "Explosion Base Damage", formFireEInfo.abilComponentInfo[1].attCompBaseValue, 30, false),
			new upgradeChangingValue(shipUpgradeValueIDs.ugvSize, "Aura & Explosion Size", formFireEInfo.abilComponentInfo[1].attCompSizeScale, 0.1, true)
		]);
}