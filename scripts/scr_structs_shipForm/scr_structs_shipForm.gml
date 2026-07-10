/// @desc Ship form struct creator, initialising stats, etc.
/// @arg {struct.infoFormLine} formData The data struct holding all the info of a given form.
function shipForm(formData) constructor {
	formID = formData.formID;
	formCol = formData.formCol;
	formName = formData.formName;
	formDesc = formData.formDesc;
	formElement = formData.formStats.fsType;
	
	formShot = formData.formShot;
	
	formMana = new entityStat(sgID, statTypesShip.statMana, "Mana", "The amount of Mana the player has.", formData.formStats.fsMana, 0, 999999999);
	formMana.eStatIsRes = true;
	formHPRegen = new entityStat(sgID, statTypesShip.statHPRegen, "HP Regen", "How much HP the ship restores every second.", formData.formStats.fsHPRegen, 0, 99999999);
	formManaRegen = new entityStat(sgID, statTypesShip.statManaRegen, "Mana Regen", "How much Mana the ship restores every second.", formData.formStats.fsManaRegen, 0, 99999999);
	
	formDmgPhys = new entityStat(sgID, statTypesShip.statDmgPhys, "Physical Damage", "One of two stats that boosts damage. Mostly affects Standard Shots.", 0, -99999, 999999999);
	formDmgEner = new entityStat(sgID, statTypesShip.statDmgEner, "Energy Damage", "One of two stats that boosts damage. Mostly affects Abilities.", 0, -99999, 999999999);
	formResProj = new entityStat(sgID, statTypesShip.statResProj, "Projectile Resistance", "Reduces damage from enemy projectiles, lasers, explosions, etc.", formData.formStats.fsResProj, -99999, 999999999);
	formResColl = new entityStat(sgID, statTypesShip.statResColl, "Collision Resistance", "Reduces damage taken from colliding with enemies.", formData.formStats.fsResColl, -99999, 999999999);
	formResElemFire = new entityStat(sgID, statTypesShip.statResElemFire, "Fire Resistance", "Reduces damage taken from Fire-element damage.", formData.formStats.fsResElemFire, -99999, 999999999);
	formResElemElec = new entityStat(sgID, statTypesShip.statResElemElec, "Electric Resistance", "Reduces damage taken from Electric-element damage.", formData.formStats.fsResElemElec, -99999, 999999999);
	formResElemPsn = new entityStat(sgID, statTypesShip.statResElemPsn, "Poison Resistance", "Reduces damage taken from Poison-element damage.", formData.formStats.fsResElemPsn, -99999, 999999999);
	formResElemIce = new entityStat(sgID, statTypesShip.statResElemIce, "Ice Resistance", "Reduces damage taken from Ice-element damage.", formData.formStats.fsResElemIce, -99999, 999999999);
	formResElemLight = new entityStat(sgID, statTypesShip.statResElemLight, "Light Resistance", "Reduces damage taken from Light-element damage.", formData.formStats.fsResElemLight, -99999, 999999999);
	formResElemDark = new entityStat(sgID, statTypesShip.statResElemDark, "Dark Resistance", "Reduces damage taken from Dark-element damage.", formData.formStats.fsResElemDark, -99999, 999999999);
	formResCC = new entityStat(sgID, statTypesShip.statResCC, "Disable Resistance", "Reduces the duration that movement-affecting debuffs are applied for.", 0, -99999, 999999999);
	
	formSpdAtt = new entityStat(sgID, statTypesShip.statSpdAtt, "Attack Speed", "How quickly the ship fires standard shots.", formData.formStats.fsAttSpd, 0, 999999999);
	formSpdSpell = new entityStat(sgID, statTypesShip.statSpdSpell, "Spell Speed", "Reduces the cooldown duration of abilities.", 0, -999999, 999999999);
	formSpdMove = new entityStat(sgID, statTypesShip.statSpdMove, "Move Speed", "How quickly the ship can move around the field.", formData.formStats.fsMoveSpd, 0, 100);
	
	formLSAtt = new entityStat(sgID, statTypesShip.statLSAtt, "Attack Lifesteal", "The percentage of damage dealt by standard shots that the player heals for.", formData.formStats.fsLSAtt, 0, 999999999);
	formLSSpell = new entityStat(sgID, statTypesShip.statLSSpell, "Spell Lifesteal", "The percentage of damage dealt by abilities that the player heals for.", formData.formStats.fsLSSpell, 0, 999999999);
	
	formDbfDur = new entityStat(sgID, statTypesShip.statDurDebf, "Debuff Duration", "Increases how long debuffs that the player applies to enemies last for.", 0, -999999, 999999999);

	formVuln = new entityStat(sgID, statTypesShip.statVuln, "Vulnerability", "Increases how much damage is taken from all sources by a percentage.", 1, 0, 999999999);

	formScrSwitchTo = function() {};
	formScrSwitchFrom = function() {};
	formScrStep = function() {};
	formScrDraw = function() {};
  
  formInfoSS = formData.formSSInfo;
  formInfoAbilityQ = formData.formQInfo;
  formInfoAbilityW = formData.formWInfo;
  formInfoAbilityE = formData.formEInfo;
  
	formScrSS = function(shipEnt, attTimer, extraProjCount) {};
	formScrQ = function(shipObj, keyState, autoFire) {};
	formScrW = function(shipObj, keyState, autoFire) {};
	formScrE = function(shipObj, keyState, autoFire) {};
  
  formUseSS = function(shipEnt, attTimer, extraProjCount) {
    return formScrSS(shipEnt, attTimer, extraProjCount);
  };
  formUseQ = function(shipEnt, keyState, autoFire) {
    return formScrQ(shipEnt, keyState, autoFire);
  };
  formUseW = function(shipEnt, keyState, autoFire) {
    return formScrW(shipEnt, keyState, autoFire);
  };
  formUseE = function(shipEnt, keyState, autoFire) {
    return formScrE(shipEnt, keyState, autoFire);
  };
	formCooldownQ = 0;
	formCooldownW = 0;
	formCooldownE = 0;
	
	formOnHitEffects = [];
	formStatusEffects = [];
	getOnHitEffectsArr = function() { return formOnHitEffects };
	getStatusEffectsArr = function() { return formStatusEffects };
	
	//Stat Fetchers
	getStatHP = function() { return global.ctrlPlayer.shipCurrHP; };
	getStatHPRegen = function() { return formHPRegen };
	getStatMana = function() { return formMana };
	getStatManaRegen = function() { return formManaRegen };
	getStatShield = function() { return global.ctrlPlayer.shipCurrShield };
	getStatDmgPhys = function() { return formDmgPhys };
	getStatDmgEner = function() { return formDmgEner };
	getStatResProj = function() { return formResProj };
	getStatResColl = function() { return formResColl };
	getStatResElemFire = function() { return formResElemFire };
	getStatResElemElec = function() { return formResElemElec };
	getStatResElemPsn = function() { return formResElemPsn };
	getStatResElemIce = function() { return formResElemIce };
	getStatResElemLight = function() { return formResElemLight };
	getStatResElemDark = function() { return formResElemDark };
	getStatResCC = function() { return formResCC };
	getStatSpdAtt = function() { return formSpdAtt };
	getStatSpdSpell = function() { return formSpdSpell };
	getStatSpdMove = function() { return formSpdMove };
	getStatLSAtt = function() { return formLSAtt };
	getStatLSSpell = function() { return formLSSpell };
	getStatDbfDur = function() { return formDbfDur };
	getStatVuln = function() { return formVuln };
	
	getStringStat = function(statStr) {
		var returnStat = {};
		switch(statStr) {
			case "hp": returnStat = getStatHP; break;
			case "hpRegen": returnStat = getStatHPRegen; break;
			case "mana": returnStat = getStatMana; break;
			case "manaRegen": returnStat = getStatManaRegen; break;
			case "shield": returnStat = getStatShield; break;
			case "physDmg": returnStat = getStatDmgPhys; break;
			case "energyDmg": returnStat = getStatDmgEner; break;
			case "projRes": returnStat = getStatResProj; break;
			case "collRes": returnStat = getStatResColl; break;
			case "elemResFire": returnStat = getStatResElemFire; break;
			case "elemResElec": returnStat = getStatResElemElec; break;
			case "elemResPsn": returnStat = getStatResElemPsn; break;
			case "elemResIce": returnStat = getStatResElemIce; break;
			case "elemResLight": returnStat = getStatResElemLight; break;
			case "elemResDark": returnStat = getStatResElemDark; break;
			case "ccRes": returnStat = getStatResCC; break;
			case "attSpd": returnStat = getStatSpdAtt; break;
			case "spellSpeed": returnStat = getStatSpdSpell; break;
			case "moveSpeed": returnStat = getStatSpdMove; break;
			case "attLS": returnStat = getStatLSAtt; break;
			case "spellLS": returnStat = getStatLSSpell; break;
			case "debuffDur": returnStat = getStatDbfDur; break;
			case "vuln": returnStat = getStatVuln; break;
		}
		return returnStat;
	}
}