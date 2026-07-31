/// @desc Ship form struct creator, initialising stats, etc.
/// @arg {struct.infoFormLine} formData The data struct holding all the info of a given form.
function shipForm(formData) constructor {
	formID = formData.formID;
	formCol = formData.formCol;
	formName = formData.formName;
	formDesc = formData.formDesc;
	formElement = formData.formStats.fsType;
	
	formShot = formData.formShot;
	
	formMana = new entityStat(sgID, statTypesShip.statMana, getString("statManaName"), getString("statManaDescPlayer"), formData.formStats.fsMana, 0, 999999999);
	formMana.eStatIsRes = true;
	formHPRegen = new entityStat(sgID, statTypesShip.statHPRegen, getString("statHPRegenName"), getString("statHPRegenDescPlayer"), formData.formStats.fsHPRegen, 0, 99999999);
	formManaRegen = new entityStat(sgID, statTypesShip.statManaRegen, getString("statManaRegenName"),getString("statManaRegenDescPlayer"), formData.formStats.fsManaRegen, 0, 99999999);
	
	formDmgPhys = new entityStat(sgID, statTypesShip.statDmgPhys, getString("statDmgPhysName"), getString("statDmgPhysDescPlayer"), 0, -99999, 999999999);
	formDmgEner = new entityStat(sgID, statTypesShip.statDmgEner, getString("statDmgEnerName"), getString("statDmgEnerDescPlayer"), 0, -99999, 999999999);
	formResProj = new entityStat(sgID, statTypesShip.statResProj, getString("statResProjName"), getString("statResProjDescPlayer"), formData.formStats.fsResProj, -99999, 999999999);
	formResColl = new entityStat(sgID, statTypesShip.statResColl, getString("statResCollName"), getString("statResCollDescPlayer"), formData.formStats.fsResColl, -99999, 999999999);
	formResElemFire = new entityStat(sgID, statTypesShip.statResElemFire, getString("statResElemFireName"), getString("statResElemFireDescPlayer"), formData.formStats.fsResElemFire, -99999, 999999999);
	formResElemElec = new entityStat(sgID, statTypesShip.statResElemElec, getString("statResElemElecName"), getString("statResElemElecDescPlayer"), formData.formStats.fsResElemElec, -99999, 999999999);
	formResElemPsn = new entityStat(sgID, statTypesShip.statResElemPsn, getString("statResElemPsnName"), getString("statResElemPsnDescPlayer"), formData.formStats.fsResElemPsn, -99999, 999999999);
	formResElemIce = new entityStat(sgID, statTypesShip.statResElemIce, getString("statResElemIceName"), getString("statResElemIceDescPlayer"), formData.formStats.fsResElemIce, -99999, 999999999);
	formResElemLight = new entityStat(sgID, statTypesShip.statResElemLight, getString("statResElemLightName"), getString("statResElemLightDescPlayer"), formData.formStats.fsResElemLight, -99999, 999999999);
	formResElemDark = new entityStat(sgID, statTypesShip.statResElemDark, getString("statResElemDarkName"), getString("statResElemDarkDescPlayer"), formData.formStats.fsResElemDark, -99999, 999999999);
	formResCC = new entityStat(sgID, statTypesShip.statResCC, getString("statResCCName"), getString("statResCCDescPlayer"), 0, -99999, 999999999);
	
	formSpdAtt = new entityStat(sgID, statTypesShip.statSpdAtt, getString("statSpdAttName"), getString("statSpdAttDescPlayer"), formData.formStats.fsAttSpd, 0, 999999999);
	formSpdSpell = new entityStat(sgID, statTypesShip.statSpdSpell, getString("statSpdSpellName"), getString("statSpdSpellDescPlayer"), 0, -999999, 999999999);
	formSpdMove = new entityStat(sgID, statTypesShip.statSpdMove, getString("statSpdMoveName"), getString("statSpdMoveDescPlayer"), formData.formStats.fsMoveSpd, 0, 100);
	
	formLSAtt = new entityStat(sgID, statTypesShip.statLSAtt, getString("statLSAttName"), getString("statLSAttDescPlayer"), formData.formStats.fsLSAtt, 0, 999999999);
	formLSSpell = new entityStat(sgID, statTypesShip.statLSSpell, getString("statLSSpellName"), getString("statLSSpellDescPlayer"), formData.formStats.fsLSSpell, 0, 999999999);
	
	formDbfDur = new entityStat(sgID, statTypesShip.statDurDebf, getString("statDbfDurName"), getString("statDbfDurDescPlayer"), 0, -999999, 999999999);

	formVuln = new entityStat(sgID, statTypesShip.statVuln, getString("statVulnName"), getString("statVulnDescPlayer"), 1, 0, 999999999);

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
	
	formUpgrades = createAllFormUpgrades(formID);
	
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