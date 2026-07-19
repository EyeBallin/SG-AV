/// @desc Populate augment info lines
/// @param {Array<Struct.infoAugmentLine>} augArr Augment info line
function dpAugments(augArr) {
	//Level 1

	
	{augArr[augIDs.aFarawayScope].addAugInfo("Faraway Scope",
		"Some sort of contraption that has a strong magnifying effect, powered by subtle magic.",
		-1, 350, [augIDs.aGlimmerShard, augIDs.aVoidRune, augIDs.aSharpClaw],
		new augStatsStruct([
			{statName: "hp", statVal: 0.15, statPerc: true},
			{statName: "mana", statVal: 0.15, statPerc: true},
			{statName: "physDmg", statVal: 10, statPerc: false}
		]),
		[
			infoAugmentPassives[augPassiveIDs.apLongShot][0]
		]
	);}
	
	{augArr[augIDs.aLifebinder].addAugInfo("Lifebinder",
		"A very rare vine that only grows in Aetherglades. The conditions for its seed to sprout have recently been reverse-engineered, and a collection of rare augments can be combined to simulate its ideal environment. What the vine actually does, however, is still under heavy research.",
		-1, 825, [augIDs.aSerpentineBracer, augIDs.aFlowingOrb, augIDs.aSolarCoin, augIDs.aCrystalFlake],
		new augStatsStruct([
			{statName: "hp", statVal: 0.6, statPerc: true},
			{statName: "hpRegen", statVal: 0.7, statPerc: true},
			{statName: "manaRegen", statVal: 0.5, statPerc: true},
			{statName: "projRes", statVal: 12.5, statPerc: false},
			{statName: "collRes", statVal: 12.5, statPerc: false}
		]),
		[
			infoAugmentPassives[augPassiveIDs.apLastStand][1],
			infoAugmentPassives[augPassiveIDs.apSoulbound][0]
		]
	);}
}