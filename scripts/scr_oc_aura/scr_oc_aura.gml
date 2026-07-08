/// @param {real} xPos X Position
/// @param {real} yPos Y Position
/// @param {Enum.auraIDEnum} auraID
/// @param {Struct.infoAttackComponent} auraSourceInfo Aura Info Obtained from Player
/// @param {Struct} [customData] Custom data to override existing values or pass in new ones
function createAuraPlayer(xPos, yPos, auraID, auraSourceInfo, customData) {
  var newAura = createAura(xPos, yPos, auraID, getEntity(sgID), auraSourceInfo, customData);
  newAura.depth = -9;
    
  return newAura;
}

/// @param {real} xPos X Position
/// @param {real} yPos Y Position
/// @param {Enum.auraIDEnum} auraID
/// @param {Id.Instance<obj_abs_entity>} auraOwner Aura Owner Object
/// @param {Struct.infoAttackComponent} auraSourceInfo Aura Info Obtained from Player
/// @param {Struct} [customData] Custom data to override existing values or pass in new ones
function createAura(xPos, yPos, auraID, auraOwner, auraSourceInfo, customData) {
  var auraData = auraID > -1 ? global.ctrlInfo.infoAuras[auraID] : { };
  if (!is_undefined(customData) && variable_struct_names_count(customData) > 0) {
     auraData = mergeStructs(auraData, customData, true);
	}
    
  var createX = xPos;
  var createY = yPos;
  if (auraData.auraDataFollowObj != -1 && instance_exists(auraData.auraDataFollowObj)) {
    createX = auraData.auraDataFollowObj.x + auraData.auraDataFollowOffsetX;
    createY = auraData.auraDataFollowObj.y + auraData.auraDataFollowOffsetY;
  }
  var auraObj = instance_create_depth(createX, createY, 4, obj_dmg_aura);
  auraObj.auraOwner = auraOwner;
  auraObj.auraSpr = auraData.auraDataSpr;
  auraObj.sprite_index = auraData.auraDataSpr;
  auraObj.mask_index = auraData.auraDataSpr;
    
  if (auraData.auraDataFollowObj) {
    auraObj.auraAttachObj = auraData.auraDataFollowObj;
    auraObj.auraAttachOffsetX = auraData.auraDataFollowOffsetX;
    auraObj.auraAttachOffsetY = auraData.auraDataFollowOffsetY;
  }
    
  auraObj.auraRadiusNum = auraData.auraDataRoundRadius;
  if (auraData.auraDataSizeVar != 0) {
    auraObj.auraScale *= clamp(random_range(1 - auraData.auraDataSizeVar, 1 + auraData.auraDataSizeVar), 0, 999);
  }
    
  auraObj.auraDmgVal = auraSourceInfo.attCompBaseValue;
	auraObj.auraDmgResHit = auraSourceInfo.attCompResHit;
	auraObj.auraDmgElem = auraSourceInfo.attCompElemType;
	auraObj.auraDmgEdgeMult = auraData.auraDataEdgeMult;
	
	calcDamageScalings(auraSourceInfo, auraOwner, auraObj);
	
	if (auraSourceInfo.attCompAppliesOnHit) {
		var onHitArr = auraOwner.getOnHitEffectsArr();
		for (var i = 0; i < array_length(onHitArr); i += 1) {
			array_push(auraObj.dmgOnHitEffects, onHitArr[i]);
    }
	}
	for (var i = 0; i < array_length(auraSourceInfo.attCompInherentOnHits); i += 1) {
		var foundOH = auraSourceInfo.attCompInherentOnHits[i];
		var inherentOnHit = new onHitEffect(foundOH.infoOHID, {
			ohStrMult: foundOH.infoOHStrength,
			ohDurMult: foundOH.infoOHDur,
			ohStackMult: foundOH.infoOHStacks
		});
		inherentOnHit.ohOwner = auraOwner;
		array_push(auraObj.dmgIntrinsicOnHitEffects, inherentOnHit);
	}
    
  auraObj.auraCol = auraData.auraDataCol;
  auraObj.auraDur = auraData.auraDataDur;
    
  auraObj.auraCodeCreate = method(auraObj, auraData.auraDataCodeCreate);
	auraObj.auraCodeStep = method(auraObj, auraData.auraDataCodeStep);
	auraObj.auraCodeDmg = method(auraObj, auraData.auraDataCodeCollide);
	auraObj.auraCodeDestroy = method(auraObj, auraData.auraDataCodeDestroy);
    
  global.ctrlBC.broadcast(sysEvent.evObjAuraCreate, [auraObj, auraData]);
    
  auraObj.auraCodeCreate(auraObj);
    
  return auraObj;
}