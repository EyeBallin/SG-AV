function collideAura(auraObj, collList) {
    for (var i = 0; i < ds_list_size(collList); i += 1) {
        var collObj = collList[|i];
        
        //Broadcast hit
        var extraMult = 1;
        if (auraObj.auraOwner.entityID == sgID) {
            var argArr = [auraObj, collObj, 1, extraMult, auraObj.dmgCategory]
            argArr = global.ctrlBC.broadcast(sysEvent.evShipDealHit, argArr);
            extraMult = argArr[3];
        };
        
        //If entity doesn't exist, don't continue
        if (!instance_exists(collObj))
            continue;
        
        //Base damage
        damageEntity(collObj, auraObj.auraOwner, auraObj.auraDmgVal, auraObj.auraDmgMult * extraMult, 0, auraObj.auraDmgPhys, auraObj.auraDmgEner,
            auraObj.auraDmgElem, auraObj.auraDmgResHit, auraObj.dmgCategory);
        auraObj.auraCodeDmg(auraObj, collObj);
        
        //On-hit, if applicable
        if (auraObj.auraApplyOnHit) {
            for (var j = 0; j < array_length(auraObj.dmgOnHitEffects); j += 1) {
                auraObj.dmgOnHitEffects[j].ohCodeColl(auraObj.x, auraObj.y, auraObj.auraOwner, collObj, auraObj);
            }
        }
        for (var j = 0; j < array_length(auraObj.dmgIntrinsicOnHitEffects); j += 1) {
            auraObj.dmgIntrinsicOnHitEffects[j].ohCodeColl(auraObj.x, auraObj.y, auraObj.auraOwner, collObj, auraObj);
        }
    }
}