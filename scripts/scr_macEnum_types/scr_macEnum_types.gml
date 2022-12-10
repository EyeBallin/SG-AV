enum entityTypes {
	ePlayer,
	eAlly,
	eEnemyNormal,
	eEnemyBoss,
	eEnemyMinion,
	eNeutral
}

enum elementTypes {
	eNone,
	eFire,
	eElec,
	eIce,
	ePsn,
	eLight,
	eDark,
	eWater
}



enum dmgSrcTypeEnum {
	sProj,
	sBeamBurst,
	sBeamBlast,
	sExpl,
	sAura,
	sDoT,
	sColl,
	sArea,
	sOther
}

enum dmgResHitTypeEnum {
	pProj,
	pColl,
	pViral,
	eAtt,
	eSpell,
	eViral
}

enum resTypesSG {
	rSGProj,
	rSGColl
}

enum resTypesEnemy {
	rEAtt,
	rESpell
}

enum statTypesShip {
	statHP,
	statHPMax,
	statHPRegen,
	statMana,
	statManaMax,
	statManaRegen,
	statShield,
	statShieldMax,
	statDmgPhys,
	statDmgEner,
	statResProj,
	statResColl,
	statResElem,
	statSpdAtt,
	statSpdSpell,
	statSpdMove,
	statResCC,
	statLSAtt,
	statLSSpell,
	statDurDebf
}

enum statTypesEnemy {
	statHP,
	statHPMax,
	statHPRegen,
	statShield,
	statShieldMax,
	statDmgProj,
	statDmgColl,
	statResAtt,
	statResSpell,
	statSpdAtt,
	statSpdMove,
	statLSProj,
	statLSColl,
	statResCC
}
	
enum healType {
	hStandard,
	hItem,
	hLifesteal,
	hStatic
}