/// @param {real} xPos X Position
/// @param {real} yPos Y Position
/// @param {Enum.explIDEnum} explType
/// @param {Struct.infoAttackComponent} explSourceInfo Explosion Info Obtained from Player
/// @param {Struct} [customData] Custom data to override existing values or pass in new ones
function createExplosionPlayer(xPos, yPos, explType, explSourceInfo, customData) {
	var newExpl = createExplosion(xPos, yPos, explType, getEntity(sgID), explSourceInfo, customData);
	newExpl.depth = -9;
	return newExpl;
}

/// @param {real} xPos X Position
/// @param {real} yPos Y Position
/// @param {Enum.explIDEnum} explType
/// @param {Id.Instance<obj_abs_entity>} explOwner Explosion Owner Object
/// @param {Struct.infoAttackComponent} explSourceInfo Explosion Info Obtained from Player
/// @param {Struct} [customData] Custom data to override existing values or pass in new ones
function createExplosion(xPos, yPos, explType, explOwner, explSourceInfo, customData) {
	var explObj = instance_create_depth(xPos, yPos, 4, obj_dmg_expl);
	var explData = global.ctrlInfo.infoExplosions[explType];
	if (!is_undefined(customData) && variable_struct_names_count(customData) > 0) {
		explData = mergeStructs(explData, customData, true);
	}
	
	explObj.explOwner = explOwner;
	explObj.customData = customData;
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
			break;
	}
	var sizeVar = explData.explDataSizeVar;
	if (sizeVar != 0) {
		var sizeRand = random_range(1-sizeVar, 1+sizeVar);
		explObj.explMaxScaleX *= sizeRand;
		explObj.explMaxScaleY *= sizeRand;
	}
	
	explObj.dmgVal = explSourceInfo.attCompBaseValue;
	explObj.explDmgResHit = explSourceInfo.attCompResHit;
	explObj.explDmgElem = explSourceInfo.attCompElemType;
	explObj.explDmgEdgeMult = explData.explDataEdgeMult;
	explObj.explDmgType = explData.explDataDmgType;
	
	calcDamageScalings(explSourceInfo, explOwner, explObj);
	
	explObj.explColA = explData.explDataColStart;
	explObj.explColB = explData.explDataColMid;
	explObj.explColC = explData.explDataColEnd;
	explObj.explColCurr = explData.explDataColStart;
	explObj.explDur = explData.explDataDur;
	
	if (explSourceInfo.attCompAppliesOnHit) {
		var onHitArr = explOwner.getOnHitEffectsArr();
		for (var i = 0; i < array_length(onHitArr); i += 1) {
			array_push(explObj.dmgOnHitEffects, onHitArr[i]);
    }
	}
	for (var i = 0; i < array_length(explSourceInfo.attCompInherentOnHits); i += 1) {
		var foundOH = explSourceInfo.attCompInherentOnHits[i];
		var inherentOnHit = new onHitEffect(foundOH.infoOHID, {
			ohStrMult: foundOH.infoOHStrength,
			ohDurMult: foundOH.infoOHDur,
			ohStackMult: foundOH.infoOHStacks
		});
		inherentOnHit.ohOwner = explOwner;
		array_push(explObj.dmgIntrinsicOnHitEffects, inherentOnHit);
	}
    
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