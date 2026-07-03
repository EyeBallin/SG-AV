//feather disable GM1020

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
    
    explDataDir = 0;
    explDataConeW = 60;
    explDataRectW = 60;
    explDataRectH = 60;
    
    explDataMultiParts = false;
    explDataMultiPartsOwner = -1;
	
	explDataCodeCreate = function() {};
	explDataCodeStep = function() {};
	explDataCodeCollide = function() {};
	explDataCodeDestroy = function() {};
	
	/// @func addExplInfo(exSprInfo, exDmgInfo, exUniqueInfo)
	addExplInfo = function(exSprInfo, exDmgInfo, exUniqueInfo) {
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
        
        switch(exSprInfo.exShape) {
            case dmgExplShapeEnum.explCone:
                explDataDir = exUniqueInfo.exDir;
                explDataConeW = exUniqueInfo.exConeW;
                break;
            case dmgExplShapeEnum.explRect:
                explDataDir = exUniqueInfo.exDir;
                explDataRectW = exUniqueInfo.exRectW;
                explDataRectH = exUniqueInfo.exRectH;
                break;
        }
	}
	
	StructCOPYSTART infoExplLine StructCOPYEND
}

function initExplInfo() {
	infoExplosions[countExplID-1] = 0;
	
	for (var i = 0; i < countExplID; i += 1)
		infoExplosions[i] = new infoExplLine(i);
		
	dpExplosionsPlayer(infoExplosions);
}

//feather enable GM1020