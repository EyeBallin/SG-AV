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
	evActorStatusLose,
	evObjProjCreate,		//Other Objects
	evObjExplCreate,
    evObjAuraCreate
}

#macro countSysListenType 26

#macro StructCOPYSTART static copy = function() { var result = new
#macro StructCOPYEND (); var names = variable_struct_get_names(self); var i = 0; repeat array_length(names) { result[$ names[i]] = self[$ names[i]]; i++; } return result; }

