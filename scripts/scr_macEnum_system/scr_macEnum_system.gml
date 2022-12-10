enum sysEvent {
	evLvlStart,				//Game
	evLvlEnd,
	evAugEquip,
	evAugUnequip,
	evShipMove,				//Player
	evShipSS,
	evShipQ,
	evShipW,
	evShipE,
	evShipDealHit,
	evShipTakeHitProj,
	evShipTakeHitColl,
	evEnemySpawn,			//Enemy
	evEnemyDie,
	evEnemyUseAction,
	evActorGainStat,		//All Entities
	evActorLoseStat,
	evActorDmgDeal,
	evActorDmgTake,
	evActorCalcStat,
	evActorStatusGain,
	evActorStatusLose
}

#macro countSysListenType 24