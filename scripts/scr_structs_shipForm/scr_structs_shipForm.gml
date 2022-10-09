function shipForm(formData) constructor {
	formID = formData.formID;
	formCol = formData.formCol;
	formName = formData.formName;
	formDesc = formData.formDesc;
	formElem = formData.formStats.fsResType;
	
	formHPMax = new entityStat(sgID, statTypesShip.statHPMax, "Max HP", "The maximum amount of HP the player can have in this form.", formData.formStats.fsHP, 0, 999999999);
	formManaCurr = new entityStat(sgID, statTypesShip.statMana, "Current Mana", "The current amount of Mana the player has.", formData.formStats.fsMana, 0, 999999999);
	formManaMax = new entityStat(sgID, statTypesShip.statManaMax, "Max Mana", "The maximum amount of Mana the player can have in this form.", formData.formStats.fsMana, 0, 999999999);
	formShieldMax = new entityStat(sgID, statTypesShip.statShieldMax, "Max Shield", "The maximum amount of Shield the player can have in this form.", 0, 0, 999999999);
	
	formDmgPhys = new entityStat(sgID, statTypesShip.statDmgPhys, "Physical Damage", "One of two stats that boosts damage. Mostly affects standard shots.", 0, -99999, 999999999);
	formDmgEner = new entityStat(sgID, statTypesShip.statDmgEner, "Energy Damage", "One of two stats that boosts damage. Mostly affects abilities.", 0, -99999, 999999999);
	formResProj = new entityStat(sgID, statTypesShip.statResProj, "Projectile Resistance", "Reduces damage from enemy projectiles, lasers, explosions, etc.", formData.formStats.fsResProj, -99999, 999999999);
	formResColl = new entityStat(sgID, statTypesShip.statResColl, "Collision Resistance", "Reduces damage taken from colliding with enemies.", formData.formStats.fsResColl, -99999, 999999999);
	formResElem = new entityStat(sgID, statTypesShip.statResElem, "Elemental Resistance", "Reduces damage taken from elementally-aspected damage.", formData.formStats.fsResElem, -99999, 999999999);
	formResCC = new entityStat(sgID, statTypesShip.statResCC, "Disable Resistance", "Reduces the duration that movement-affecting debuffs are applied for.", 0, -99999, 999999999);
	
	formSpdAtt = new entityStat(sgID, statTypesShip.statSpdAtt, "Attack Speed", "How quickly the ship fires standard shots.", formData.formStats.fsAttSpd, 0, 999999999);
	formSpdSpell = new entityStat(sgID, statTypesShip.statSpdSpell, "Spell Speed", "Reduces the cooldown duration of abilities.", 0, -999999, 999999999);
	
	formLSAtt = new entityStat(sgID, statTypesShip.statLSAtt, "Attack Lifesteal", "The percentage of damage dealt by standard shots that the player heals for.", 0, 0, 999999999);
	formLSSpell = new entityStat(sgID, statTypesShip.statLSSpell, "Spell Lifesteal", "The percentage of damage dealt by abilities that the player heals for.", 0, 0, 999999999);
	
	formDbfDur = new entityStat(sgID, statTypesShip.statDurDebf, "Debuff Duration", "Increases how long debuffs that the player applies to enemies last for.", 0, -999999, 999999999);
}