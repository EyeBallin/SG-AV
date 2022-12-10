function createEnemy(eX, eY, eType) {
	var newEnemy = instance_create_depth(eX, eY, 2, obj_enemy);
	var eInfo = global.ctrlInfo.infoEnemies[eType];
	
	newEnemy.entityType = eInfo.enDataType;
	newEnemy.entityID = eType;
	newEnemy.entityElement = eInfo.enDataStats.endsElemType;
	
	newEnemy.enemyStatHP = new entityStat(eType, statTypesEnemy.statHP, "Current HP", "The enemy's current HP.",
		eInfo.enDataStats.endsHP, 0, 999999999);
	newEnemy.enemyStatHPRegen = new entityStat(eType, statTypesEnemy.statHPRegen, "HP Regen", "How much HP the enemy regenerates every half-second.",
		eInfo.enDataStats.endsHPRegen, 0, 999999999);
	newEnemy.enemyStatShield = new entityStat(eType, statTypesEnemy.statShield, "Shield", "How much Shield the enemy has.",
		eInfo.enDataStats.endsShield, 0, 999999999);
	newEnemy.enemyStatDmgProj = new entityStat(eType, statTypesEnemy.statDmgProj, "Projectile Damage", "The base damage this enemy deals with its ranged attacks.",
		eInfo.enDataStats.endsDmgAtt, 0, 999999999);
	newEnemy.enemyStatDmgColl = new entityStat(eType, statTypesEnemy.statDmgColl, "Collision Damage", "The base damage this enemy deals when colliding with the player.",
		eInfo.enDataStats.endsDmgColl, 0, 999999999);
	newEnemy.enemyStatResAtt = new entityStat(eType, statTypesEnemy.statResAtt, "Attack Resistance", "The percentage of damage from the player's Standard Shots that's ignored.",
		eInfo.enDataStats.endsResAtt, -999999, 100);
	newEnemy.enemyStatResSpell = new entityStat(eType, statTypesEnemy.statResSpell, "Spell Resistance", "The percentage of damage from the player's Abilities that's ignored.",
		eInfo.enDataStats.endsResSpell, -999999, 100);
	newEnemy.enemyStatSpdAtt = new entityStat(eType, statTypesEnemy.statSpdAtt, "Attack Speed", "The base value for how quickly this enemy uses its ranged attacks.",
		eInfo.enDataStats.endsSpeedAtt, 0, 1000);
	newEnemy.enemyStatSpdMove = new entityStat(eType, statTypesEnemy.statSpdMove, "Move Speed", "The base value for how quickly this enemy moves.",
		eInfo.enDataStats.endsSpeedMove, 0, 100);
	newEnemy.enemyStatLSProj = new entityStat(eType, statTypesEnemy.statLSProj, "Projectile Lifesteal", "The percentage value of how much this enemy heals from its ranged attacks.",
		eInfo.enDataStats.endsLSAtt, 0, 999999999);
	newEnemy.enemyStatLSColl = new entityStat(eType, statTypesEnemy.statLSColl, "Collision Lifesteal", "The percentage value of how much this enemy heals from its collision damage.",
		eInfo.enDataStats.endsLSColl, 0, 999999999);
	newEnemy.enemyStatResCC = new entityStat(eType, statTypesEnemy.statResCC, "Immobilisation Resistance", "The percentage of time/strength from the player's immobilisations that's ignored.",
		eInfo.enDataStats.endsResCC, -999999, 100);
		
	newEnemy.enemySpriteArr = eInfo.enDataDrawInfo;
	swapEnemySprite(newEnemy, 0);
	
	newEnemy.enemyDropGold = eInfo.enDataDropGold;
	newEnemy.enemyDropData = eInfo.enDataDropData;
	newEnemy.enemyDropItemType = eInfo.enDataDropItemType;
	newEnemy.enemyDropItemChance = eInfo.enDataDropItemChance;
	
	newEnemy.enemyScriptSpawn = method(newEnemy, eInfo.enDataCodeSpawn);
	newEnemy.enemyScriptStep = method(newEnemy, eInfo.enDataCodeStep);
	newEnemy.enemyScriptDestroy = method(newEnemy, eInfo.enDataCodeDestroy);
	newEnemy.enemyScriptDraw = method(newEnemy, eInfo.enDataCodeDraw);
	
	newEnemy.enemyScriptSpawn();
	
	regEntity(newEnemy.id, newEnemy);
	
	return newEnemy;
}