/// @param {Struct.infoAugmentPassive} augPassiveInfo
/// @param {Struct.augmentObj} augPassiveOwningObj
function augmentPassive(augPassiveInfo, augPassiveOwningObj) constructor {
	if (struct_exists(augPassiveInfo, "augPassID")) {
		passiveAugObjOwner = augPassiveOwningObj;
		passiveID = augPassiveInfo.augPassID;
		passiveName = augPassiveInfo.augPassName;
		passiveDesc = augPassiveInfo.augPassDesc;
		passiveDescLong = augPassiveInfo.augPassDescLong;
		passiveTier = augPassiveInfo.augPassTier;
		passiveFunctions = [];
		for (var i = 0; i < array_length(augPassiveInfo.augPassFunctions); i += 1) {
			var newFunc = new augFunction(augPassiveInfo.augPassFunctions[i], self, augPassiveOwningObj);
			array_push(passiveFunctions, newFunc);
		}
	}
}