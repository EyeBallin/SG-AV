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
    actInfo.abilComponentInfo[0]
  );
  extraProjCount = 1;
  return {retAttTimer: attTimer, retExtraProj: extraProjCount};
};

/// @desc Fireball Code
/// @param {Id.Instance} shipEnt Ship Entity
/// @param {Real} keyState Key State Macro - inputStateHeld, inputStatePressed, or inputStateReleased
/// @param {Bool} autoFire Whether this ability is being set to autofire or not
abilCodePlayerFireQ = function(shipEnt, keyState, autoFire) {
	if (keyState == inputStatePressed) {
		var actInfo = global.ctrlInfo.infoForms[sgForm.formFire].formQInfo;
	  createProjectilePlayer(shipEnt.x, shipEnt.y-60, projIDEnum.spFireFireball, actInfo.abilComponentInfo[0]);
		
		var inVals = { baseCooldown: actInfo.abilCooldown, initCooldown: actInfo.abilCooldown };
		var outVals = global.ctrlBC.broadcast(sysEvent.evShipQCooldown, inVals);
		getCurrForm().formCooldownQ = outVals.initCooldown;
	}
}

/// @desc Signal Flares Code
/// @param {Id.Instance} shipEnt Ship Entity
/// @param {Real} keyState Key State Macro - inputStateHeld, inputStatePressed, or inputStateReleased
/// @param {Bool} autoFire Whether this ability is being set to autofire or not
abilCodePlayerFireW = function(shipEnt, keyState, autoFire) {
	if (keyState == inputStatePressed) {
		var actInfo = global.ctrlInfo.infoForms[sgForm.formFire].formWInfo.abilComponentInfo[0];
		var actInfoBuff = actInfo.attCompStatusEffects[0];
		var buffDurMod = actInfoBuff.infoSEDur;
		var buffStrMod = actInfoBuff.infoSEStrength;
		applyStatusEffect(shipEnt, shipEnt, statusEffects.bAblFireSignalFlares, buffStrMod, buffDurMod, 1, { 
			compInfo: actInfo
		}); 
	}
}

/// @desc Heat Wave Code
/// @param {Id.Instance} shipEnt Ship Entity
/// @param {Real} keyState Key State Macro - inputStateHeld, inputStatePressed, or inputStateReleased
/// @param {Bool} autoFire Whether this ability is being set to autofire or not
abilCodePlayerFireE = function(shipEnt, keyState, autoFire) {
	if (keyState == inputStatePressed) {
		var actInfoAura = global.ctrlInfo.infoForms[sgForm.formFire].formEInfo.abilComponentInfo[0];
		var fireEAura = createAuraPlayer(shipEnt.x, shipEnt.y, auraIDEnum.auFireE, actInfoAura, {
	    auraDataFollowObj: shipEnt
	  });
	  fireEAura.auraCodeDestroy = function(fireEAura) {
			var actInfoExpl = global.ctrlInfo.infoForms[sgForm.formFire].formEInfo.abilComponentInfo[1];
	    createExplosionPlayer(fireEAura.x, fireEAura.y, explIDEnum.sgFireE, actInfoExpl);
	  }
	}
}