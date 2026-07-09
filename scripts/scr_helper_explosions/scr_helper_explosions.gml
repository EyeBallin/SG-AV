/// @desc Function that determines what happens to all entities within an explosion's radius when it appears.
/// @param {id.Instance} explObj Explosion object instance.
/// @param {id.DsList<Id.Instance>} collList List of all entities within the explosion's radius.
function collideExplosion(explObj, collList) {
  for (var i = 0; i < ds_list_size(collList); i += 1) {
    var collObj = collList[|i];
    
    //Exit early if multi-hit or doesn't exist
    if (!instance_exists(collObj) || (explObj.explMultiPartsOwner != -1 && array_contains(collObj.entityMultiPartHitTrack, explObj.explMultiPartsOwner)))
      continue;
    
    //Broadcast hit
    var extraMult = 1;
    if (explObj.explOwner.entityID == sgID) {
      var argArr = [explObj, collObj, 1, extraMult, explObj.dmgCategory]
      argArr = global.ctrlBC.broadcast(sysEvent.evShipDealHit, argArr);
      extraMult = argArr[3];
    };
    
    //If entity doesn't exist, don't continue
    if (!instance_exists(collObj))
      continue;
    
    //Base damage
    damageEntity(collObj, explObj.explOwner, explObj.dmgVal, explObj.dmgMult * extraMult, explObj.explDmgElem, explObj.explDmgResHit);
    explObj.explCodeDmg(explObj, collObj);
    if (explObj.explMultiPartsOwner != -1) {
      array_push(collObj.entityMultiPartHitTrack, explObj.explMultiPartsOwner);
    }
    
    //On-hit, if applicable
    if (explObj.explApplyOnHit) {
      for (var j = 0; j < array_length(explObj.dmgOnHitEffects); j += 1) {
        explObj.dmgOnHitEffects[j].ohCodeColl(explObj.x, explObj.y, explObj.explOwner, collObj, explObj);
      }
    }
    for (var j = 0; j < array_length(explObj.dmgIntrinsicOnHitEffects); j += 1) {
      explObj.dmgIntrinsicOnHitEffects[j].ohCodeColl(explObj.x, explObj.y, explObj.explOwner, collObj, explObj);
    }
  }
}