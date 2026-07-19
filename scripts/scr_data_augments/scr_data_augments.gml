/// @desc Populate augment info lines
/// @self obj_ctrl_info
/// @param {Array<Struct.infoAugmentLine>} augArr Augment info line
function dpAugments(augArr) {
	//Level 1
	
	augArr[augIDs.aFarawayScope].addAugInfo("Faraway Scope",
		"Some sort of contraption that has a strong magnifying effect, powered by subtle magic.",
		-1, 2, 350, [augIDs.aGlimmerShard, augIDs.aVoidRune, augIDs.aSharpClaw],
		new augStatsStruct([
			{statName: "hp", statVal: 0.15, statPerc: true},
			{statName: "mana", statVal: 0.15, statPerc: true},
			{statName: "physDmg", statVal: 10, statPerc: false}
		]),
		[
			infoAugmentPassives[augPassiveIDs.apLongShot][0]
		]
	);
	
	augArr[augIDs.aLifebinder].addAugInfo("Lifebinder",
		"A very rare vine that only grows in Aetherglades. The conditions for its seed to sprout have recently been reverse-engineered, and a collection of rare augments can be combined to simulate its ideal environment. What the vine actually does, however, is still under heavy research.",
		-1, 3, 825, [augIDs.aSerpentineBracer, augIDs.aFlowingOrb, augIDs.aSolarCoin, augIDs.aCrystalFlake],
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
	);
	
	augArr[augIDs.aRealityMelter].addAugInfo("Reality Melter",
		"A cube that seems to tear apart the fabric of time and space around it just by existing. Touching it is out of the question, but it can be moved with telekinesis to melt through anything - except matter from the Void. It was found in a box made of Void Marble in the Crystoid Catacombs.",
		-1, 3, 1000, [augIDs.aAcidVial, augIDs.aSplatterMatter, augIDs.aFirewall],
		new augStatsStruct([
			{statName: "hp", statVal: 0.2, statPerc: true},
			{statName: "physDmg", statVal: 25, statPerc: false},
			{statName: "energyDmg", statVal: 25, statPerc: false},
			{statName: "attSpd", statVal: 0.25, statPerc: true},
			{statName: "spellSpd", statVal: 0.15, statPerc: true},
			{statName: "projRes", statVal: 7.5, statPerc: false},
			{statName: "collRes", statVal: 7.5, statPerc: false}
		]),
		[
			infoAugmentPassives[augPassiveIDs.apCausticWounds][1],
			infoAugmentPassives[augPassiveIDs.apSplat][1],
			infoAugmentPassives[augPassiveIDs.apFlareConduit][0],
			infoAugmentPassives[augPassiveIDs.apMeltdown][0]
		]
	);
}