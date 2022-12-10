/*
{ prSpr: , prSizeX: , prSizeY: , prRotWithDir: , prScaleVar: },
{ prBase: , prPhys: , prEner: , prType: , prElem: , prResHit: },
{ prSpd: , prSpdVar: , prDir: , prDirVar: , prAcc: , prAccVar: , prPierceAmt: , prPierceDeg: }
*/

function dpProjectilesPlayerFire(projArr) {
	//Fire Form Standard Shot
	projArr[projIDEnum.ssFire].addProjInfo(
		{ prSpr: spr_proj_ss_fire, prSizeX: 2, prSizeY: 2, prRotWithDir: true, prScaleVar: 0 },
		{ prBase: 50, prPhys: 0.6, prEner: 0.35, prType: dmgProjTypeEnum.projSS, prElem: elementTypes.eFire, prResHit: dmgResHitTypeEnum.eAtt },
		{ prSpd: 40, prSpdVar: 5, prDir: 90, prDirVar: 10, prAcc: -3, prAccVar: 0.3, prPierceAmt: 0, prPierceDeg: 1 }
	);
	
	
	//Fire Form Q - Fireball
	projArr[projIDEnum.spFireFireball].addProjInfo(
		{ prSpr: spr_proj_ss_fire, prSizeX: 3, prSizeY: 3, prRotWithDir: true, prScaleVar: 0},
		{ prBase: 250, prPhys: 1, prEner: 1, prType: dmgProjTypeEnum.projAbil, prElem: elementTypes.eFire, prResHit: dmgResHitTypeEnum.eSpell },
		{ prSpd: 25, prSpdVar: 0, prDir: 90, prDirVar: 0, prAcc: 0, prAccVar: 0, prPierceAmt: -1, prPierceDeg: 0 }
	)
}

function dpProjectilesPlayerElec(projArr) {
	//Electric Form Standard Shot
	projArr[projIDEnum.ssElec].addProjInfo(
		{ prSpr: spr_proj_ss_elec, prSizeX: 2, prSizeY: 2, prRotWithDir: true, prScaleVar: 0 },
		{ prBase: 40, prPhys: 0.35, prEner: 0.6, prType: dmgProjTypeEnum.projSS, prElem: elementTypes.eElec, prResHit: dmgResHitTypeEnum.eAtt },
		{ prSpd: 30, prSpdVar: 0, prDir: 90, prDirVar: 0, prAcc: 0, prAccVar: 0, prPierceAmt: 0, prPierceDeg: 1 }
	);
}

function dpProjectilesPlayerPsn(projArr) {
	//Poison Form Standard Shot
	projArr[projIDEnum.ssPsn].addProjInfo(
		{ prSpr: spr_proj_ss_psn, prSizeX: 2, prSizeY: 2, prRotWithDir: true, prScaleVar: 0 },
		{ prBase: 25, prPhys: 0.4, prEner: 0.15, prType: dmgProjTypeEnum.projSS, prElem: elementTypes.ePsn, prResHit: dmgResHitTypeEnum.eAtt },
		{ prSpd: 36, prSpdVar: 0, prDir: 90, prDirVar: 0, prAcc: 0, prAccVar: 0, prPierceAmt: 0, prPierceDeg: 1 }
	);
}

function dpProjectilesPlayerIce(projArr) {
	//Ice Form Standard Shot
	projArr[projIDEnum.ssIce].addProjInfo(
		{ prSpr: spr_proj_ss_ice, prSizeX: 2, prSizeY: 2, prRotWithDir: true, prScaleVar: 0 },
		{ prBase: 30, prPhys: 0.15, prEner: 0.3, prType: dmgProjTypeEnum.projSS, prElem: elementTypes.eIce, prResHit: dmgResHitTypeEnum.eAtt },
		{ prSpd: 20, prSpdVar: 0, prDir: 90, prDirVar: 0, prAcc: 0, prAccVar: 0, prPierceAmt: 0, prPierceDeg: 1 }
	);
}

function dpProjectilesPlayerLight(projArr) {
	//Light Form Standard Shot
	projArr[projIDEnum.ssLight].addProjInfo(
		{ prSpr: spr_proj_ss_light, prSizeX: 2, prSizeY: 2, prRotWithDir: true, prScaleVar: 0 },
		{ prBase: 20, prPhys: 0.4, prEner: 0.1, prType: dmgProjTypeEnum.projSS, prElem: elementTypes.eLight, prResHit: dmgResHitTypeEnum.eAtt },
		{ prSpd: 32, prSpdVar: 0, prDir: 90, prDirVar: 0, prAcc: 0, prAccVar: 0, prPierceAmt: 0, prPierceDeg: 1 }
	);
}

function dpProjectilesPlayerDark(projArr) {
	//Dark Form Standard Shot
	projArr[projIDEnum.ssDark].addProjInfo(
		{ prSpr: spr_proj_ss_drk, prSizeX: 2, prSizeY: 2, prRotWithDir: true, prScaleVar: 0 },
		{ prBase: 75, prPhys: 0.35, prEner: 0.8, prType: dmgProjTypeEnum.projSS, prElem: elementTypes.eDark, prResHit: dmgResHitTypeEnum.eAtt },
		{ prSpd: 20, prSpdVar: 0, prDir: 90, prDirVar: 0, prAcc: 0, prAccVar: 0, prPierceAmt: 0, prPierceDeg: 1 }
	);
}

function dpProjectilesPlayerSiege(projArr) {
	//Siege Form Standard Shot
	projArr[projIDEnum.ssSiege].addProjInfo(
		{ prSpr: spr_proj_ss_siege, prSizeX: 2, prSizeY: 2, prRotWithDir: true, prScaleVar: 0 },
		{ prBase: 35, prPhys: 0.7, prEner: 0, prType: dmgProjTypeEnum.projSS, prElem: elementTypes.eNone, prResHit: dmgResHitTypeEnum.eAtt },
		{ prSpd: 34, prSpdVar: 0, prDir: 90, prDirVar: 10, prAcc: 0, prAccVar: 0, prPierceAmt: 0, prPierceDeg: 1 }
	);
	projArr[projIDEnum.ssSiege].projDataCodeCollide = function(projObj, collObj) {
		createExplosionPlayer(projObj.x, projObj.y, explIDEnum.sgTest);	
	}
}

function dpProjectilesPlayerPower(projArr) {
	//Power Form Standard Shot
	projArr[projIDEnum.ssPower].addProjInfo(
		{ prSpr: spr_proj_ss_pwr, prSizeX: 2, prSizeY: 2, prRotWithDir: true, prScaleVar: 0 },
		{ prBase: 100, prPhys: 0, prEner: 1, prType: dmgProjTypeEnum.projSS, prElem: elementTypes.eNone, prResHit: dmgResHitTypeEnum.eAtt },
		{ prSpd: 50, prSpdVar: 0, prDir: 90, prDirVar: 0, prAcc: 0, prAccVar: 0, prPierceAmt: 0, prPierceDeg: 1 }
	);
	
}