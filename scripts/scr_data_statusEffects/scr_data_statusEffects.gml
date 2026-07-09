function dpStatusEffectsGeneric(stsArr) {
  var stsKnockback = new infoStatusEffect(statusEffects.dbGenDisplace);
  stsKnockback.addStatusInfo("Knockback", "Currently being displaced in a given direction, unable to take any other actions.", -1, -1, -1, stsParity.stspDebuff,
    elementTypes.eNone, 1, false);
  stsKnockback.stsDataTick = 1;
  stsKnockback.stsDataCodeInit = method(stsKnockback, function() {
    array_push(seOwner.entityInterruptMoveEffects, seIDUnique);
    array_push(seOwner.entityInterruptAttackEffects, seIDUnique);
    seArgs.knockbackPerTick = 30;
    if (is_undefined(seArgs.knockbackDist)) {
      seArgs.knockbackDist = 0;
    }
    if (is_undefined(seArgs.knockbackDir)) {
      seArgs.knockbackDir = 90;
    }
  });
  stsKnockback.stsDataCodeStep = method(stsKnockback, function() {
    if (seArgs.knockbackDist > 0) {
      seArgs.knockbackDist = max(seArgs.knockbackDist - seArgs.knockbackPerTick, 0);
      seOwner.x += lengthdir_x(seArgs.knockbackPerTick, seArgs.knockbackDir);
      seOwner.y += lengthdir_y(seArgs.knockbackPerTick, seArgs.knockbackDir);
      seDurCurr = 999;
    }
    else {
      seDurCurr = 0;
    }
  });
  stsKnockback.stsDataCodeRemoved = method(stsKnockback, function() {
    var idFoundFunc = function(e) {
      return e == seIDUnique;
    }
    array_delete(seOwner.entityInterruptMoveEffects, array_find_index(seOwner.entityInterruptMoveEffects, idFoundFunc), 0);
    array_delete(seOwner.entityInterruptAttackEffects, array_find_index(seOwner.entityInterruptAttackEffects, idFoundFunc), 0);
  });
  stsArr[statusEffects.dbGenDisplace] = stsKnockback;
	
	var stsBurn = new infoStatusEffect(statusEffects.dbGenBurn);
	stsBurn.addStatusInfo("Burn", "Deals Fire-element Spell-type damage over time.", -1, 1, 150, stsParity.stspDebuff, elementTypes.eFire, 1, false);
	stsBurn.stsDataTick = 15;
	stsBurn.stsDataCodeInit = method(stsBurn, function() {
		var physDmg = seSrc.getStatDmgPhys().getStatCurr() * 0.1;
		var enerDmg = seSrc.getStatDmgEner().getStatCurr() * 0.1;
		var dmgVal = 10 + physDmg + enerDmg;
		dmgVal *= seStrCurr;
		seArgs.damagePerTick = dmgVal;
	});
	stsBurn.stsDataCodeStep = method(stsBurn, function() {
		damageEntity(seOwner, seSrc, seArgs.damagePerTick, seStrCurr, elementTypes.eFire, dmgResHitTypeEnum.eSpell);
	});
	stsArr[statusEffects.dbGenBurn] = stsBurn;
	
	var stsVulnUp = new infoStatusEffect(statusEffects.dbGenVulnUp);
	stsVulnUp.addStatusInfo("Vuln-Up", "Increases the bearer's Vulnerability, which increases all damage they take by a percentage.", -1, 1, 150, stsParity.stspDebuff,
		elementTypes.eNone, 1, false);
	stsVulnUp.stsDataCodeInit = method(stsVulnUp, function() {
		seArgs.vulnUpValue = seStrCurr;
		seOwner.getStatVuln().modifyStat(seArgs.vulnUpValue, false);
	});
	stsVulnUp.stsDataCodeRemoved = method(stsVulnUp, function() {
		seOwner.getStatVuln().modifyStat(-seArgs.vulnUpValue, false);
	});
	stsArr[statusEffects.dbGenVulnUp] = stsVulnUp;
}

function dpStatusEffectsBuffsUpgrades(stsArr) {
	var stsFlare = new infoStatusEffect(statusEffects.bAblFireSignalFlares);
	stsFlare.addStatusInfo("Signal Flares", "Standard shots explode to deal AoE damage, remove Invisibility, and apply Vuln-Up.", -1, -1, 60, stsParity.stspBuff, elementTypes.eFire, 1, false);
	stsFlare.stsDataCodeInit = method(stsFlare, function() {
		grantOnHitEffect(seOwner, onHitIDs.ohFireW, seCustomInfo);
		show_debug_message("Flares On!"); 
	});
	stsFlare.stsDataCodeRemoved = method(stsFlare, function() {
		removeOnHitEffect(seOwner, onHitIDs.ohFireW);
		show_debug_message("Flares Off...");
	});
	stsArr[statusEffects.bAblFireSignalFlares] = stsFlare;
}