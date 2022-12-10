function createExplosionPlayer(xPos, yPos, explType) {
	var explData = global.ctrlInfo.infoExplosions[explType];
	var currForm = getCurrForm();
	var newExpl = createExplosion(xPos, yPos, explType, getEntity(sgID));
	
	newExpl.depth = -9;
	newExpl.explDmgPhys = explData.explDataDmgScalePhys * currForm.formDmgPhys.getStatCurr();
	newExpl.explDmgEner = explData.explDataDmgScaleEner * currForm.formDmgEner.getStatCurr();
	newExpl.explShipForm = currForm.formID;
		
	return newExpl;
}

function createExplosion(xPos, yPos, explType, explOwner) {
	var explObj = instance_create_depth(xPos, yPos, -4, obj_dmg_expl);
	var explData = global.ctrlInfo.infoExplosions[explType];
	
	explObj.explOwner = explOwner;
	explObj.explSpr = explData.explDataSpr;
	explObj.sprite_index = explData.explDataSpr;
	explObj.mask_index = explData.explDataSpr;
	
	var explShapeType = explData.explDataShapeType;
	explObj.explType = explShapeType;
	switch (explShapeType) {
		case dmgExplShapeEnum.explRound:
			explObj.explMaxScaleX = explData.explDataRoundRadius/sprite_get_width(explData.explDataSpr);
			explObj.explMaxScaleY = explData.explDataRoundRadius/sprite_get_height(explData.explDataSpr);
			break;
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
	explObj.image_angle = explData.explDataSprRot;
	
	explObj.explCodeCreate = method(explObj, explData.explDataCodeCreate);
	explObj.explCodeStep = method(explObj, explData.explDataCodeStep);
	explObj.explCodeDmg = method(explObj, explData.explDataCodeCollide);
	explObj.explCodeDestroy = method(explObj, explData.explDataCodeDestroy);
	
	return explObj;
}