/// @desc Creates a projectile owned by the player, automatically applying Phys / Energy Dmg scalings
/// @param {real} posX X Position
/// @param {real} posY Y Position
/// @param {enum<projIDEnum>} projType Projectile Type ID
/// @param {Struct.infoAttackComponent} projSourceInfo Projectile Info Obtained from Player
/// @returns {Id.Instance<obj_dmg_proj>} Projectile Object
function createProjectilePlayer(posX, posY, projType, projSourceInfo) {
	var newProjPlayer = createProjectile(posX, posY, projType, getEntity(sgID), projSourceInfo);
    newProjPlayer.depth = -10;
    
	//newProjPlayer.projDmgPhys += projInfo.projDataDmgScalePhys * currForm.formDmgPhys.getStatCurr();
	//newProj.projDmgEner += projInfo.projDataDmgScaleEner * currForm.formDmgEner.getStatCurr();
		
	return newProjPlayer;
}

/// @desc Creates a projectile, given a position, type ID, and owner
/// @param {real} posX X Position
/// @param {real} posY Y Position
/// @param {enum.projIDEnum} projType Projectile Type ID
/// @param {Id.Instance<obj_abs_entity>} projOwner Projectile Owner Object
/// @param {Struct.infoAttackComponent} projSourceInfo Projectile Attack Info
/// @returns {Id.Instance<obj_dmg_proj>} Projectile Object
function createProjectile(posX, posY, projType, projOwner, projSourceInfo) {
	var newProj = instance_create_depth(posX, posY, 3, obj_dmg_proj);
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
    
    newProj.projDmgVal = projSourceInfo.attCompBaseValue;
    
    var dmgScalings = projSourceInfo.attCompScaling;
    var scalingVals = variable_struct_get_names(dmgScalings);
	
    for (var i = 0; i < array_length(scalingVals); i += 1) {
        var scalingKey = scalingVals[i];
        var gotScaling = dmgScalings[$ scalingKey];
        switch (scalingKey) {
            case "scalePhys":
                break;
            case "scaleEner":
                break;
            case "scaleHPCurr":
                break;
            case "scaleHPMax":
                break;
            case "scaleHPMissing":
                break;
            case "scaleEnemyHPCurr":
                break;
            case "scaleEnemyHPMax":
                break;
            case "scaleEnemyHPMissing":
                break;
            case "scaleManaCurr":
                break;
            case "scaleManaMax":
                break;
            case "scaleManaMissing":
                break;
            case "scaleAttSpeed":
                break;
        }
    }
	
	//Set projectile sides
	newProj.projSideLength = newProj.projSprRotDir ? newProj.sprite_height/2 : newProj.sprite_width/2;
	
	newProj.projSpdBase = projInfo.projDataSpd + random_range(-projInfo.projDataSpdVar, projInfo.projDataSpdVar);
	newProj.projSpdCurr = newProj.projSpdBase;
	newProj.projDir = projInfo.projDataDir + random_range(-projInfo.projDataDirVar, projInfo.projDataDirVar);
	newProj.dirPrev = newProj.projDir;
	newProj.projAcc = projInfo.projDataAcc + random_range(-projInfo.projDataAccVar, projInfo.projDataAccVar);
	
	newProj.projCodeCreate = method(newProj, projInfo.projDataCodeCreate);
	newProj.projCodeStep = method(newProj, projInfo.projDataCodeStep);
	newProj.projCodeDmg = method(newProj, projInfo.projDataCodeCollide);
	newProj.projCodeDestroy = method(newProj, projInfo.projDataCodeDestroy);
    newProj.projCodeDraw = method(newProj, projInfo.projDataCodeDraw);
	
	if (newProj.projSprRotDir)
		newProj.image_angle = newProj.projDir;
	
	if (newProj.projCanApplyOnHit) {
		var onHitArr = projOwner.getOnHitEffectsArr();
		for (var i = 0; i < array_length(onHitArr); i += 1)
			array_push(newProj.dmgOnHitEffects, onHitArr[i]);
	}
		
	global.ctrlBC.broadcast(sysEvent.evObjProjCreate, [newProj, projInfo]);
	
    newProj.projCodeCreate(newProj);
	return newProj;
}