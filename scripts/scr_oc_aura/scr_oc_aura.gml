function createAuraPlayer(xPos, yPos, auraID, customData) {
    var auraData = auraID > -1 ? global.ctrlInfo.infoAuras[auraID] : { };
    var currForm = getCurrForm();
    var newAura = createAura(xPos, yPos, auraID, getEntity(sgID), customData);
    
    newAura.depth = -9;
    newAura.auraDmgPhys += auraData.auraDataDmgScalePhys * currForm.formDmgPhys.getStatCurr();
	newAura.auraDmgEner += auraData.auraDataDmgScaleEner * currForm.formDmgEner.getStatCurr();
	newAura.auraShipForm = currForm.formID;
    
    return newAura;
}

function createAura(xPos, yPos, auraID, auraOwner, customData) {
    var auraData = auraID > -1 ? global.ctrlInfo.infoAuras[auraID] : { };
    if (!is_undefined(customData) && variable_struct_names_count(customData) > 0)
        auraData = mergeStructs(auraData, customData, true);
    
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
    
    auraObj.auraDmgVal = auraData.auraDataDmgBase;
	auraObj.auraDmgResHit = auraData.auraDataResHit;
	auraObj.auraDmgElem = auraData.auraDataDmgElem;
	auraObj.auraDmgEdgeMult = auraData.auraDataEdgeMult;
    
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