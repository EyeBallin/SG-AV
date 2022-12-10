function dpFormsPlayer() {
	var allSpd = 12;
	
	//Fire
	global.sgFormData[sgForm.formFire].addFormInfo(#FF0000, "Fire Form", "Deals decently strong mixed damage through a variety of means, but has low range standard shots.", projIDEnum.ssFire,
		{ fsHP: 100, fsMana: 110, fsAttSpd: 9, fsResColl: 0.03, fsResProj: 0.02, fsResElem: 0, fsResType: elementTypes.eFire,
		fsLSAtt: 0, fsLSSpell: 0, fsMoveSpd: allSpd, fsHPRegen: 10, fsManaRegen: 10 });
	global.sgFormData[sgForm.formFire].formSSCode = function(shipEnt, attTimer, extraProjCount) {
		attTimer += 60/getCurrForm().formSpdAtt.getStatCurr();
		if (extraProjCount = 0)
			createProjectilePlayer(shipEnt.x, shipEnt.y-60, getCurrForm().formShot);
		else
			createProjectilePlayer(shipEnt.x + random_range(-15, 15), shipEnt.y-60, getCurrForm().formShot);
		extraProjCount = 1;
		return {retAttTimer: attTimer, retExtraProj: extraProjCount};
	}
	global.sgFormData[sgForm.formFire].formQCode = function(shipEnt) {
		createProjectilePlayer(shipEnt.x, shipEnt.y-60, projIDEnum.spFireFireball);
	}
		
	//Electric
	global.sgFormData[sgForm.formElec].addFormInfo(#FFFF00, "Electric Form", "Damages and disables sparse groups of enemies, and has occasional single-target burst.", projIDEnum.ssElec,
		{ fsHP: 100, fsMana: 110, fsAttSpd: 7, fsResColl: 0.02, fsResProj: 0.03, fsResElem: 0, fsResType: elementTypes.eElec,
		fsLSAtt: 0, fsLSSpell: 0, fsMoveSpd: allSpd, fsHPRegen: 10, fsManaRegen: 10 });
	global.sgFormData[sgForm.formElec].formSSCode = function(shipEnt, attTimer, extraProjCount) {
		attTimer += 60/getCurrForm().formSpdAtt.getStatCurr();
		if (extraProjCount = 0)
			createProjectilePlayer(shipEnt.x, shipEnt.y-60, getCurrForm().formShot);
		else
			createProjectilePlayer(shipEnt.x + random_range(-15, 15), shipEnt.y-60, getCurrForm().formShot);
		extraProjCount = 1;
		return {retAttTimer: attTimer, retExtraProj: extraProjCount};
	}
		
	//Poison
	global.sgFormData[sgForm.formPsn].addFormInfo(#00FF00, "Poison Form", "Spreads heavily-damaging and crippling toxins with fire-and-forget abilities.", projIDEnum.ssPsn,
		{ fsHP: 90, fsMana: 105, fsAttSpd: 5, fsResColl: 0.025, fsResProj: 0.025, fsResElem: 0, fsResType: elementTypes.ePsn,
		fsLSAtt: 0, fsLSSpell: 0, fsMoveSpd: allSpd, fsHPRegen: 10, fsManaRegen: 10 });
	global.sgFormData[sgForm.formPsn].formSSCode = function(shipEnt, attTimer, extraProjCount) {
		attTimer += 60/getCurrForm().formSpdAtt.getStatCurr();
		if (extraProjCount = 0)
			createProjectilePlayer(shipEnt.x, shipEnt.y-60, getCurrForm().formShot);
		else
			createProjectilePlayer(shipEnt.x + random_range(-15, 15), shipEnt.y-60, getCurrForm().formShot);
		extraProjCount = 1;
		return {retAttTimer: attTimer, retExtraProj: extraProjCount};
	}
		
	//Ice
	global.sgFormData[sgForm.formIce].addFormInfo(#00FFFF, "Ice Form", "Specialises in defensive lockdown and area denial, but can potentially deal decent elemental damage.", projIDEnum.ssIce,
		{ fsHP: 120, fsMana: 100, fsAttSpd: 6, fsResColl: 0.025, fsResProj: 0.025, fsResElem: 0, fsResType: elementTypes.eIce,
		fsLSAtt: 0, fsLSSpell: 0, fsMoveSpd: allSpd, fsHPRegen: 10, fsManaRegen: 10 });
	global.sgFormData[sgForm.formIce].formSSCode = function(shipEnt, attTimer, extraProjCount) {
		attTimer += 60/getCurrForm().formSpdAtt.getStatCurr();
		if (extraProjCount = 0)
			createProjectilePlayer(shipEnt.x, shipEnt.y-60, getCurrForm().formShot);
		else
			createProjectilePlayer(shipEnt.x + random_range(-15, 15), shipEnt.y-60, getCurrForm().formShot);
		extraProjCount = 1;
		return {retAttTimer: attTimer, retExtraProj: extraProjCount};
	}
		
	//Light
	global.sgFormData[sgForm.formLight].addFormInfo(#FFFFFF, "Light Form", "Can deal extreme on-hit damage with its rapid-fire passively doubled standard shots.", projIDEnum.ssLight,
		{ fsHP: 85, fsMana: 115, fsAttSpd: 10, fsResColl: 0.01, fsResProj: 0.04, fsResElem: 0, fsResType: elementTypes.eLight,
		fsLSAtt: 0, fsLSSpell: 0, fsMoveSpd: allSpd, fsHPRegen: 10, fsManaRegen: 10 });
	global.sgFormData[sgForm.formLight].formSSCode = function(shipEnt, attTimer, extraProjCount) {
		attTimer += 60/getCurrForm().formSpdAtt.getStatCurr();
		if (extraProjCount = 0) {
			createProjectilePlayer(shipEnt.x + 10, shipEnt.y-60, getCurrForm().formShot);
			createProjectilePlayer(shipEnt.x - 10, shipEnt.y-60, getCurrForm().formShot);
		}
		else {
			createProjectilePlayer(shipEnt.x + 10 + random_range(-15, 10), shipEnt.y-60, getCurrForm().formShot);
			createProjectilePlayer(shipEnt.x - 10 + random_range(-10, 15), shipEnt.y-60, getCurrForm().formShot);
		}
		extraProjCount = 1;
		return {retAttTimer: attTimer, retExtraProj: extraProjCount};
	}
		
	//Dark
	global.sgFormData[sgForm.formDark].addFormInfo(#000000, "Dark Form", "A bulky form with slow but hard-hitting projectiles and abilities.", projIDEnum.ssDark,
		{ fsHP: 110, fsMana: 100, fsAttSpd: 4, fsResColl: 0.04, fsResProj: 0.01, fsResElem: 0, fsResType: elementTypes.eDark, 
		fsLSAtt: 0, fsLSSpell: 0, fsMoveSpd: allSpd, fsHPRegen: 10, fsManaRegen: 10 });
	global.sgFormData[sgForm.formDark].formSSCode = function(shipEnt, attTimer, extraProjCount) {
		attTimer += 60/getCurrForm().formSpdAtt.getStatCurr();
		if (extraProjCount = 0)
			createProjectilePlayer(shipEnt.x, shipEnt.y-60, getCurrForm().formShot);
		else
			createProjectilePlayer(shipEnt.x + random_range(-15, 15), shipEnt.y-60, getCurrForm().formShot);
		extraProjCount = 1;
		return {retAttTimer: attTimer, retExtraProj: extraProjCount};
	}
	
	//Siege
	global.sgFormData[sgForm.formSiege].addFormInfo(#FF00FF, "Siege Form", "Ramps up over time to unleash a deluge of strong but inaccurate standard shots.", projIDEnum.ssSiege,
		{ fsHP: 105, fsMana: 100, fsAttSpd: 12, fsResColl: 0, fsResProj: 0.05, fsResElem: 0, fsResType: elementTypes.eNone,
		fsLSAtt: 0, fsLSSpell: 0, fsMoveSpd: allSpd, fsHPRegen: 10, fsManaRegen: 10 });
	global.sgFormData[sgForm.formSiege].formSSCode = function(shipEnt, attTimer, extraProjCount) {
		attTimer += 60/getCurrForm().formSpdAtt.getStatCurr();
		if (extraProjCount = 0)
			createProjectilePlayer(shipEnt.x, shipEnt.y-60, getCurrForm().formShot);
		else
			createProjectilePlayer(shipEnt.x + random_range(-15, 15), shipEnt.y-60, getCurrForm().formShot);
		extraProjCount = 1;
		return {retAttTimer: attTimer, retExtraProj: extraProjCount};
	}

	//Power
	global.sgFormData[sgForm.formPower].addFormInfo(#0000FF, "Power Form", "Slowly fires extremely strong standard shots. Very good at dealing damage in a straight line.", projIDEnum.ssPower,
		{ fsHP: 90, fsMana: 120, fsAttSpd: 1.5, fsResColl: 0.05, fsResProj: 0, fsResElem: 0, fsResType: elementTypes.eNone,
		fsLSAtt: 0, fsLSSpell: 0, fsMoveSpd: allSpd, fsHPRegen: 10, fsManaRegen: 10 });
	global.sgFormData[sgForm.formPower].formSSCode = function(shipEnt, attTimer, extraProjCount) {
		attTimer += 60/getCurrForm().formSpdAtt.getStatCurr();
		if (extraProjCount = 0)
			createProjectilePlayer(shipEnt.x, shipEnt.y-60, getCurrForm().formShot);
		else
			createProjectilePlayer(shipEnt.x + random_range(-15, 15), shipEnt.y-60, getCurrForm().formShot);
		extraProjCount = 1;
		return {retAttTimer: attTimer, retExtraProj: extraProjCount};
	}
}