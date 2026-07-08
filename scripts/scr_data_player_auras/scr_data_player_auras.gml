/*
{ auSpr: , auSizeVar: , auSprRotDir: , auCol: , auColB: , auColC: , auDur: },
{ auBase: , auPhys: , auEner: , auResHit: , auElem: , auEdgeMult: , auRoundRad: }
*/

function dpAurasPlayer(auraArr) {
    auraArr[auraIDEnum.auFireE].addAuraInfo(
		{ auSpr: spr_aura, auSizeVar: 0, auSprRotDir: 0, auCol: #FF0000, auDur: 45 },
		{ auEdgeMult: 1, auRoundRad: 200 }
	);
}