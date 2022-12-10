function onHitEffect(ohInfo) {
	ohID = ohInfo.ohDataID;
	ohName = ohInfo.ohDataName;
	ohDesc = ohInfo.ohDataDesc;
	ohIcon = ohInfo.ohDataIcon;
	ohUniqueID = random(999999999);
	
	ohArgs = {};
	
	ohCodeCommonInit = method(self, ohInfo.ohDataInitCode);
	ohCodeUniqueInit = function() {};
	ohCodeInit = function() {
		ohCodeCommonInit();
		ohCodeUniqueInit();
	}
	
	ohCodeCommonDraw = method(self, ohInfo.ohDataDrawCode);
	ohCodeUniqueDraw = function() {};
	ohCodeDraw = function() {
		ohCodeCommonDraw();
		ohCodeUniqueDraw();
	}
	
	ohCodeCommonColl = method(self, ohInfo.ohDataCollCode);
	ohCodeUniqueColl = function() {};
	ohCodeColl = function() {
		ohCodeCommonColl();
		ohCodeUniqueColl();
	}
}