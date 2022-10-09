enum statusEffects {
	//Debuffs - General
	dbGenBurn,
	dbGenShock,
	dbGenPsn,
	dbGenFrost,
	dbGenFreeze,
	dbGenSeal,
	dbGenEntropy,
	dbGenShred,
	dbGenOverload,
	dbGenBleed,
	dbGenDmgDown,
	dbGenResDown,
	dbGenSlow,
	dbGenStun,
	dbGenDisplace,
	
	//Buffs - General
	bGenDmgUp,
	bGenResUp,
	bGenSpdUp,
	bGenInvis,
	
	//Debuffs - Augments
	//TODO
	
	//Buffs - Augments
	bAugFlipShift4DCore,
	bAugSpellstormTempTome,
	bAugLSSerpBracer,
	bAugLSDreamBracer,
	bAugLSMotherRing,
	bAugLSLifebinder,
	bAugCadenceGearTime,
	bAugBloodwellValeRuber,
	bAugModFForceBase,
	bAugModFForce2,
	bAugVisageMindbreaker,
	bAugManaWellEmptyVessel,
	bAugManaWellOmniscientGaze,
	bAugManaWellBlackGear,
	bAugWindUpClockworkHeart,
	bAugWindUpFactorySoul,
	bAugWindUpBlackGear,
	bAugBloodTideSarcoidPike,
	bAugHackSlashCobraHalberd,
	bAugLivingShieldBiosphere
}

#macro countStatusDBGen 15
#macro countStatusBGen 4
#macro countStatusDBAug 0
#macro countStatusBAug 20
#macro countStatusTotal (countStatusDBGen + countStatusBGen + countStatusDBAug + countStatusBAug)