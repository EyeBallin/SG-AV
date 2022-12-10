function infoEnemyLine(enemyID) constructor {
	enDataID = enemyID;
	enDataName = "Null Name";
	enDataDesc = "Null Desc";
	enDataType = entityTypes.eEnemyNormal;
	
	enDataDrawInfo = [];
	
	enDataStats = {
		endsHP: 100,
		endsShield: 0,
		endsHPRegen: 0,
		endsSpeedMove: 1,
		endsSpeedAtt: 1,
		endsLSAtt: 0,
		endsLSColl: 0,
		endsDmgAtt: 1,
		endsDmgColl: 1,
		endsResGlobal: 0,
		endsResAtt: 0,
		endsResSpell: 0,
		endsResElem: 0,
		endsResCC: 0,
		endsElemType: elementTypes.eNone
	}
	
	enDataDropGold = 0;
	enDataDropData = 0;
	enDataDropItemType = -1; //TODO: Replace when item macros exist with "none"
	enDataDropItemChance = 0;
	
	enDataCodeSpawn = function() {};
	enDataCodeStep = function() {};
	enDataCodeDestroy = function() {};
	enDataCodeDraw = function() {};
	
	/// @func addEnemyInfoBasic(eiName, eiType, eiDesc, eiGold, eiData, eiItemType, eiItemChance, eiSprites, eiCollMask, eiCollScale)
	/// @desc Populates the basic info of the enemy data entry. Doesn't populate stats or scripts.
	addEnemyInfoBasic = function(eiName, eiType, eiDesc, eiGold, eiData, eiItemType, eiItemChance, eiSprites, eiCollMask, eiCollScale) {
		enDataName = eiName;
		enDataType = eiType;
		enDataDesc = eiDesc;
		enDataDropGold = eiGold;
		enDataDropData = eiData;
		enDataDropItemType = eiItemType;
		enDataDropItemChance = eiItemChance;
		enDataDrawInfo = eiSprites;
		enDataCollMask = eiCollMask;
		enDataCollScale = eiCollScale;
	}
	
	/// @func addEnemyInfoStats(eiHP, eiShield, eiHPRegen, eiSpeedMove, eiSpeedAtt, eiLSAtt, eiLSColl, eiDmgAtt, eiDmgColl, eiResGl, eiResAtt, eiResSpell, eiResElem, eiResCC, eiElemType)
	/// @desc Populates the stats of the enemy data entry.
	addEnemyInfoStats = function(eiHP, eiShield, eiHPRegen, eiSpeedMove, eiSpeedAtt, eiLSAtt, eiLSColl, eiDmgAtt, eiDmgColl, eiResGl, eiResAtt, eiResSpell, eiResElem, eiResCC, eiElemType) {
		enDataStats = {
			endsHP: eiHP,
			endsShield: eiShield,
			endsHPRegen: eiHPRegen,
			endsSpeedMove: eiSpeedMove,
			endsSpeedAtt: eiSpeedAtt,
			endsLSAtt: eiLSAtt,
			endsLSColl: eiLSColl,
			endsDmgAtt: eiDmgAtt,
			endsDmgColl: eiDmgColl,
			endsResGlobal: eiResGl,
			endsResAtt: eiResSpell,
			endsResSpell: eiResSpell,
			endsResElem: eiResElem,
			endsResCC: eiResCC,
			endsElemType: eiElemType,
		}
	}
}


/// @func infoEnemyDrawLine(drawSpr, drawSprSub, drawW, drawH, drawBlend, drawAlpha, drawRot, drawRotFollowDir, drawCollMask)
/// @desc Creates a new line of data for a sprite that an enemy can use.
function infoEnemyDrawLine(drawSpr, drawSprSub, drawW, drawH, drawBlend, drawAlpha, drawRot, drawRotFollowDir, drawCollMask) constructor {
	enDrawSpr = drawSpr;
	enDrawSprSub = drawSprSub;
	enDrawW = drawW;
	enDrawH = drawH;
	enDrawBlend = drawBlend;
	enDrawAlpha = drawAlpha;
	enDrawRot = drawRot;
	enDrawRotFollowDir = drawRotFollowDir;
	enDrawCollMask = drawCollMask;
}

function initEnemyInfo() {
	infoEnemies[countEnemies - 1] = 0;
	
	for (var i = 0; i < countEnemies; i += 1)
		infoEnemies[i] = new infoEnemyLine(i);
		
	dpEnemies(infoEnemies);
}