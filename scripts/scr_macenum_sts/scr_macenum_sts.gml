enum statusEffects {
	//Debuffs - General
	dbGenBurn,
	dbGenBurnSear,
	dbGenShock,
	dbGenShockCritical,
	dbGenPsn,
	dbGenPsnCrippling,
	dbGenFrost,
	dbGenFreeze,
	dbGenSeal,
	dbGenSealAncient,
	dbGenEntropy,
	dbGenEntropyDiscordant,
	dbGenShred,
	dbGenShredToPieces,
	dbGenOverload,
	dbGenOverloadCorrupting,
	dbGenBleed,
	dbGenDmgDown,
	dbGenResDown,
	dbGenVulnUp,
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
	bAugLivingShieldBiosphere,
	
	//Buffs - Abilities
	bAblFireSignalFlares
}

#macro countStatusDBGen 23
#macro countStatusBGen 4
#macro countStatusDBAug 0
#macro countStatusBAug 20
#macro countStatusBUpgr 1
#macro countStatusTotal (countStatusDBGen + countStatusBGen + countStatusDBAug + countStatusBAug + countStatusBUpgr)

enum stsParity {
	stspBuff,
	stspDebuff,
	stspNeutral
}