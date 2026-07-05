/// @func statusEffect
/// @param {Enum.statusEffects} stsID
/// @param {Struct} [customData]
function statusEffect(stsID, customData = {}) constructor {
	seCodeUniqueInit = function() {};
	seCodeUniqueStep = function() {};
	seCodeUniqueDraw = function() {};
	seCodeUniqueRemoved = function() {};
	seCodeUniqueCleanup = function() {};
	
	var seInfo = stsID > -1 ? global.ctrlInfo.infoStatusEffects[stsID] : {};
	if (!is_undefined(customData) && variable_struct_names_count(customData) > 0) {
		seInfo = mergeStructs(seInfo, customData, true);
	}
		
	seID = stsID;
	seIDUnique = random(999999999);
	seCustomInfo = customData;
	seName = seInfo.stsDataName;
	seDesc = seInfo.stsDataDesc;
	seIcon = seInfo.stsDataIcon;
	
	seArgs = seInfo.seArgs;
	
	seStrBase = seInfo.stsDataStr;
	seStrCurr = seStrBase;
	seDurBase = seInfo.stsDataDur;
	seDurCurr = seDurBase;
	seStacksMax = seInfo.stsDataMaxStacks;
	seStacksCurr = 1;
	seLoseStackOnExpire = seInfo.stsDataLoseStackOnExpire;
	seTick = seInfo.stsDataTick;
	seLifetime = 0;
	
	seOwner = -1;
	seSrc = -1;
	seParity = seInfo.stsDataParity;
	
	//Code that runs when the effect is applied
	seCodeCommonInit = method(self, seInfo.stsDataCodeInit);
	seCodeInit = function() {
		seCodeCommonInit();
		seCodeUniqueInit();
	}
	
	//Code that runs every frame (but only *does* anything every tick)
	seCodeCommonStep = method(self, seInfo.stsDataCodeStep);
	seCodeStep = function() {
		if (seLifetime mod seTick == 0) {
			seCodeCommonStep();
			seCodeUniqueStep();
		}
		seLifetime += 1;
		seDurCurr -= 1;
		if (seDurCurr <= 0) {
			removeStatusEffect(seOwner, seID);
		}
	}
	
	//Code that runs every frame, for visuals
	seCodeCommonDraw = method(self, seInfo.stsDataCodeDraw);
	seCodeDraw = function() {
		seCodeCommonDraw();
		seCodeUniqueDraw();
	}
	
	//Code that runs when the effect is removed
	seCodeCommonRemoved = method(self, seInfo.stsDataCodeRemoved);
	seCodeRemoved = function() {
		seCodeCommonRemoved();
		seCodeUniqueRemoved();
	}
	
	//Code that runs as cleanup
	seCodeCommonCleanup = method(self, seInfo.stsDataCodeCleanup);
	seCodeCleanup = function() {
		seCodeCommonCleanup();
		seCodeUniqueCleanup();
	}
}