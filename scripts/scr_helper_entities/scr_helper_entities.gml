/// @desc Creates the player entity and registers it, if it doesn't exist already
function createPlayerEntity() {
	if (is_undefined(getEntity(sgID))) {
		var playerEnt = instance_create_depth(room_width/2, room_height/2, 500, obj_sg_av);
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

/// @desc Deals damage to an entity
function damageEntity(trgObj, srcObj, dmgBase, dmgMult, dmgElem, resHitType) {
	var dmgVal = dmgBase;
	
	//End early if invincible!
	if (trgObj.entityInvincible)
		return 0;
		
	//Increase damage by multipliers
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

/// @desc Restores the entity's HP or Mana by a specific amount.
function healEntity(healTrgStat, healAmount, healType) {
	healTrgStat.modifyStat(healAmount, false);
}

/// @desc Apply a status effect to a target.
/// @param {Id.Instance} trgObj The target object
/// @param srcObj The source of the effect, if there is one
/// @param seID The effect's ID
/// @param [strMod] A multiplier to the strength of the debuff
/// @param [durMod] A multiplier to the duration of the debuff
/// @param [stacks] How many stacks of the debuff should be applied
/// @param [customData] Custom modifications to the effect
function applyStatusEffect(trgObj, srcObj, seID, strMod = 1, durMod = 1, stacks = 1, customData = {}) {
	var newEffect = new statusEffect(seID, customData);
	newEffect.seStrCurr *= strMod;
	newEffect.seDurCurr *= durMod;
	newEffect.seSrc = srcObj;
	
	var foundExisting = false;
	var seArr = trgObj.getStatusEffectsArr();
	for (var i = 0; i < array_length(seArr); i += 1) {
		var foundSE = seArr[i];
		if (foundSE.seID == seID) {
			var seStacks = min(foundSE.seStacksCurr + stacks, newEffect.seStacksMax);
			foundSE = newEffect;
			newEffect.seStacksCurr = seStacks;
			newEffect.seOwner = trgObj;
			newEffect.seCodeInit();
			foundExisting = true;
			break;
		}
	}
	
	if (!foundExisting) {
		array_push(seArr, newEffect);
		newEffect.seOwner = trgObj;
		newEffect.seStacksCurr = stacks;
		newEffect.seCodeInit();
	}
}

/// @func removeStatusEffect(trgObj, seID)
/// @desc Remove a status effect from a target
/// @param trgObj
/// @param seID
function removeStatusEffect(trgObj, seID) {
	var seArr = trgObj.getStatusEffectsArr();
	for (var i = 0; i < array_length(seArr); i += 1) {
		if (seArr[i].seID == seID) {
			seArr[i].seCodeRemoved();
			seArr[i] = {};
			array_delete(seArr, i, 1);
		break;
		}
	}
}

/// @func clearStatusEffects(trgObj, seType, [seElem])
/// @desc Clear all status effects of a given type (or all with -1), optionally filtered by element
/// @param trgObj
/// @param seType
/// @param [seElem]
function clearStatusEffects(trgObj, seType, seElem) {
	var seArr = trgObj.getStatusEffectsArr();
	var hasRemovedAny = false;
	for (var i = 0; i < array_length(seArr); i += 1) {
		if ((seType == -1 || seType == seArr[i].seParity) && (is_undefined(seElem) || seElem == seArr[i].seElem)) {
			hasRemovedAny = true;
			seArr[i].seCodeRemoved();
			seArr[i] = -1;
		}
	}
	
	if (hasRemovedAny)
		trgObj.setStatusEffectsArr(array_filter(seArr, function (e, i) { return e != -1 }));
}

/// @func grantOnHitEffect(trgObj, ohID, customData)
/// @desc Grants an on-hit effect to the target
/// @param trgObj
/// @param ohID
/// @param [customData]
function grantOnHitEffect(trgObj, ohID, customData) {
	var newEffect = new onHitEffect(ohID, customData);
	newEffect.ohOwner = trgObj;
	
	var foundExisting = false;
	var ohArr = trgObj.getOnHitEffectsArr();
	for (var i = 0; i < array_length(ohArr); i += 1) {
		if (ohArr[i].ohID == ohID) {
			ohArr[i] = newEffect;
			newEffect.ohOwner = trgObj;
			newEffect.ohCodeInit();
			foundExisting = true;
			break;
		}
	}
	
	if (!foundExisting) {
		array_push(ohArr, newEffect);
		newEffect.ohOwner = trgObj;
		newEffect.ohCodeInit();
	}
}

/// @func removeOnHitEffect(trgObj, ohID)
/// @desc Removes an on-hit effect from the target
function removeOnHitEffect(trgObj, ohID) {
	var ohArr = trgObj.getOnHitEffectsArr();
	for (var i = 0; i < array_length(ohArr); i += 1) {
		if (ohArr[i].ohID == ohID) {
			ohArr[i] = {};
			array_delete(ohArr, i, 1);
			break;
		}
	}
}