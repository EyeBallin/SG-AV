/// @desc Generate on-hit effects
/// @param {Array<Struct.infoOnHitEffect>} ohArr Array of on-hit effect info lines
function dpOnHitEffects(ohArr) {
	var ohStatusApplyBurn = ohArr[onHitIDs.ohApplyBurn];
	ohStatusApplyBurn.addOHInfo("Apply Burn Debuff", "Applies the Burn status effect, which deals damage over time.", -1, elementTypes.eFire);
	ohStatusApplyBurn.ohDataCollCode = function(collX, collY, srcObj, trgObj, dmgSrc) {
		applyStatusEffect(trgObj, srcObj, statusEffects.dbGenBurn, ohStrMult, ohDurMult, ohStackMult);
	};
	
	var ohStatusSignalFlares = ohArr[onHitIDs.ohFireW];
	ohStatusSignalFlares.addOHInfo("Signal Flares", "Explodes into a 3-point star upon destruction. Each point of the explosion can hit enemies - " + 
		"dealing damage, removing Invisibility, and applying Burns and Vuln-Up.", -1, elementTypes.eFire);
	ohStatusSignalFlares.ohDataCollCode = function(collX, collY, srcObj, trgObj, dmgSrc) {
    if (dmgSrc.dmgCategory != dmgSrcTypeEnum.sExpl) {
      var randomRot = random_range(0, 120);
			var compInfo = global.ctrlInfo.infoForms[sgForm.formFire].formWInfo.abilComponentInfo[0];
      for (var i = 0; i < 3; i += 1) {
        createExplosionPlayer(collX, collY, explIDEnum.sgFireW, compInfo, { 
          explDataDir: i * 120 + randomRot,
          explDataMultiParts: true,
          explDataMultiPartsOwner: dmgSrc,
        });
      }
    }
	};
    
	var ohStatusKnockbackFireE = ohArr[onHitIDs.ohFireEKnockback];
  ohStatusKnockbackFireE.addOHInfo("Knockback", "Knocks targets hit away from the centre of the explosion.", -1, elementTypes.eNone);
  ohStatusKnockbackFireE.ohDataCollCode = function(collX, collY, srcObj, trgObj, dmgSrc) {
    applyStatusEffect(trgObj, srcObj, statusEffects.dbGenDisplace, 1, 1, 1, {
      seArgs: {
        knockbackDist: 300 * ohStrMult,
        knockbackDir: point_direction(collX, collY, trgObj.x, trgObj.y)
      }
    });
  };
}