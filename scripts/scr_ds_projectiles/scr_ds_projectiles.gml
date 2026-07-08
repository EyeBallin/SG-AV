function infoProjLine(newProjID) constructor {
	projDataID = newProjID;
	
	projDataSpr = -1;

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
  projDataCodeDraw = function() {};
	projDataCodeCollide = function() {};
	projDataCodeDestroy = function() {};
	
	/// @func addProjInfo(prSprInfo, prMoveInfo)
	/// @desc Sets all basic info
  /// @return {undefined}
	addProjInfo = function(prSprInfo, prMoveInfo) {
		projDataSpr = prSprInfo.prSpr;
		projDataSizeX = prSprInfo.prSizeX;
		projDataSizeY = prSprInfo.prSizeY;
		projDataSprRotWithDir = prSprInfo.prRotWithDir;
		projDataScaleVar = prSprInfo.prScaleVar;

		projDataSpd = prMoveInfo.prSpd;
		projDataSpdVar = prMoveInfo.prSpdVar;
		projDataDir = prMoveInfo.prDir;
		projDataDirVar = prMoveInfo.prDirVar;
		projDataAcc = prMoveInfo.prAcc;
		projDataAccVar = prMoveInfo.prAccVar;
	}
}

/// @function       initProjInfo()
/// @return         {Array<Struct.infoProjLine>}
function initProjInfo() {
	var infoProjectilesInt;
  infoProjectilesInt[countProjID-1] = 0;
	
	for (var i = 0; i < countProjID; i += 1)
		infoProjectilesInt[i] = new infoProjLine(i);
		
	dpProjectilesPlayerFire(infoProjectilesInt);
	dpProjectilesPlayerElec(infoProjectilesInt);
	dpProjectilesPlayerPsn(infoProjectilesInt);
	dpProjectilesPlayerIce(infoProjectilesInt);
	dpProjectilesPlayerLight(infoProjectilesInt);
	dpProjectilesPlayerDark(infoProjectilesInt);
	dpProjectilesPlayerSiege(infoProjectilesInt);
	dpProjectilesPlayerPower(infoProjectilesInt);
    
  return infoProjectilesInt;
}