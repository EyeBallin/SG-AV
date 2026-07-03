//feather disable GM1020
function infoAuraLine(auraID) constructor {
	auraDataID = auraID;
	
	auraDataSpr = -1;
	auraDataDmgBase = 0;
	auraDataDmgScalePhys = 0;
	auraDataDmgScaleEner = 0;
	auraDataResHit = dmgResHitTypeEnum.pViral;
	auraDataDmgElem = elementTypes.eNone;
	
	auraDataEdgeMult = 1;
	auraDataRoundRadius = 0;
	auraDataSizeVar = 0;
	auraDataSprRot = 0;
	auraDataCol = #FFFFFF;
	auraDataDur = 30;
    
    auraDataFollowObj = -1;
    auraDataFollowOffsetX = 0;
    auraDataFollowOffsetY = 0;
	
	auraDataCodeCreate = function() {};
	auraDataCodeStep = function() {};
	auraDataCodeCollide = function() {};
	auraDataCodeDestroy = function() {};
	
	/// @func addAuraInfo(auSprInfo, auDmgInfo)
	addAuraInfo = function(auSprInfo, auDmgInfo) {
		auraDataSpr = auSprInfo.auSpr;
		auraDataSizeVar = auSprInfo.auSizeVar;
		auraDataSprRot = auSprInfo.auSprRotDir;
		auraDataCol = auSprInfo.auCol;
		auraDataDur = auSprInfo.auDur;
		
		auraDataDmgBase = auDmgInfo.auBase;
		auraDataDmgScalePhys = auDmgInfo.auPhys;
		auraDataDmgScaleEner = auDmgInfo.auEner;
		auraDataResHit = auDmgInfo.auResHit;
		auraDataDmgElem = auDmgInfo.auElem;
		auraDataEdgeMult = auDmgInfo.auEdgeMult;
		auraDataRoundRadius = auDmgInfo.auRoundRad;
	}
	
	StructCOPYSTART infoAuraLine StructCOPYEND
}

function initAuraInfo() {
	infoAuras[countAuraID-1] = 0;
	
	for (var i = 0; i < countAuraID; i += 1)
		infoAuras[i] = new infoAuraLine(i);
		
	dpAurasPlayer(infoAuras);
}
//feather enable GM1020