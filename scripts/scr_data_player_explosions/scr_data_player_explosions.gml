/*
{ exSpr: , exShape: , exSizeVar: , exSprRotDir: , exColA: , exColB: , exColC: , exDur: },
{ exBase: , exPhys: , exEner: , exDmgType: , exResHit: , exElem: , exEdgeMult: , exRoundRad: }
*/

function dpExplosionsPlayer(explArr) {
	explArr[explIDEnum.sgFireW].addExplInfo(
		{ exSpr: spr_expl_abl_fire_flare, exShape: dmgExplShapeEnum.explShaped, exSizeVar: 0, exSprRotDir: 0, exColA: #FFFFFF, exColB: #FFCC00, exColC: #FF0000, exDur: 60 },
		{ exBase: 300, exPhys: 0.6, exEner: 1.8, exDmgType: dmgExplTypeEnum.explBoom, exResHit: dmgResHitTypeEnum.eSpell, exElem: elementTypes.eFire, exEdgeMult: 1, exRoundRad: 0 }
	);
	
	explArr[explIDEnum.sgTest].addExplInfo(
		{ exSpr: spr_dmg_gen_expl, exShape: dmgExplShapeEnum.explRound, exSizeVar: 0, exSprRotDir: 0, exColA: #FFFFFF, exColB: #FF00FF, exColC: #330033, exDur: 15 },
		{ exBase: 300, exPhys: 0.6, exEner: 1.8, exDmgType: dmgExplTypeEnum.explBoom, exResHit: dmgResHitTypeEnum.eSpell, exElem: elementTypes.eNone, exEdgeMult: 1, exRoundRad: 450 }
	);
}