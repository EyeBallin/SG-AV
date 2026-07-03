/// @func createExplosionPlayer(xPos, yPos, explType, customData)
/// @param xPos
/// @param yPos
/// @param explType
/// @param [customData]
function createExplosionPlayer(xPos, yPos, explType, customData) {
	var explData = global.ctrlInfo.infoExplosions[explType];
	var currForm = getCurrForm();
	var newExpl = createExplosion(xPos, yPos, explType, getEntity(sgID), customData);
	
	newExpl.depth = -9;
	newExpl.explDmgPhys += explData.explDataDmgScalePhys * currForm.formDmgPhys.getStatCurr();
	newExpl.explDmgEner += explData.explDataDmgScaleEner * currForm.formDmgEner.getStatCurr();
	newExpl.explShipForm = currForm.formID;
		
	return newExpl;
}

/// @func createExplosion(xPos, yPos, explType, explOwner, customData)
/// @param xPos
/// @param yPos
/// @param explType
/// @param explOwner
/// @param [customData]
function createExplosion(xPos, yPos, explType, explOwner, customData) {
	var explObj = instance_create_depth(xPos, yPos, 4, obj_dmg_expl);
	var explData = explType > -1 ? global.ctrlInfo.infoExplosions[explType] : {};
	if (!is_undefined(customData) && variable_struct_names_count(customData) > 0)
		explData = mergeStructs(explData, customData, true);
	
	explObj.explOwner = explOwner;
	explObj.explSpr = explData.explDataSpr;
	explObj.sprite_index = explData.explDataSpr;
	explObj.mask_index = explData.explDataSpr;
	
	var explShapeType = explData.explDataShapeType;
	explObj.explType = explShapeType;
	switch (explShapeType) {
		case dmgExplShapeEnum.explRound:
            explObj.explRadiusNum = explData.explDataRoundRadius;
			break;
        case dmgExplShapeEnum.explCone:
            explObj.explConeW = explData.explDataConeW;
            explObj.explDir = explData.explDataDir;
            explObj.explMaxScaleY = explData.explDataConeW/sprite_get_height(explData.explDataSpr);
            explObj.explRadiusNum = explData.explDataRoundRadius;
            break;
        case dmgExplShapeEnum.explRect:
            explObj.explDir = explData.explDataDir;
            explObj.explRectW = explData.explDataRectW;
            explObj.explRectH = explData.explDataRectH;
            explObj.explMaxScaleX = explData.explDataRectH/sprite_get_width(explData.explDataSpr);
            explObj.explMaxScaleY = explData.explDataRectW/sprite_get_height(explData.explDataSpr);
	}
	var sizeVar = explData.explDataSizeVar;
	if (sizeVar != 0) {
		var sizeRand = random_range(1-sizeVar, 1+sizeVar);
		explObj.explMaxScaleX *= sizeRand;
		explObj.explMaxScaleY *= sizeRand;
	}
	
	explObj.explDmgVal = explData.explDataDmgBase;
	explObj.explDmgType = explData.explDataDmgType;
	explObj.explDmgResHit = explData.explDataResHit;
	explObj.explDmgElem = explData.explDataDmgElem;
	explObj.explDmgEdgeMult = explData.explDataEdgeMult;
	
	explObj.explColA = explData.explDataColStart;
	explObj.explColB = explData.explDataColMid;
	explObj.explColC = explData.explDataColEnd;
	explObj.explColCurr = explData.explDataColStart;
	explObj.explDur = explData.explDataDur;
    
    if (explData.explDataMultiParts) {
        explObj.explMultiPartsOwner = explData.explDataMultiPartsOwner;
    }
	
	explObj.explCodeCreate = method(explObj, explData.explDataCodeCreate);
	explObj.explCodeStep = method(explObj, explData.explDataCodeStep);
	explObj.explCodeDmg = method(explObj, explData.explDataCodeCollide);
	explObj.explCodeDestroy = method(explObj, explData.explDataCodeDestroy);
	
    if (explObj.explOwner == sgID) {
    	var broadcastArgs = [explObj, explData];
        broadcastArgs = global.ctrlBC.broadcast(sysEvent.evObjExplCreate, [explObj, explData]);
        explObj = broadcastArgs[0];
    }
    
    explObj.explCodeCreate(explObj);
	
	return explObj;
}