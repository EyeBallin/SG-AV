//feather disable GM1020
function infoStatusEffect(statusID) constructor {
	stsDataID = statusID;
	stsDataName = "";
	stsDataDesc = "";
	stsDataIcon = -1;
	
	stsDataDur = -1;
	stsDataStr = 1;
	stsDataTick = 15;
	stsDataParity = stsParity.stspNeutral;
	stsDataElem = elementTypes.eNone;
    
	seArgs = {};
	
	stsDataCodeInit = function() {};
	stsDataCodeStep = function() {};
	stsDataCodeDraw = function() {};
	stsDataCodeRemoved = function() {};
	stsDataCodeCleanup = function() {};
	
	function addStatusInfo(stsName, stsDesc, stsIcon, stsStr, stsDur, stsPar, stsElem, stsMaxStacks, stsLoseStackOnExpire) {
		stsDataName = stsName;
		stsDataDesc = stsDesc;
		stsDataIcon = stsIcon;
		stsDataStr = stsStr;
		stsDataDur = stsDur;
		stsDataParity = stsPar;
		stsDataElem = stsElem;
		stsDataMaxStacks = stsMaxStacks;
		stsDataLoseStackOnExpire = stsLoseStackOnExpire;
	}
	
	StructCOPYSTART infoStatusEffect StructCOPYEND
}

function initStatusEffectInfo() {
	infoStatusEffects[countStatusTotal-1] = [];
	
	for (var i = 0; i < countStatusTotal; i += 1) {
		infoStatusEffects[i] = new infoStatusEffect(i);
	}
    
	dpStatusEffectsBuffsUpgrades(infoStatusEffects);
	dpStatusEffectsGeneric(infoStatusEffects);
}

//feather enable GM1020