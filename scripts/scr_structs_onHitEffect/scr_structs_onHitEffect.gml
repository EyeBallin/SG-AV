/// @func onHitEffect
/// @param onHitID
/// @param [customData]
function onHitEffect(onHitID, customData = {}) constructor {
	ohCodeUniqueInit = function() {};
	ohCodeUniqueDraw = function() {};
	ohCodeUniqueColl = function(collX, collY, srcObj, trgObj, dmgSrc) {};
	
	var ohInfo = onHitID > -1 ? global.ctrlInfo.infoOnHitEffects[onHitID] : {};
	if (!is_undefined(customData) && variable_struct_names_count(customData) > 0)
		ohInfo = mergeStructs(ohInfo, customData, true);
	
	ohID = onHitID;
	ohFullInfo = customData;
	ohName = ohInfo.ohDataName;
	ohDesc = ohInfo.ohDataDesc;
	ohIcon = ohInfo.ohDataIcon;
	ohUniqueID = random(999999999);
	ohOwner = -1;
	
	ohArgs = {};
	
	ohCodeCommonInit = method(self, ohInfo.ohDataInitCode);
	ohCodeInit = function() {
		ohCodeCommonInit();
		ohCodeUniqueInit();
	}
	
	ohCodeCommonDraw = method(self, ohInfo.ohDataDrawCode);
	ohCodeDraw = function() {
		ohCodeCommonDraw();
		ohCodeUniqueDraw();
	}
	
	ohCodeCommonColl = method(self, ohInfo.ohDataCollCode);
	ohCodeColl = function(collX, collY, srcObj, trgObj, dmgSrc) {
		ohCodeCommonColl(collX, collY, srcObj, trgObj, dmgSrc);
		ohCodeUniqueColl(collX, collY, srcObj, trgObj, dmgSrc);
	}
}