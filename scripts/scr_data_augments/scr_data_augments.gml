/// @desc Populate augment info lines
/// @self obj_ctrl_info
/// @param {Array<Struct.infoAugmentLine>} augArr Augment info line
function dpAugments(augArr) {
	//Level 1
	
	augArr[augIDs.aGlimmerShard].addAugInfo(getString("augNameGS"), getString("augDescGS"),
		spr_aug_aGlimmerShard, 0, 125, [],
		new augStatsStruct([
			{statName: "hp", statVal: 0.15, statPerc: true},
		]),
		[]
	);
	
	augArr[augIDs.aVoidRune].addAugInfo(getString("augNameVR"), getString("augDescVR"),
		spr_aug_aVoidShard, 0, 125, [],
		new augStatsStruct([
			{statName: "mana", statVal: 0.15, statPerc: true},
		]),
		[]
	);
	
	augArr[augIDs.aVigorVial].addAugInfo(getString("augNameVV"), getString("augDescVV"),
		spr_aug_aVigorVial, 0, 75, [],
		new augStatsStruct([
			{statName: "hpRegen", statVal: 0.15, statPerc: true}
		]),
		[]
	);
	
	augArr[augIDs.aEssenceVial].addAugInfo(getString("augNameEV"), getString("augDescEV"),
		spr_aug_aEssenceVial, 0, 75, [],
		new augStatsStruct([
			{statName: "manaRegen", statVal: 0.15, statPerc: true}
		]),
		[]
	);
	
	augArr[augIDs.aSharpClaw].addAugInfo(getString("augNameSC"), getString("augDescSC"),
		spr_aug_aSharpClaw, 0, 125, [],
		new augStatsStruct([
			{statName: "physDmg", statVal: 5, statPerc: false}
		]),
		[]
	);
	
	augArr[augIDs.aEyeballPendant].addAugInfo(getString("augNameEP"), getString("augDescEP"),
		spr_ui_test_aug, 0, 125, [],
		new augStatsStruct([
			{statName: "energyDmg", statVal: 5, statPerc: false}
		]),
		[]
	);
	
	augArr[augIDs.aHollowFang].addAugInfo(getString("augNameHF"), getString("augDescHF"),
		spr_ui_test_aug, 0, 100, [],
		new augStatsStruct([
			{statName: "attLS", statVal: 0.05, statPerc: true}
		]),
		[]
	);
	
	augArr[augIDs.aLeechingWire].addAugInfo(getString("augNameLW"), getString("augDescLW"),
		spr_ui_test_aug, 0, 100, [],
		new augStatsStruct([
			{statName: "spellLS", statVal: 0.05, statPerc: true}
		]),
		[]
	);
	
	augArr[augIDs.aHardStone].addAugInfo(getString("augNameHS"), getString("augDescHS"),
		spr_ui_test_aug, 0, 125, [],
		new augStatsStruct([
			{statName: "collRes", statVal: 5, statPerc: false}
		]),
		[]
	);
	
	augArr[augIDs.aSilverRing].addAugInfo(getString("augNameSR"), getString("augDescSR"),
		spr_ui_test_aug, 0, 125, [],
		new augStatsStruct([
			{statName: "projRes", statVal: 5, statPerc: false}
		]),
		[]
	);
	
	augArr[augIDs.aOilCube].addAugInfo(getString("augNameOC"), getString("augDescOC"),
		spr_ui_test_aug, 0, 100, [],
		new augStatsStruct([
			{statName: "attSpd", statVal: 0.05, statPerc: true}
		]),
		[]
	);
	
	augArr[augIDs.aSandSphere].addAugInfo(getString("augNameSS"), getString("augDescSS"),
		spr_ui_test_aug, 0, 100, [],
		new augStatsStruct([
			{statName: "spellSpd", statVal: 0.05, statPerc: true}
		]),
		[]
	);
	
	augArr[augIDs.aCopperBand].addAugInfo(getString("augNameCB"), getString("augDescCB"),
		spr_ui_test_aug, 0, 75, [],
		new augStatsStruct([
			{statName: "ccRes", statVal: 0.05, statPerc: true}
		]),
		[]
	);
	
	augArr[augIDs.aGlowingBulb].addAugInfo(getString("augNameGB"), getString("augDescGB"),
		spr_ui_test_aug, 0, 50, [],
		new augStatsStruct([
			{statName: "debuffDur", statVal: 0.15, statPerc: true}
		]),
		[]
	);
	
	augArr[augIDs.aCrystalFlake].addAugInfo("Crystal Flake", "These hand-carved ice crystals are a staple souvenir of Diopola City. It's only slightly cold to touch.",
		spr_aug_aCrystalFlake, 1, 200, [augIDs.aGlimmerShard],
		new augStatsStruct([
			{statName: "hp", statVal: 0.15, statPerc: true},
			{statName: "projRes", statVal: 5, statPerc: false},
			{statName: "collRes", statVal: 5, statPerc: false}
		]),
		[]
	);
	
	augArr[augIDs.aFlowingOrb].addAugInfo("Flowing Orb", "Combining the Vigor Vial and Essence Vial's liquids resulted in the creation of this constantly-swirling solution. Nobody's dared to drink it yet.",
		spr_aug_aFlowingOrb, 1, 150, [augIDs.aVigorVial, augIDs.aEssenceVial],
		new augStatsStruct([
			{statName: "hpRegen", statVal: 0.2, statPerc: true},
			{statName: "manaRegen", statVal: 0.2, statPerc: true}
		]),
		[]
	);
	
	augArr[augIDs.aSolarCoin].addAugInfo("Solar Coin", "A commemorative coin made by the Sun Manifest. Its slight radiant energy makes it warm to touch.",
		spr_aug_aSolarCoin, 1, 175, [augIDs.aVigorVial, augIDs.aGlimmerShard],
		new augStatsStruct([
			{statName: "hp", statVal: 0.2, statPerc: true},
			{statName: "hpRegen", statVal: 0.2, statPerc: true},
		]),
		[]
	);
	
	augArr[augIDs.aSoulBlade].addAugInfo(getString("augNameSoulBlade"), getString("augDescSoulBlade"),
		spr_aug_aSoulBlade, 1, 150, [augIDs.aSharpClaw, augIDs.aHollowFang],
		new augStatsStruct([
			{statName: "physDmg", statVal: 7.5, statPerc: false},
			{statName: "attLS", statVal: 0.075, statPerc: true}
		]),
		[]
	);
	
	augArr[augIDs.aTerrorClaw].addAugInfo(getString("augNameTerrorClaw"), getString("augDescTerrorClaw"),
		spr_aug_aTerrorClaw, 1, 125, [augIDs.aSharpClaw, augIDs.aSharpClaw],
		new augStatsStruct([
			{statName: "physDmg", statVal: 12.5, statPerc: false}
		]),
		[]
	);
	
	augArr[augIDs.aIgnitionFlare].addAugInfo(getString("augNameIgnitionFlare"), getString("augDescIgnitionFlare"),
		spr_ui_test_aug, 1, 175, [augIDs.aSharpClaw, augIDs.aOilCube],
		new augStatsStruct([
			{statName: "physDmg", statVal: 7.5, statPerc: false},
			{statName: "attSpd", statVal: 0.1, statPerc: true}
		]),
		[]
	);
	
	
	
	augArr[augIDs.aOrbofSun].addAugInfo("Orb of Sun", "These highly complex relics spawned from the first clash between the System and the Void. Orbs of Sun hold an incredible amount of light energy.",
		spr_aug_aOrbOfSun, 2, 250, [augIDs.aSolarCoin, augIDs.aFlowingOrb],
		new augStatsStruct([
			{statName: "hp", statVal: 0.3, statPerc: true},
			{statName: "hpRegen", statVal: 0.4, statPerc: true},
			{statName: "manaRegen", statVal: 0.3, statPerc: true},
		]),
		[
			infoAugmentPassives[augPassiveIDs.apInnerFlame][0]
		]
	);
	
	augArr[augIDs.aGaiaSword].addAugInfo(getString("augNameGaiaSword"), getString("augDescGaiaSword"),
		spr_ui_test_aug, 2, 275, [augIDs.aSoulBlade, augIDs.aSoulBlade, augIDs.aLeechingWire],
		new augStatsStruct([
			{statName: "physDmg", statVal: 20, statPerc: false},
			{statName: "attLS", statVal: 0.2, statPerc: true},
			{statName: "spellLS", statVal: 0.075, statPerc: true}
		]),
		[
			infoAugmentPassives[augPassiveIDs.apSoulBurner][0]
		]
	);
	
	augArr[augIDs.aSerpentineBracer].addAugInfo("Serpentine Bracer", "An ancient relic from a long-lost tribe that once lived in the Emerald Jungle. Although plentiful, these armguards obviously held significance, as they are all uniquely patterned.",
		spr_ui_test_aug, 2, 250, [augIDs.aCrystalFlake, augIDs.aFlowingOrb],
		new augStatsStruct([
			{statName: "hp", statVal: 0.2, statPerc: true},
			{statName: "hpRegen", statVal: 0.25, statPerc: true},
			{statName: "manaRegen", statVal: 0.25, statPerc: true},
			{statName: "projRes", statVal: 5, statPerc: false},
			{statName: "collRes", statVal: 5, statPerc: false}
		]),
		[
			infoAugmentPassives[augPassiveIDs.apLastStand][0]
		]
	);
	
	augArr[augIDs.aFarawayScope].addAugInfo("Faraway Scope",
		"Some sort of contraption that has a strong magnifying effect, powered by subtle magic.",
		spr_ui_test_aug, 2, 350, [augIDs.aGlimmerShard, augIDs.aVoidRune, augIDs.aSharpClaw],
		new augStatsStruct([
			{statName: "hp", statVal: 0.15, statPerc: true},
			{statName: "mana", statVal: 0.15, statPerc: true},
			{statName: "physDmg", statVal: 10, statPerc: false}
		]),
		[
			infoAugmentPassives[augPassiveIDs.apLongShot][0]
		]
	);
	
	augArr[augIDs.aKonFoundsDagger].addAugInfo(getString("augNameKonFoundsDagger"), getString("augDescKonFoundsDagger"),
		spr_aug_aKonFoundsDagger, 3, 600, [augIDs.aGaiaSword, augIDs.aIgnitionFlare, augIDs.aIgnitionFlare, augIDs.aTerrorClaw],
		new augStatsStruct([
			{statName: "physDmg", statVal: 55, statPerc: false},
			{statName: "attSpd", statVal: 0.2, statPerc: true},
			{statName: "attLS", statVal: 0.2, statPerc: true},
			{statName: "spellLS", statVal: 0.1, statPerc: true},
		]),
		[
			infoAugmentPassives[augPassiveIDs.apSoulBurnerKonFound][1],
			infoAugmentPassives[augPassiveIDs.apTimeSplicer][0]
		]
	);
	
	augArr[augIDs.aLifebinder].addAugInfo("Lifebinder",
		"A very rare vine that only grows in Aetherglades. The conditions for its seed to sprout have recently been reverse-engineered, and a collection of rare augments can be combined to simulate its ideal environment. What the vine actually does, however, is still under heavy research.",
		spr_ui_test_aug, 3, 825, [augIDs.aSerpentineBracer, augIDs.aOrbofSun, augIDs.aCrystalFlake],
		new augStatsStruct([
			{statName: "hp", statVal: 0.7, statPerc: true},
			{statName: "hpRegen", statVal: 0.65, statPerc: true},
			{statName: "manaRegen", statVal: 0.55, statPerc: true},
			{statName: "projRes", statVal: 12.5, statPerc: false},
			{statName: "collRes", statVal: 12.5, statPerc: false}
		]),
		[
			infoAugmentPassives[augPassiveIDs.apLastStand][1],
			infoAugmentPassives[augPassiveIDs.apInnerFlame][1],
			infoAugmentPassives[augPassiveIDs.apSoulbound][0]
		]
	);
	
	augArr[augIDs.aRealityMelter].addAugInfo("Reality Melter",
		"A cube that seems to tear apart the fabric of time and space around it just by existing. Touching it is out of the question, but it can be moved with telekinesis to melt through anything - except matter from the Void. It was found in a box made of Void Marble in the Crystoid Catacombs.",
		spr_ui_test_aug, 3, 1000, [augIDs.aAcidVial, augIDs.aSplatterMatter, augIDs.aFirewall],
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