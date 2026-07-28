/// @desc Standard Shot Code (Common)
/// @param {Id.Instance} shipEnt Ship Entity
/// @param {Real} attTimer Duration until next SS
/// @param {Real} extraProjCount How many extra projectiles are left to create (when att spd > 60)
abilCodeStandardShot = function(shipEnt, attTimer, extraProjCount) {
	var actInfo = global.ctrlInfo.infoForms[sgForm.formFire].formSSInfo;
	var thisForm = getCurrForm();
	var formSpdAtt = thisForm.getStatSpdAtt();
	var currAttSpd = formSpdAtt.getStatCurr();
  attTimer += 60/currAttSpd;
  var ssProj = createProjectilePlayer(
    shipEnt.x + (extraProjCount == 0 ? random_range(-15, 15) : 0),
    shipEnt.y-60,
    projIDEnum.ssFire,
    actInfo.abilComponentInfo[0],
		actInfo
  );
	
	extraProjCount = 1;
	
	var inVals = { ssObjArg: ssProj, extraProjCountArg: extraProjCount, attTimerArg: attTimer };
	var outVals = global.ctrlBC.broadcast(sysEvent.evShipSS, inVals);
	
  return {retAttTimer: outVals.attTimerArg, retExtraProj: outVals.extraProjCountArg};
};

/// @desc Fireball Code
/// @param {Id.Instance} shipEnt Ship Entity
/// @param {Real} keyState Key State Macro - inputStateHeld, inputStatePressed, or inputStateReleased
/// @param {Bool} autoFire Whether this ability is being set to autofire or not
abilCodePlayerFireQ = function(shipEnt, keyState, autoFire) {
	if (keyState == inputStatePressed && getCurrForm().formCooldownQ == 0) {
		var actInfo = createFormAbilInfoClone(global.ctrlInfo.infoForms[sgForm.formFire].formQInfo);
		var compInfo = actInfo.abilComponentInfo[0];
		compInfo.attCompBaseValue = getUpgradeValue(sgForm.formFire, shipUpgradeIDs.ugFireAbilQ, shipUpgradeValueIDs.ugvDmgBase);
		compInfo.attCompScaling.scalePhys = getUpgradeValue(sgForm.formFire, shipUpgradeIDs.ugFireAbilQ, shipUpgradeValueIDs.ugvDmgPhys);
		compInfo.attCompScaling.scaleEner = getUpgradeValue(sgForm.formFire, shipUpgradeIDs.ugFireAbilQ, shipUpgradeValueIDs.ugvDmgEner);
		compInfo.attCompSizeScale = getUpgradeValue(sgForm.formFire, shipUpgradeIDs.ugFireAbilQ, shipUpgradeValueIDs.ugvSize);
		
		var inValsA = { actInfoArg: actInfo };
		inValsA = global.ctrlBC.broadcast(sysEvent.evShipQ, inValsA);
		
	  createProjectilePlayer(shipEnt.x, shipEnt.y-60, projIDEnum.spFireFireball, inValsA.actInfoArg.abilComponentInfo[0], inValsA.actInfoArg);
		
		var baseCD = getUpgradeValue(sgForm.formFire, shipUpgradeIDs.ugFireAbilQ, shipUpgradeValueIDs.ugvCooldown);
		var inValsB = { baseCooldown: baseCD, initCooldown: baseCD };
		inValsB = global.ctrlBC.broadcast(sysEvent.evShipQCooldown, inValsB);
		getCurrForm().formCooldownQ = inValsB.initCooldown * 60;
	}
}

/// @desc Signal Flares Code
/// @param {Id.Instance} shipEnt Ship Entity
/// @param {Real} keyState Key State Macro - inputStateHeld, inputStatePressed, or inputStateReleased
/// @param {Bool} autoFire Whether this ability is being set to autofire or not
abilCodePlayerFireW = function(shipEnt, keyState, autoFire) {
	if (keyState == inputStatePressed && getCurrForm().formCooldownW == 0) {
		var actInfo = createFormAbilInfoClone(global.ctrlInfo.infoForms[sgForm.formFire].formWInfo);
		var attInfo = actInfo.abilComponentInfo[0];
		var actInfoBuff = attInfo.attCompStatusEffects[0];
		var buffDurMod = getUpgradeValue(sgForm.formFire, shipUpgradeIDs.ugFireAbilW, shipUpgradeValueIDs.ugvDuration);
		var buffStrMod = actInfoBuff.infoSEStrength;
		
		var inValsA = { actInfoArg: actInfo, extraInfoBuffs: { eiBuffDurArg: buffDurMod, eiBuffStrArg: buffStrMod }};
		inValsA = global.ctrlBC.broadcast(sysEvent.evShipW, inValsA);
		
		applyStatusEffect(shipEnt, shipEnt, statusEffects.bAblFireSignalFlares, inValsA.actInfoArg, inValsA.extraInfoBuffs.eiBuffStrArg, inValsA.extraInfoBuffs.eiBuffDurArg, 1, { 
			compInfo: inValsA.actInfoArg.abilComponentInfo[0]
		}); 
		
		var baseCD = getUpgradeValue(sgForm.formFire, shipUpgradeIDs.ugFireAbilW, shipUpgradeValueIDs.ugvCooldown);
		var inValsB = { baseCooldown: baseCD, initCooldown: baseCD };
		inValsB = global.ctrlBC.broadcast(sysEvent.evShipWCooldown, inValsB);
		getCurrForm().formCooldownW = inValsB.initCooldown * 60;
	}
}

/// @desc Heat Wave Code
/// @param {Id.Instance} shipEnt Ship Entity
/// @param {Real} keyState Key State Macro - inputStateHeld, inputStatePressed, or inputStateReleased
/// @param {Bool} autoFire Whether this ability is being set to autofire or not
abilCodePlayerFireE = function(shipEnt, keyState, autoFire) {
	if (keyState == inputStatePressed && getCurrForm().formCooldownE == 0) {
		var actInfo = global.ctrlInfo.infoForms[sgForm.formFire].formEInfo;
		var actInfoAura = actInfo.abilComponentInfo[0];
		var actInfoExpl = actInfo.abilComponentInfo[1];
		
		actInfoAura.attCompBaseValue = getUpgradeValue(sgForm.formFire, shipUpgradeIDs.ugFireAbilE, shipUpgradeValueIDs.ugvDmgBase);
		actInfoAura.attCompSizeScale = getUpgradeValue(sgForm.formFire, shipUpgradeIDs.ugFireAbilE, shipUpgradeValueIDs.ugvSize);
		
		actInfoExpl.attCompBaseValue = getUpgradeValue(sgForm.formFire, shipUpgradeIDs.ugFireAbilE, shipUpgradeValueIDs.ugvDmgBase2);
		actInfoExpl.attCompSizeScale = getUpgradeValue(sgForm.formFire, shipUpgradeIDs.ugFireAbilE, shipUpgradeValueIDs.ugvSize);
		
		var inValsA = { actInfoArg: actInfo }
		inValsA = global.ctrlBC.broadcast(sysEvent.evShipE, inValsA);
		
		var fireEAura = createAuraPlayer(shipEnt.x, shipEnt.y, auraIDEnum.auFireE, inValsA.actInfoArg.abilComponentInfo[0], inValsA.actInfoArg, {
	    auraDataFollowObj: shipEnt
	  });
	  fireEAura.auraCodeDestroy = function(fireEAura) {
			var actInfoExpl = fireEAura.dmgActionInfo;
	    createExplosionPlayer(fireEAura.x, fireEAura.y, explIDEnum.sgFireE, actInfoExpl.abilComponentInfo[1], actInfoExpl);
	  }
		
		var baseCD = getUpgradeValue(sgForm.formFire, shipUpgradeIDs.ugFireAbilE, shipUpgradeValueIDs.ugvCooldown);
		var inValsB = { baseCooldown: baseCD, initCooldown: baseCD };
		inValsB = global.ctrlBC.broadcast(sysEvent.evShipECooldown, inValsB);
		getCurrForm().formCooldownE = inValsB.initCooldown * 60;
	}
}