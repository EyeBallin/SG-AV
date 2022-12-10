/// @desc Creates the player entity and registers it, if it doesn't exist already
function createPlayerEntity() {
	if (is_undefined(getEntity(sgID))) {
		var playerEnt = instance_create_depth(room_width/2, room_height/2, 0, obj_sg_av);
		global.ctrlEnt.activeEntities[? sgID] = playerEnt;
		return playerEnt;
	}
	return -1;
}

/// @desc Swaps the enemy's sprite data, setting the mask
function swapEnemySprite(enemyObj, newSpriteIndex) {
	newSpriteIndex = floor(newSpriteIndex);
	if (newSpriteIndex < array_length(enemyObj.enemySpriteArr) && newSpriteIndex >= 0) {
		enemyObj.enemySpriteCurr = newSpriteIndex;
		var newSprInfo = enemyObj.enemySpriteArr[newSpriteIndex];
		enemyObj.mask_index = newSprInfo.enDrawCollMask;
		enemyObj.image_angle = newSprInfo.enDrawRot;
		enemyObj.enemySpriteRotToDir = newSprInfo.enDrawRotFollowDir;
	}
}

/// @desc Registers an entity into the entity map
function regEntity(entID, entObj) {
	if (is_undefined(global.ctrlEnt.activeEntities[? entID])) {
		global.ctrlEnt.activeEntities[? entID] = entObj;
		return true;
	}
	else
		return false;
}

/// @desc Fetches an entity from the entity map based on its ID
function getEntity(entID) {
	var ent = global.ctrlEnt.activeEntities[? entID]
	return ent;
}

/// @desc Destroys an entity, if it exists
function destroyEntity(entID) {
	var gotEnt = getEntity(entID);
	if (!is_undefined(gotEnt)) {
		ds_map_delete(global.ctrlEnt.activeEntities, entID);
		instance_destroy(gotEnt);
		return true;
	}
	return false;
}
	
/// @func damageEntity(trgObj, srcObj, dmgBase, dmgMult, dmgType, dmgPhys, dmgEner, dmgElem, resHitType, dmgSrcType)
/// @desc Deals damage to an entity
function damageEntity(trgObj, srcObj, dmgBase, dmgMult, dmgType, dmgPhys, dmgEner, dmgElem, resHitType, dmgSrcType) {
	var dmgVal = dmgBase;
	
	//End early if invincible!
	if (trgObj.entityInvincible)
		return 0;
		
	//Scale the damage based on multiplier/offensive stats
	dmgVal += dmgPhys + dmgEner;
	dmgVal *= dmgMult;
	
	//Reduce the damage based on resistances
	switch (resHitType) {
		case dmgResHitTypeEnum.eAtt:
			dmgVal *= 1 - trgObj.getStatResAtt().getStatCurr();
			break;
		case dmgResHitTypeEnum.eSpell:
			dmgVal *= 1 - trgObj.getStatResSpell().getStatCurr();
			break;
		case dmgResHitTypeEnum.pProj:
			dmgVal *= 1 - trgObj.getStatResProj().getStatCurr();
			break;
		case dmgResHitTypeEnum.pColl:
			dmgVal *= 1 - trgObj.getStatResColl().getStatCurr();
			break;
	}
		
	//Halve damage if it's the same element as the enemy, or increase it by 50% if it's a favourable matchup
	if (dmgElem != elementTypes.eNone) {
		if (dmgElem  == trgObj.entityElement)
			dmgVal *= 0.5;
		else if (
			(dmgElem == elementTypes.eFire && trgObj.entityElement == elementTypes.eIce) ||
			(dmgElem == elementTypes.eIce && trgObj.entityElement == elementTypes.eWater) ||
			(dmgElem == elementTypes.eWater && trgObj.entityElement == elementTypes.eFire) ||
			(dmgElem == elementTypes.eLight && trgObj.entityElement == elementTypes.eDark) ||
			(dmgElem == elementTypes.eDark && trgObj.entityElement == elementTypes.eLight) ||
			(dmgElem == elementTypes.ePsn && trgObj.entityElement == elementTypes.eElec) ||
			(dmgElem == elementTypes.eElec && trgObj.entityElement == elementTypes.ePsn)
		)
			dmgVal *= 1.5;
	}
		
	//Deal the damage
	trgObj.getStatHP().modifyStat(-dmgVal, false);
	
	//Apply lifesteal
	var dmgLS = 0;
	switch (resHitType) {
		case dmgResHitTypeEnum.eAtt:
			dmgLS = srcObj.getStatLSAtt().getStatCurr();
			break;
		case dmgResHitTypeEnum.eSpell:
			dmgLS = srcObj.getStatLSSpell().getStatCurr();
			break;
		case dmgResHitTypeEnum.pColl:
			dmgLS = srcObj.getStatLSColl().getStatCurr();
			break;
		case dmgResHitTypeEnum.pProj:
			dmgLS = srcObj.getStatLSProj().getStatCurr();
			break;
	}
	
	if (dmgLS > 0) {
		var healVal = dmgVal * dmgLS;
		healEntity(srcObj.getStatHP(), healVal, healType.hLifesteal);
		createDmgPopup(srcObj.x, srcObj.y - 5, healVal, c_lime);
	}
	
	//Make the damage number!
	createDmgPopup(trgObj.x, trgObj.y - 5, dmgVal, #FF0000);
}

/// @func healEntity(healTrgStat, healAmount, healType)
/// @desc Restores the entity's HP or Mana by a specific amount.
function healEntity(healTrgStat, healAmount, healType) {
	healTrgStat.modifyStat(healAmount, false);
}
