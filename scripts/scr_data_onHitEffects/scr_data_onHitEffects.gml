function dpOnHitEffects(ohArr) {
	ohArr[onHitIDs.ohStatusApply].addOHInfo("Apply Status: ", "Applies the specified status effect.", -1);
	ohArr[onHitIDs.ohStatusApply].ohDataCollCode = function(collX, collY, srcObj, trgObj, ohInfo) {
		//TODO: Applying a status effect
	};
	
	ohArr[onHitIDs.ohCreateExpl].addOHInfo("Create Explosion: ", "Creates an explosion upon hitting a target.", -1);
	ohArr[onHitIDs.ohCreateExpl].ohDataCollCode = function(collX, collY, srcObj, trgObj, ohInfo) {
		createExplosionPlayer(collX, collY, ohInfo.explID);	
	};
}