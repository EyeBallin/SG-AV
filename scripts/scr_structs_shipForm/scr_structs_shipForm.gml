function shipForm(formData) constructor {
	formID = formData.formID;
	formCol = formData.formCol;
	formName = formData.formName;
	formDesc = formData.formDesc;
	formElem = formData.formStats.fsResType;
	
	formShot = formData.formShot;
	
	formMana = new entityStat(sgID, statTypesShip.statMana, "Mana", "The amount of Mana the player has.", formData.formStats.fsMana, 0, 999999999);
	formMana.eStatIsRes = true;
	formHPRegen = new entityStat(sgID, statTypesShip.statHPRegen, "HP Regen", "How much HP the ship restores every second.", formData.formStats.fsHPRegen, 0, 99999999);
	formManaRegen = new entityStat(sgID, statTypesShip.statManaRegen, "Mana Regen", "How much Mana the ship restores every second.", formData.formStats.fsManaRegen, 0, 99999999);
	
	formDmgPhys = new entityStat(sgID, statTypesShip.statDmgPhys, "Physical Damage", "One of two stats that boosts damage. Mostly affects Standard Shots.", 0, -99999, 999999999);
	formDmgEner = new entityStat(sgID, statTypesShip.statDmgEner, "Energy Damage", "One of two stats that boosts damage. Mostly affects Abilities.", 0, -99999, 999999999);
	formResProj = new entityStat(sgID, statTypesShip.statResProj, "Projectile Resistance", "Reduces damage from enemy projectiles, lasers, explosions, etc.", formData.formStats.fsResProj, -99999, 999999999);
	formResColl = new entityStat(sgID, statTypesShip.statResColl, "Collision Resistance", "Reduces damage taken from colliding with enemies.", formData.formStats.fsResColl, -99999, 999999999);
	formResElem = new entityStat(sgID, statTypesShip.statResElem, "Elemental Resistance", "Reduces damage taken from elementally-aspected damage.", formData.formStats.fsResElem, -99999, 999999999);
	formResCC = new entityStat(sgID, statTypesShip.statResCC, "Disable Resistance", "Reduces the duration that movement-affecting debuffs are applied for.", 0, -99999, 999999999);
	
	formSpdAtt = new entityStat(sgID, statTypesShip.statSpdAtt, "Attack Speed", "How quickly the ship fires standard shots.", formData.formStats.fsAttSpd, 0, 999999999);
	formSpdSpell = new entityStat(sgID, statTypesShip.statSpdSpell, "Spell Speed", "Reduces the cooldown duration of abilities.", 0, -999999, 999999999);
	formSpdMove = new entityStat(sgID, statTypesShip.statSpdMove, "Move Speed", "How quickly the ship can move around the field.", formData.formStats.fsMoveSpd, 0, 100);
	
	formLSAtt = new entityStat(sgID, statTypesShip.statLSAtt, "Attack Lifesteal", "The percentage of damage dealt by standard shots that the player heals for.", formData.formStats.fsLSAtt, 0, 999999999);
	formLSSpell = new entityStat(sgID, statTypesShip.statLSSpell, "Spell Lifesteal", "The percentage of damage dealt by abilities that the player heals for.", formData.formStats.fsLSSpell, 0, 999999999);
	
	formDbfDur = new entityStat(sgID, statTypesShip.statDurDebf, "Debuff Duration", "Increases how long debuffs that the player applies to enemies last for.", 0, -999999, 999999999);

	formScrSwitchTo = function() {};
	formScrSwitchFrom = function() {};
	formScrStep = function() {};
	formScrDraw = function() {};
	formScrSS = function(shipObj, attTimer, extraProj) {};
	formScrQ = function(shipObj) {};
	formScrW = function() {};
	formScrE = function() {};
	
	formOnHitAtt = [];
	formOnHitSpell = [];
	
	//Stat Fetchers
	getStatHP = function() { return global.ctrlPlayer.shipCurrHP };
	getStatHPRegen = function() { return formHPRegen };
	getStatMana = function() { return formMana };
	getStatManaRegen = function() { return formManaRegen };
	getStatShield = function() { return global.ctrlPlayer.shipCurrShield };
	getStatDmgPhys = function() { return formDmgPhys };
	getStatDmgEner = function() { return formDmgEner };
	getStatResProj = function() { return formResProj };
	getStatResColl = function() { return formResColl };
	getStatResElem = function() { return formResElem };
	getStatResCC = function() { return formResCC };
	getStatSpdAtt = function() { return formSpdAtt };
	getStatSpdSpell = function() { return formSpdSpell };
	getStatSpdMove = function() { return formSpdMove };
	getStatLSAtt = function() { return formLSAtt };
	getStatLSSpell = function() { return formLSSpell };
	getStatDbfDur = function() { return formDbfDur };
}