function createProjectilePlayer(posX, posY, projType) {
	var projInfo = global.ctrlInfo.infoProjectiles[projType];
	var currForm = getCurrForm();
	var newProj = createProjectile(posX, posY, projType, getEntity(sgID));
	
	newProj.depth = -10;
	newProj.projDmgPhys = projInfo.projDataDmgScalePhys * currForm.formDmgPhys.getStatCurr();
	newProj.projDmgEner = projInfo.projDataDmgScaleEner * currForm.formDmgEner.getStatCurr();
	newProj.projShipForm = currForm.formID;
		
	return newProj;
}

function createProjectile(posX, posY, projType, projOwner) {
	var newProj = instance_create_depth(posX, posY, -5, obj_dmg_proj);
	var projInfo = global.ctrlInfo.infoProjectiles[projType];
	newProj.projOwner = projOwner;
	newProj.projSpr = projInfo.projDataSpr;
	newProj.projSprRotDir = projInfo.projDataSprRotWithDir;
	newProj.projSizeX = projInfo.projDataSizeX + random_range(-projInfo.projDataScaleVar, projInfo.projDataScaleVar);
	newProj.projSizeY = projInfo.projDataSizeY + random_range(-projInfo.projDataScaleVar, projInfo.projDataScaleVar);
	newProj.sprite_index = newProj.projSpr;
	newProj.mask_index = newProj.projSpr;
	newProj.image_xscale = newProj.projSizeX;
	newProj.image_yscale = newProj.projSizeY;
	
	//Set projectile sides
	newProj.projSideLength = newProj.projSprRotDir ? newProj.sprite_height/2 : newProj.sprite_width/2;
	
	newProj.projDmgVal = projInfo.projDataDmgBase;
	newProj.projDmgType = projInfo.projDataDmgType;
	newProj.projDmgResHit = projInfo.projDataResHit;
	newProj.projDmgElem = projInfo.projDataDmgElem;
	
	newProj.projPierceMax = projInfo.projDataPierceAmt;
	newProj.projPierceDeg = projInfo.projDataPierceDegrade;
	
	newProj.projSpdBase = projInfo.projDataSpd + random_range(-projInfo.projDataSpdVar, projInfo.projDataSpdVar);
	newProj.projSpdCurr = newProj.projSpdBase;
	newProj.projDir = projInfo.projDataDir + random_range(-projInfo.projDataDirVar, projInfo.projDataDirVar);
	newProj.dirPrev = newProj.projDir;
	newProj.projAcc = projInfo.projDataAcc + random_range(-projInfo.projDataAccVar, projInfo.projDataAccVar);
	
	newProj.projCodeCreate = method(newProj, projInfo.projDataCodeCreate);
	newProj.projCodeStep = method(newProj, projInfo.projDataCodeStep);
	newProj.projCodeDmg = method(newProj, projInfo.projDataCodeCollide);
	newProj.projCodeDestroy = method(newProj, projInfo.projDataCodeDestroy);
	
	if (newProj.projSprRotDir)
		newProj.image_angle = newProj.projDir;
	
	return newProj;
}