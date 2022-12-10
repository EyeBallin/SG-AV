function infoProjLine(newProjID) constructor {
	projDataID = newProjID;
	
	projDataSpr = -1;
	projDataDmgBase = 0;
	projDataDmgScalePhys = 0;
	projDataDmgScaleEner = 0;
	projDataDmgType = dmgProjTypeEnum.projOther;
	projDataResHit = dmgResHitTypeEnum.pViral;
	projDataDmgElem = elementTypes.eNone;
	
	projDataPierceAmt = 0;
	projDataPierceDegrade = 1;

	projDataSpd = 1;
	projDataSpdVar = 0;
	projDataDir = 0;
	projDataDirVar = 0;
	projDataAcc = 0;
	projDataAccVar = 0;

	projDataSizeX = 1;
	projDataSizeY = 1;
	projDataScaleVar = 0;
	projDataSprRotWithDir = true;
	
	projDataCodeCreate = function() {};
	projDataCodeStep = function() {};
	projDataCodeCollide = function() {};
	projDataCodeDestroy = function() {};
	
	/// @func addProjInfo(prSprInfo, prDmgInfo, prMoveInfo)
	/// @desc Sets all basic info
	addProjInfo = function(prSprInfo, prDmgInfo, prMoveInfo) {
		projDataSpr = prSprInfo.prSpr;
		projDataSizeX = prSprInfo.prSizeX;
		projDataSizeY = prSprInfo.prSizeY;
		projDataSprRotWithDir = prSprInfo.prRotWithDir;
		projDataScaleVar = prSprInfo.prScaleVar;
		
		projDataDmgBase = prDmgInfo.prBase;
		projDataDmgScalePhys = prDmgInfo.prPhys;
		projDataDmgScaleEner = prDmgInfo.prEner;
		projDataDmgType = prDmgInfo.prType;
		projDataDmgElem = prDmgInfo.prElem;
		projDataResHit = prDmgInfo.prResHit;

		projDataSpd = prMoveInfo.prSpd;
		projDataSpdVar = prMoveInfo.prSpdVar;
		projDataDir = prMoveInfo.prDir;
		projDataDirVar = prMoveInfo.prDirVar;
		projDataAcc = prMoveInfo.prAcc;
		projDataAccVar = prMoveInfo.prAccVar;
		projDataPierceAmt = prMoveInfo.prPierceAmt;
		projDataPierceDegrade = prMoveInfo.prPierceDeg;
	}
}

function initProjInfo() {
	infoProjectiles[countProjID-1] = 0;
	
	for (var i = 0; i < countProjID; i += 1)
		infoProjectiles[i] = new infoProjLine(i);
		
	dpProjectilesPlayerFire(infoProjectiles);
	dpProjectilesPlayerElec(infoProjectiles);
	dpProjectilesPlayerPsn(infoProjectiles);
	dpProjectilesPlayerIce(infoProjectiles);
	dpProjectilesPlayerLight(infoProjectiles);
	dpProjectilesPlayerDark(infoProjectiles);
	dpProjectilesPlayerSiege(infoProjectiles);
	dpProjectilesPlayerPower(infoProjectiles);
}