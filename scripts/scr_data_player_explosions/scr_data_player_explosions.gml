/*
{ exSpr: , exShape: , exSizeVar: , exSprRotDir: , exColA: , exColB: , exColC: , exDur: },
{ exBase: , exPhys: , exEner: , exDmgType: , exResHit: , exElem: , exEdgeMult: , exRoundRad: },
 * 
{ exDir: , exConeW: }
{ exDir: , exRectW: , exRectH: }
*/

function dpExplosionsPlayer(explArr) {
	explArr[explIDEnum.sgFireW].addExplInfo(
		{ exSpr: spr_expl_abl_fire_flare, exShape: dmgExplShapeEnum.explRect, exSizeVar: 0, exSprRotDir: 0, exColA: #FFFFFF, exColB: #FFCC00, exColC: #FF0000, exDur: 30 },
		{ exDmgType: dmgExplTypeEnum.explCustomFireW, exEdgeMult: 1, exRoundRad: 0 },
    { exDir: 0, exRectW: 150, exRectH: 450 }
	);
    
  explArr[explIDEnum.sgFireE].addExplInfo(
    { exSpr: spr_dmg_gen_expl, exShape: dmgExplShapeEnum.explRound, exSizeVar: 0, exSprRotDir: 0, exColA: #FF9900, exColB: #FF4400, exColC: #FF0000, exDur: 15},
    { exDmgType: dmgExplTypeEnum.explBoom, exEdgeMult: 1, exRoundRad: 400 },
  );
	
	explArr[explIDEnum.sgTest].addExplInfo(
		{ exSpr: spr_dmg_gen_expl, exShape: dmgExplShapeEnum.explRound, exSizeVar: 0, exSprRotDir: 0, exColA: #FFFFFF, exColB: #FF00FF, exColC: #330033, exDur: 15 },
		{ exDmgType: dmgExplTypeEnum.explBoom, exEdgeMult: 1, exRoundRad: 450 }
	);
}