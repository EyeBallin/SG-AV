// feather disable GM1020
function infoOnHitEffect(newOHID) constructor {
	ohDataID = newOHID;
	ohDataName = "";
	ohDataDesc = "";
	ohDataIcon = -1;
	ohDataElem = elementTypes.eNone;
	
	ohDataInitCode = function() {};
	ohDataCollCode = function() {};
	ohDataDrawCode = function() {};
	
	function addOHInfo(ohName, ohDesc, ohIcon, ohElem) {
		ohDataName = ohName;
		ohDataDesc = ohDesc;
		ohDataIcon = ohIcon;
		ohDataElem = ohElem;
	}
	
	StructCOPYSTART infoOnHitEffect StructCOPYEND
}

function initOnHitInfo() {
	infoOnHitEffects[countOnHits-1] = -1;
	
	for (var i = 0; i < countOnHits; i += 1)
		infoOnHitEffects[i] = new infoOnHitEffect(i);
		
	dpOnHitEffects(infoOnHitEffects);
}
// feather enable GM1020