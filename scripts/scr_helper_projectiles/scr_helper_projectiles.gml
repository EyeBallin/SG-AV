function collideProjectile(projObj, collList) {
	//Damage the target
	for (var i = 0; i < ds_list_size(collList); i += 1) {
		//Allow projectiles to only collide with entities X amount of times over their lifetime (usually 1)
		var lifeColl = projObj.lifeCollMap[? collList[|i]];
		if (is_undefined(lifeColl))
			projObj.lifeCollMap[? collList[|i]] = 1;
		else if (lifeColl >= projObj.lifeCollMax)
			continue;
		else
			projObj.lifeCollMap[? collList[|i]] += 1;
		
		//Pierce Multiplier Setup
		var pierceMult = max(1 - (projObj.projPierceCurr * projObj.projPierceDeg), 0);
		var extraMult = 1;
		
		//Broadcast Hit
		if (projObj.projOwner.entityID == sgID) {
			var argArr = [projObj, collList[|i], pierceMult, extraMult, dmgSrcTypeEnum.sProj];
			argArr = global.ctrlBC.broadcast(sysEvent.evShipDealHit, argArr);
			pierceMult = argArr[2];
			extraMult = argArr[3];
		}
		
		//If the entity doesn't exist, don't continue!
		if (!instance_exists(collList[|i]))
			continue;
		
		damageEntity(collList[|i], projObj.projOwner, projObj.projDmgVal, projObj.projDmgMult * pierceMult * extraMult, projObj.projDmgType, projObj.projDmgPhys, projObj.projDmgEner,
			projObj.projDmgElem, projObj.projDmgResHit, dmgSrcTypeEnum.sProj);
		projObj.projCodeDmg(projObj, collList[|i]);
		
		
		//Apply on-hit effects
		//TODO
		
		//Piercing and/or destruction
		projObj.projPierceCurr += 1;
		if (projObj.projPierceMax != -1 && projObj.projPierceCurr > projObj.projPierceMax) {
			projObj.setDeletion = true;
			projObj.x -= lengthdir_x(projSpdCurr/2, projDir);
			projObj.y -= lengthdir_y(projSpdCurr/2, projDir);
			break;
		}
	}
}