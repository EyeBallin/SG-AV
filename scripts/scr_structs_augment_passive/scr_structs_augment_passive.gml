/// @param {Struct.infoAugmentPassive} augPassiveInfo
function augmentPassive(augPassiveInfo) constructor {
	if (struct_exists(augPassiveInfo, "augPassID")) {
		passiveID = augPassiveInfo.augPassID;
		passiveName = augPassiveInfo.augPassName;
		passiveDesc = augPassiveInfo.augPassDesc;
		passiveDescLong = augPassiveInfo.augPassDescLong;
		passiveTier = augPassiveInfo.augPassTier;
		passiveFunctions = augPassiveInfo.augPassFunctions;
	}
}