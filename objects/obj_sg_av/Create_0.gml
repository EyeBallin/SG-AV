event_inherited();
entityID = sgID;
entityType = entityTypes.ePlayer;

//Drawing
subcoreRot = 0;
subcoreXDiff = 30;
subcoreYDiff = -30;

wingChange = true;
wingFlapValA = 1;
wingFlapValB = 1;
wingRotVal = 0;

//Stat Fetchers
getStatHP = function() { return global.ctrlPlayer.shipCurrHP };
getStatHPRegen = function() { return getCurrForm().formHPRegen };
getStatMana = function() { return getCurrForm().formManaCurr };
getStatManaRegen = function() { return getCurrForm().formManaRegen };
getStatShield = function() { return global.ctrlPlayer.shipCurrShield };
getStatDmgPhys = function() { return getCurrForm().formDmgPhys };
getStatDmgEner = function() { return getCurrForm().formDmgEner };
getStatResProj = function() { return getCurrForm().formResProj };
getStatResColl = function() { return getCurrForm().formResColl };
getStatResElem = function() { return getCurrForm().formResElem };
getStatResCC = function() { return getCurrForm().formResCC };
getStatSpdAtt = function() { return getCurrForm().formSpdAtt };
getStatSpdSpell = function() { return getCurrForm().formSpdSpell };
getStatSpdMove = function() { return getCurrForm().formSpdMove };
getStatLSAtt = function() { return getCurrForm().formLSAtt };
getStatLSSpell = function() { return getCurrForm().formLSSpell };
getStatDbfDur = function() { return getCurrForm().formDbfDur };