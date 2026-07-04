function dpOnHitEffects(ohArr) {
	ohArr[onHitIDs.ohStatusApply].addOHInfo("Apply Status: ", "Applies the specified status effect.", -1, elementTypes.eNone);
	ohArr[onHitIDs.ohStatusApply].ohDataCollCode = function(collX, collY, srcObj, trgObj, dmgSrc) {
		applyStatusEffect(trgObj, srcObj, )
	};
	
	ohArr[onHitIDs.ohCreateExpl].addOHInfo("Create Explosion: ", "Creates an explosion upon hitting a target.", -1, elementTypes.eNone);
	ohArr[onHitIDs.ohCreateExpl].ohDataCollCode = function(collX, collY, srcObj, trgObj, dmgSrc) {
		createExplosionPlayer(collX, collY, explIDEnum.sgTest);	
	};
	
	ohArr[onHitIDs.ohFireW].addOHInfo("Signal Flares", "Explodes into a 3-point star upon destruction. Each point of the explosion can hit enemies - " + 
		"dealing damage, removing Invisibility, and applying Burns and Res-Down.", -1, elementTypes.eFire);
	ohArr[onHitIDs.ohFireW].ohDataCollCode = function(collX, collY, srcObj, trgObj, dmgSrc) {
    if (dmgSrc.dmgCategory != dmgSrcTypeEnum.sExpl) {
      var randomRot = random_range(0, 120);
      for (var i = 0; i < 3; i += 1) {
        createExplosionPlayer(collX, collY, explIDEnum.sgFireW, { 
          explDataDir: i * 120 + randomRot,
          explDataMultiParts: true,
          explDataMultiPartsOwner: dmgSrc
        });
      }
    }
	};
    
  ohArr[onHitIDs.ohFireEKnockback].addOHInfo("Knockback", "Knocks targets hit away from the centre of the explosion.", -1, elementTypes.eNone);
  ohArr[onHitIDs.ohFireEKnockback].ohDataCollCode = function(collX, collY, srcObj, trgObj, dmgSrc) {
    applyStatusEffect(trgObj, srcObj, statusEffects.dbGenDisplace, 1, 1, {
      seArgs: {
        knockbackDist: 300,
        knockbackDir: point_direction(collX, collY, trgObj.x, trgObj.y)
      }
    });
  };
}