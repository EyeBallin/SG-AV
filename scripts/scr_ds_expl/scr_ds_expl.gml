function infoExplLine(explID) constructor {
	explDataID = explID;
	
	explDataSpr = -1;
	explDataDmgBase = 0;
	explDataDmgScalePhys = 0;
	explDataDmgScaleEner = 0;
	explDataDmgType = dmgExplTypeEnum.explBoom;
	explDataResHit = dmgResHitTypeEnum.pViral;
	explDataDmgElem = elementTypes.eNone;
	
	explDataEdgeMult = 1;
	explDataShapeType = dmgExplShapeEnum.explRound;
	explDataRoundRadius = 0;
	explDataSizeVar = 0;
	explDataSprRot = 0;
	explDataColStart = #FFFFFF;
	explDataColMid = #888888;
	explDataColEnd = #000000;
	explDataDur = 30;
	
	explDataCodeCreate = function() {};
	explDataCodeStep = function() {};
	explDataCodeCollide = function() {};
	explDataCodeDestroy = function() {};
	
	/// @func addExplInfo(exSprInfo, exDmgInfo)
	addExplInfo = function(exSprInfo, exDmgInfo) {
		explDataSpr = exSprInfo.exSpr;
		explDataShapeType = exSprInfo.exShape;
		explDataSizeVar = exSprInfo.exSizeVar;
		explDataSprRot = exSprInfo.exSprRotDir;
		explDataColStart = exSprInfo.exColA;
		explDataColMid = exSprInfo.exColB;
		explDataColEnd = exSprInfo.exColC;
		explDataDur = exSprInfo.exDur;
		
		explDataDmgBase = exDmgInfo.exBase;
		explDataDmgScalePhys = exDmgInfo.exPhys;
		explDataDmgScaleEner = exDmgInfo.exEner;
		explDataDmgType = exDmgInfo.exDmgType;
		explDataResHit = exDmgInfo.exResHit;
		explDataDmgElem = exDmgInfo.exElem;
		explDataEdgeMult = exDmgInfo.exEdgeMult;
		explDataRoundRadius = exDmgInfo.exRoundRad;
	}
}

function initExplInfo() {
	infoExplosions[countExplID-1] = 0;
	
	for (var i = 0; i < countExplID; i += 1)
		infoExplosions[i] = new infoExplLine(i);
		
	dpExplosionsPlayer(infoExplosions);
}