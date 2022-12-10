function infoOnHitEffect(newOHID) constructor {
	ohDataID = newOHID;
	ohDataName = "";
	ohDataDesc = "";
	ohDataIcon = -1;
	
	ohDataInitCode = function() {};
	ohDataCollCode = function() {};
	ohDataDrawCode = function() {};
	
	function addOHInfo(ohName, ohDesc, ohIcon) {
		ohDataName = ohName;
		ohDataDesc = ohDesc;
		ohDataIcon = ohIcon;
	}
}

function initOnHitInfo() {
	infoOnHitEffects[countOnHits-1] = -1;
	
	for (var i = 0; i < countOnHits; i += 1)
		infoOnHitEffects = new infoOnHitEffect(i);
		
	dpOnHitEffects(infoOnHitEffects);
}