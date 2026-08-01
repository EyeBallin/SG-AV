event_inherited();

entityID = -1;
entityType = entityTypes.eEnemyNormal;

enemyStatHP = new entityStat(-1, statTypesEnemy.statHP, "UNINITIALISED", "UNINITIALISED", 1, 0, 999999999, false);
enemyStatHPRegen = new entityStat(-1, statTypesEnemy.statHPRegen, "UNINITIALISED", "UNINITIALISED", 1, 0, 999999999, false);
enemyStatShield = new entityStat(-1, statTypesEnemy.statShield, "UNINITIALISED", "UNINITIALISED", 1, 0, 999999999, false);
enemyStatDmgProj = new entityStat(-1, statTypesEnemy.statDmgProj, "UNINITIALISED", "UNINITIALISED", 1, 0, 999999999, false);
enemyStatDmgColl = new entityStat(-1, statTypesEnemy.statDmgColl, "UNINITIALISED", "UNINITIALISED", 1, 0, 999999999, false);
enemyStatResAtt = new entityStat(-1, statTypesEnemy.statResAtt, "UNINITIALISED", "UNINITIALISED", 1, 0, 999999999, false);
enemyStatResSpell = new entityStat(-1, statTypesEnemy.statResSpell, "UNINITIALISED", "UNINITIALISED", 1, 0, 999999999, false);
enemyStatSpdAtt = new entityStat(-1, statTypesEnemy.statSpdAtt, "UNINITIALISED", "UNINITIALISED", 1, 0, 999999999, false);
enemyStatSpdMove = new entityStat(-1, statTypesEnemy.statSpdMove, "UNINITIALISED", "UNINITIALISED", 1, 0, 999999999, false);
enemyStatLSProj = new entityStat(-1, statTypesEnemy.statLSProj, "UNINITIALISED", "UNINITIALISED", 1, 0, 999999999, false);
enemyStatLSColl = new entityStat(-1, statTypesEnemy.statLSColl, "UNINITIALISED", "UNINITIALISED", 1, 0, 999999999, false);
enemyStatResCC = new entityStat(-1, statTypesEnemy.statResCC, "UNINITIALISED", "UNINITIALISED", 1, 0, 999999999, false);

enemyStatVuln = new entityStat(-1, statTypesEnemy.statVuln, "UNINITIALISED", "UNINITIALISED", 1, 0, 999999999, false);

enemySpriteArr = [];
enemySpriteCurr = 0;
enemySpriteRotToDir = false;

enemyDropGold = 0;
enemyDropData = 0;
enemyDropItemType = 0;
enemyDropItemChance = 0;

enemyScriptSpawn = function() {};
enemyScriptStep = function() {};
enemyScriptDestroy = function() {};
enemyScriptDraw = function() {};

//Stat Fetchers
getStatHP = function() { return enemyStatHP };
getStatHPRegen = function() { return enemyStatHPRegen };
getStatShield = function() { return enemyStatShield };
getStatDmgProj = function() { return enemyStatDmgProj };
getStatDmgColl = function() { return enemyStatDmgColl };
getStatResAtt = function() { return enemyStatResAtt };
getStatResSpell = function() { return enemyStatResSpell };
getStatResCC = function() { return enemyStatResCC };
getStatSpdAtt = function() { return enemyStatSpdAtt };
getStatSpdMove = function() { return enemyStatSpdMove };
getStatLSProj = function() { return enemyStatLSProj };
getStatLSColl = function() { return enemyStatLSColl };

getStatVuln = function() { return enemyStatVuln };