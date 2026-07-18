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
}