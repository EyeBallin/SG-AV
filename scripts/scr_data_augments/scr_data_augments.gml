function dpAugments(augArr) {
	//Level 1
	{augArr[augIDs.aGlimmerShard].addAugInfo("Glimmer Shard",
		"+15% HP\n\n"+
		"A common ice crystal, found in many caves and mines throughout the System.",
		-1, 200, [], [
			[sysEvent.evAugEquip, 0, function(args) {
				if (augUniqueID == args[0].augUniqueID)
					args[1][0].getStatHP().modifyResMax(0.15, true, true);
				return args;
			}],
			[sysEvent.evAugUnequip, 0, function(args) {
				if (augUniqueID == args[0].augUniqueID)
					args[1][0].getStatHP().modifyResMax(-0.15, true, true);
				return args;
			}]
		]);}
		
	{augArr[augIDs.aVoidRune].addAugInfo("Void Rune",
		"+15% Max Mana\n\n"+
		"A small black rock with a purple insignia. The most common Void-originating artifact.",
		-1, 200, [], [
			[sysEvent.evAugEquip, 0, function(args) {
				if (augUniqueID == args[0].augUniqueID) {
					for (var i = 0; i < array_length(args[1]); i += 1)
						args[1][i].getStatMana().modifyResMax(0.15, true, true);
				}
				return args;
			}],
			[sysEvent.evAugUnequip, 0, function(args) {
				if (augUniqueID == args[0].augUniqueID) {
					for (var i = 0; i < array_length(args[1]); i += 1)
						args[1][i].getStatMana().modifyResMax(0.15, true, true);
				}
				return args;
			}]
		]);}

	{augArr[augIDs.aVigorVial].addAugInfo("Vigor Vial",
		"+15% HP Regen\n\n"+
		"A tiny vial filled with a strange red liquid. It's never sold with any labels or packaging, but everyone somehow knows not to drink it.",
		 -1, 125, [], [
			[sysEvent.evAugEquip, 0, function(args) {
				if (augUniqueID == args[0].augUniqueID) {
					for (var i = 0; i < array_length(args[1]); i += 1)
						args[1][i].getStatHPRegen().modifyStat(0.15, true);
				}
				return args;
			}],
			[sysEvent.evAugUnequip, 0, function(args) {
				if (augUniqueID == args[0].augUniqueID) {
					for (var i = 0; i < array_length(args[1]); i += 1)
						args[1][i].getStatHPRegen().modifyStat(-0.15, true);
				}
				return args;
			}]
		]);}

	{augArr[augIDs.aEssenceVial].addAugInfo("Essence Vial",
		"+15% Mana Regen.\n\n"+
		"A small vial filled with an odd blue liquid. It's entirely unknown who or what creates these, but it seems every trinket store has them in stock.",
		 -1, 125, [], [
			[sysEvent.evAugEquip, 0, function(args) {
				if (augUniqueID == args[0].augUniqueID) {
					for (var i = 0; i < array_length(args[1]); i += 1)
						args[1][i].getStatManaRegen().modifyStat(0.15, true);
				}
				return args;
			}],
			[sysEvent.evAugUnequip, 0, function(args) {
				if (augUniqueID == args[0].augUniqueID) {
					for (var i = 0; i < array_length(args[1]); i += 1)
						args[1][i].getStatManaRegen().modifyStat(-0.15, true);
				}
				return args;
			}]
		]);}
		
	{augArr[augIDs.aSharpClaw].addAugInfo("Sharp Claw",
		"+5 Physical Damage\n\n"+
		"The shed claw of a common Mawcible. Don't worry, they moult their claws twice a year! They grow back quickly.",
		-1, 200, [], [
			[sysEvent.evAugEquip, 0, function(args) {
				if (augUniqueID == args[0].augUniqueID) {
					for (var i = 0; i < array_length(args[1]); i += 1)
						args[1][i].getStatDmgPhys().modifyStat(5, false);
				}
				return args;
			}],
			[sysEvent.evAugUnequip, 0, function(args) {
				if (augUniqueID == args[0].augUniqueID) {
					for (var i = 0; i < array_length(args[1]); i += 1)
						args[1][i].getStatDmgPhys().modifyStat(-5, false);
				}
				return args;
			}]
		]);}
		
	{augArr[augIDs.aEyeballPendant].addAugInfo("Eyeball Pendant",
		"+5 Energy Damage\n\n" +
		"A common but gaudy souvenir sold at many tourist traps within The Hub. The eyeball seems to occasionally move a tiny amount.",
		-1, 200, [], [
			[sysEvent.evAugEquip, 0, function(args) {
				if (augUniqueID == args[0].augUniqueID) {
					for (var i = 0; i < array_length(args[1]); i += 1)
						args[1][i].getStatDmgEner().modifyStat(5, false);
				}
				return args;
			}],
			[sysEvent.evAugUnequip, 0, function(args) {
				if (augUniqueID == args[0].augUniqueID) {
					for (var i = 0; i < array_length(args[1]); i += 1)
						args[1][i].getStatDmgEner().modifyStat(-5, false);
				}
				return args;
			}]
		]);}

	{augArr[augIDs.aHollowFang].addAugInfo("Hollow Fang",
		"+5% Attack Lifesteal\n\n"+
		"The fang of a slain Datavore. They fill their teeth hollows with flint, sparking them when they breathe combustible gas clouds to release torrents of fire.",
		 -1, 150, [], [
			[sysEvent.evAugEquip, 0, function(args) {
				if (augUniqueID == args[0].augUniqueID) {
					for (var i = 0; i < array_length(args[1]); i += 1)
						args[1][i].getStatLSAtt().modifyStat(0.05, true);
				}
				return args;
			}],
			[sysEvent.evAugUnequip, 0, function(args) {
				if (augUniqueID == args[0].augUniqueID) {
					for (var i = 0; i < array_length(args[1]); i += 1)
						args[1][i].getStatLSAtt().modifyStat(-0.05, true);
				}
				return args;
			}]
		]);}

	{augArr[augIDs.aLeechingWire].addAugInfo("Leeching Wire",
		"+5% Spell Lifesteal\n\n"+
		"A common tool in the arsenal of criminals and sapient viruses. It can be attached to most machines to siphon their power.",
		 -1, 150, [], [
			[sysEvent.evAugEquip, 0, function(args) {
				if (augUniqueID == args[0].augUniqueID) {
					for (var i = 0; i < array_length(args[1]); i += 1)
						args[1][i].getStatLSSpell().modifyStat(0.05, true);
				}
				return args;
			}],
			[sysEvent.evAugUnequip, 0, function(args) {
				if (augUniqueID == args[0].augUniqueID) {
					for (var i = 0; i < array_length(args[1]); i += 1)
						args[1][i].getStatLSSpell().modifyStat(-0.05, true);
				}
				return args;
			}]
		]);}

	{augArr[augIDs.aOilCube].addAugInfo("Oil Cube",
		"+5% Attack Speed\n\n"+
		"The flagship product sold by Oleum Solutions - a small device that acts as a magnet for oils of all kinds, forming semi-solid cubes for easy storage.",
		 -1, 135, [], [
			[sysEvent.evAugEquip, 0, function(args) {
				if (augUniqueID == args[0].augUniqueID) {
					for (var i = 0; i < array_length(args[1]); i += 1)
						args[1][i].getStatSpdAtt().modifyStat(0.05, true);
				}
				return args;
			}],
			[sysEvent.evAugUnequip, 0, function(args) {
				if (augUniqueID == args[0].augUniqueID) {
					for (var i = 0; i < array_length(args[1]); i += 1)
						args[1][i].getStatSpdAtt().modifyStat(-0.05, true);
				}
				return args;
			}]
		]);}

	{augArr[augIDs.aSandSphere].addAugInfo("Sand Sphere",
		"+5% Spell Speed\n\n"+
		"A naturally-occuring object in the Duneridge Desert. In the middle of the sand is a small crystal that loosely magnetises various types of earth, rock, and silica.",
		 -1, 135, [], [
			[sysEvent.evAugEquip, 0, function(args) {
				if (augUniqueID == args[0].augUniqueID) {
					for (var i = 0; i < array_length(args[1]); i += 1)
						args[1][i].getStatSpdSpell().modifyStat(0.05, true);
				}
				return args;
			}],
			[sysEvent.evAugUnequip, 0, function(args) {
				if (augUniqueID == args[0].augUniqueID) {
					for (var i = 0; i < array_length(args[1]); i += 1)
						args[1][i].getStatSpdSpell().modifyStat(-0.05, true);
				}
				return args;
			}]
		]);}

	{augArr[augIDs.aHardStone].addAugInfo("Hard Stone",
		"+5 Collision Resistance\n\n"+
		"A type of rock that has a microscopic lattice of crystal growing throughout it. It somehow instills sturdiness into other nearby objects.",
		 -1, 180, [], [
			[sysEvent.evAugEquip, 0, function(args) {
				if (augUniqueID == args[0].augUniqueID) {
					for (var i = 0; i < array_length(args[1]); i += 1)
						args[1][i].getStatResColl().modifyStat(5, false);
				}
				return args;
			}],
			[sysEvent.evAugUnequip, 0, function(args) {
				if (augUniqueID == args[0].augUniqueID) {
					for (var i = 0; i < array_length(args[1]); i += 1)
						args[1][i].getStatResColl().modifyStat(-5, false);
				}
				return args;
			}]
		]);}

	{augArr[augIDs.aSilverRing].addAugInfo("Silver Ring",
		"+5 Projectile Resistance\n\n"+
		"Silver ore found in the System naturally has the capacity to slightly repulse light and energy. It's half magic, half science!",
		 -1, 180, [], [
			[sysEvent.evAugEquip, 0, function(args) {
				if (augUniqueID == args[0].augUniqueID) {
					for (var i = 0; i < array_length(args[1]); i += 1)
						args[1][i].getStatResColl().modifyStat(5, false);
				}
				return args;
			}],
			[sysEvent.evAugUnequip, 0, function(args) {
				if (augUniqueID == args[0].augUniqueID) {
					for (var i = 0; i < array_length(args[1]); i += 1)
						args[1][i].getStatResColl().modifyStat(-5, false);
				}
				return args;
			}]
		]);}

	{augArr[augIDs.aCopperBand].addAugInfo("Copper Band",
		"+5% Movement Debuff Resistance\n\n"+
		"A staple augment in the mining and construction industry. It's imbued with a slight amount of magic that sharpens the mind and body.",
		 -1, 115, [], [
			[sysEvent.evAugEquip, 0, function(args) {
				if (augUniqueID == args[0].augUniqueID) {
					for (var i = 0; i < array_length(args[1]); i += 1)
						args[1][i].getStatResCC().modifyStat(0.05, true);
				}
				return args;
			}],
			[sysEvent.evAugUnequip, 0, function(args) {
				if (augUniqueID == args[0].augUniqueID) {
					for (var i = 0; i < array_length(args[1]); i += 1)
						args[1][i].getStatResCC().modifyStat(-0.05, true);
				}
				return args;
			}]
		]);}

	{augArr[augIDs.aGlowingBulb].addAugInfo("Glowing Bulb",
		"+15% Debuff Duration\n\n"+
		"An unusual bulb that has a gentle glow. It sometimes flickers, but only when nobody is looking at it.",
		 -1, 80, [], [
			[sysEvent.evAugEquip, 0, function(args) {
				if (augUniqueID == args[0].augUniqueID) {
					for (var i = 0; i < array_length(args[1]); i += 1)
						args[1][i].getStatDbfDur().modifyStat(0.15, true);
				}
				return args;
			}],
			[sysEvent.evAugUnequip, 0, function(args) {
				if (augUniqueID == args[0].augUniqueID) {
					for (var i = 0; i < array_length(args[1]); i += 1)
						args[1][i].getStatDbfDur().modifyStat(-0.15, true);
				}
				return args;
			}]
		]);}

	//Level 2
	{augArr[augIDs.aSmokescreen].addAugInfo("Smokescreen",
		"+7.5 Physical Damage\n+2.5 Collision Resistance\n\n" +
		"A small device that, when activated, constantly releases a small amount of obscuring smoke.",
		 -1, 75, [augIDs.aSharpClaw], [
			[sysEvent.evAugEquip, 0, function(args) {
				if (augUniqueID == args[0].augUniqueID) {
					for (var i = 0; i < array_length(args[1]); i += 1) {
						args[1][i].getStatDmgPhys().modifyStat(7.5, false);
						args[1][i].getStatResColl().modifyStat(2.5, false);
					}
				}
				return args;
			}],
			[sysEvent.evAugUnequip, 0, function(args) {
				if (augUniqueID == args[0].augUniqueID) {
					for (var i = 0; i < array_length(args[1]); i += 1) {
						args[1][i].getStatDmgPhys().modifyStat(-7.5, false);
						args[1][i].getStatResColl().modifyStat(-2.5, false);
					}
				}
				return args;
			}]
		]);}

	{augArr[augIDs.aBatteryBit].addAugInfo("Battery Bit",
		"+7.5 Energy Damage\n+2.5 Projectile Resistance\n\n" +
		"The cheapest version of the latest line of combined data & energy storage solutions from Parabola Industries!",
		 -1, 75, [augIDs.aEyeballPendant], [
			[sysEvent.evAugEquip, 0, function(args) {
				if (augUniqueID == args[0].augUniqueID) {
					for (var i = 0; i < array_length(args[1]); i += 1) {
						args[1][i].getStatDmgEner().modifyStat(7.5, false);
						args[1][i].getStatResProj().modifyStat(2.5, false);
					}
				}
				return args;
			}],
			[sysEvent.evAugUnequip, 0, function(args) {
				if (augUniqueID == args[0].augUniqueID) {
					for (var i = 0; i < array_length(args[1]); i += 1) {
						args[1][i].getStatDmgEner().modifyStat(-7.5, false);
						args[1][i].getStatResProj().modifyStat(-2.5, false);
					}
				}
				return args;
			}]
		]);}

	{augArr[augIDs.aDataCape].addAugInfo("Data Cape",
		"+7.5 Physical Damage\n+2.5 Energy Damage\n\n" +
		"It takes a skilled dataweaver to be able to use a Sharp Claw to unravel and re-knit the energy matrix of an Eyeball Pendant.",
		 -1, 50, [augIDs.aSharpClaw, augIDs.aEyeballPendant], [
			[sysEvent.evAugEquip, 0, function(args) {
				if (augUniqueID == args[0].augUniqueID) {
					for (var i = 0; i < array_length(args[1]); i += 1) {
						args[1][i].getStatDmgPhys().modifyStat(7.5, false);
						args[1][i].getStatDmgEner().modifyStat(7.5, false);
					}
				}
				return args;
			}],
			[sysEvent.evAugUnequip, 0, function(args) {
				if (augUniqueID == args[0].augUniqueID) {
					for (var i = 0; i < array_length(args[1]); i += 1) {
						args[1][i].getStatDmgPhys().modifyStat(-7.5, false);
						args[1][i].getStatDmgEner().modifyStat(-7.5, false);
					}
				}
				return args;
			}]
		]);}

	{augArr[augIDs.aCrystalFlake].addAugInfo("Crystal Flake",
		"+15% HP\n+5 Collision Resistance\n+5 Projectile Resistance\n\n" +
		"These hand-carved ice crystals are a staple souvenir of Diopola City. It's only slightly cold to touch.",
		 -1, 110, [augIDs.aGlimmerShard], [
			[sysEvent.evAugEquip, 0, function(args) {
				if (augUniqueID == args[0].augUniqueID) {
					args[1][0].getStatHP().modifyResMax(0.15, true, true);
					for (var i = 0; i < array_length(args[1]); i += 1) {
						args[1][i].getStatResColl().modifyStat(5, false);
						args[1][i].getStatResProj().modifyStat(5, false);
					}
				}
				return args;
			}],
			[sysEvent.evAugUnequip, 0, function(args) {
				if (augUniqueID == args[0].augUniqueID) {
					args[1][0].getStatHP().modifyResMax(-0.15, true, true);
					for (var i = 0; i < array_length(args[1]); i += 1) {
						args[1][i].getStatResColl().modifyStat(-5, false);
						args[1][i].getStatResProj().modifyStat(-5, false);
					}
				}
				return args;
			}]
		]);}

	{augArr[augIDs.aFlaskofHeart].addAugInfo("Flask of Heart",
		"+35% HP Regen\n\n"+
		"Lifeglass reacts oddly with the red liquid of the Vigor Vial, causing it to contract and expand like a beating heart.",
		 -1, 35, [augIDs.aVigorVial, augIDs.aVigorVial], [
			[sysEvent.evAugEquip, 0, function(args) {
				if (augUniqueID == args[0].augUniqueID) {
					for (var i = 0; i < array_length(args[1]); i += 1)
						args[1][i].getStatHPRegen().modifyStat(0.35, true);
				}
				return args;
			}],
			[sysEvent.evAugUnequip, 0, function(args) {
				if (augUniqueID == args[0].augUniqueID) {
					for (var i = 0; i < array_length(args[1]); i += 1)
						args[1][i].getStatHPRegen().modifyStat(-0.35, true);
				}
				return args;
			}]
		]);}

	{augArr[augIDs.aFlaskofSoul].addAugInfo("Flask of Soul",
		"+35% Mana Regen\n\n"+
		"Lifeglass reacts strangely with the blue liquid of the Essence Vial, causing it to slowly ripple like waves at a tide pool.",
		 -1, 35, [augIDs.aEssenceVial, augIDs.aEssenceVial], [
			[sysEvent.evAugEquip, 0, function(args) {
				if (augUniqueID == args[0].augUniqueID) {
					for (var i = 0; i < array_length(args[1]); i += 1)
						args[1][i].getStatManaRegen().modifyStat(0.35, true);
				}
				return args;
			}],
			[sysEvent.evAugUnequip, 0, function(args) {
				if (augUniqueID == args[0].augUniqueID) {
					for (var i = 0; i < array_length(args[1]); i += 1)
						args[1][i].getStatManaRegen().modifyStat(-0.35, true);
				}
				return args;
			}]
		]);}

	{augArr[augIDs.aFlowingOrb].addAugInfo("Flowing Orb",
		"+20% HP Regen\n+20% Mana Regen\n\n"+
		"Combining the Vigor Vial and Essence Vial's liquids resulted in the creation of this constantly-swirling solution. Nobody's dared to drink it yet.",
		 -1, 50, [augIDs.aVigorVial, augIDs.aEssenceVial], [
			[sysEvent.evAugEquip, 0, function(args) {
				if (augUniqueID == args[0].augUniqueID) {
					for (var i = 0; i < array_length(args[1]); i += 1) {
						args[1][i].getStatHPRegen().modifyStat(0.20, true);
						args[1][i].getStatManaRegen().modifyStat(0.20, true);
					}
				}
				return args;
			}],
			[sysEvent.evAugUnequip, 0, function(args) {
				if (augUniqueID == args[0].augUniqueID) {
					for (var i = 0; i < array_length(args[1]); i += 1) {
						args[1][i].getStatHPRegen().modifyStat(-0.20, true);
						args[1][i].getStatManaRegen().modifyStat(-0.20, true);
					}
				}
				return args;
			}]
		]);}

	{augArr[augIDs.aSolarCoin].addAugInfo("Solar Coin",
		"+20% HP\n+20% HP Regen\n\n" +
		"A commemorative coin made by the Sun Manifest. Its slight radiant energy makes it warm to touch.",
		 -1, 55, [augIDs.aGlimmerShard, augIDs.aVigorVial], [
			[sysEvent.evAugEquip, 0, function(args) {
				if (augUniqueID == args[0].augUniqueID) {
					args[1][0].getStatHP().modifyResMax(0.20, true, true);
					for (var i = 0; i < array_length(args[1]); i += 1)
						args[1][i].getStatHPRegen().modifyStat(0.2, true);
				}
				return args;
			}],
			[sysEvent.evAugUnequip, 0, function(args) {
				if (augUniqueID == args[0].augUniqueID) {
					args[1][0].getStatHP().modifyResMax(-0.20, true, true);
					for (var i = 0; i < array_length(args[1]); i += 1)
						args[1][i].getStatHPRegen().modifyStat(-0.2, true);
				}
				return args;
			}]
		]);}

	{augArr[augIDs.aFadedCoin].addAugInfo("Faded Coin",
		"+20% Mana\n+20% Mana Regen\n\n" +
		"A tarnished coin of unknown origins. It's slightly magnetic for dark energies.",
		 -1, 55, [augIDs.aVoidRune, augIDs.aEssenceVial], [
			[sysEvent.evAugEquip, 0, function(args) {
				if (augUniqueID == args[0].augUniqueID) {
					args[1][0].getStatMana().modifyResMax(0.2, true, true);
					for (var i = 0; i < array_length(args[1]); i += 1)
						args[1][i].getStatManaRegen().modifyStat(0.2, true);
				}
				return args;
			}],
			[sysEvent.evAugUnequip, 0, function(args) {
				if (augUniqueID == args[0].augUniqueID) {
					args[1][0].getStatMana().modifyResMax(-0.2, true, true);
					for (var i = 0; i < array_length(args[1]); i += 1)
						args[1][i].getStatManaRegen().modifyStat(-0.2, true);
				}
				return args;
			}]
		]);}

	{augArr[augIDs.aSoulBlade].addAugInfo("Soul Blade",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aSoulBrooch].addAugInfo("Soul Brooch",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aRubySiphon].addAugInfo("Ruby Siphon",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aSapphireSiphon].addAugInfo("Sapphire Siphon",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aTerrorClaw].addAugInfo("Terror Claw",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aImbuedPendant].addAugInfo("Imbued Pendant",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aCrypticSlab].addAugInfo("Cryptic Slab",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aMegaShard].addAugInfo("Mega Shard",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aChiseledGemstone].addAugInfo("Chiseled Gemstone",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aMightyArmour].addAugInfo("Mighty Armour",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aMirroredCoat].addAugInfo("Mirrored Coat",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aDualitySlate].addAugInfo("Duality Slate",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aRapidAccelerant].addAugInfo("Rapid Accelerant",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aIgnitionFlare].addAugInfo("Ignition Flare",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aSeerstone].addAugInfo("Seerstone",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aRepulsionBand].addAugInfo("Repulsion Band",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aDiskDrive].addAugInfo("Disk Drive",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aModCore].addAugInfo("Mod Core",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aTempestShard].addAugInfo("Tempest Shard",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aDesertNexus].addAugInfo("Desert Nexus",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aFrostedShield].addAugInfo("Frosted Shield",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aPlatedBrick].addAugInfo("Plated Brick",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aAnodisedBrick].addAugInfo("Anodised Brick",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aCopperChain].addAugInfo("Copper Chain",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aCursedFigurine].addAugInfo("Cursed Figurine",
		"",
		 -1, 0, [], [
			
		]);}
		
	{augArr[augIDs.aFarawayScope].addAugInfo("Faraway Scope",
		"+15% HP\n+15% Max Mana\n+10 Physical Damage\n\n"+
		"Long Shot [1]: Damage dealt by projectiles is increased the further they've travelled. Damage dealt by beams is increased the further the target is from the ship.\n\n"+
		"Some sort of contraption that has a strong magnifying effect, powered by subtle magic.",
		-1, 350, [augIDs.aGlimmerShard, augIDs.aVoidRune, augIDs.aSharpClaw], [
			[sysEvent.evAugEquip, 0, function(args) {
				if (augUniqueID == args[0].augUniqueID) {
					args[1][0].getStatHP().modifyResMax(0.15, true, true);
					for (var i = 0; i < array_length(args[1]); i += 1) {
						args[1][i].getStatMana().modifyResMax(0.15, true, true);
						args[1][i].getStatDmgPhys().modifyStat(10, false);
					}
				}
				return args;
			}],
			[sysEvent.evAugUnequip, 0, function(args) {
				if (augUniqueID == args[0].augUniqueID) {
					args[1][0].getStatHP().modifyResMax(-0.15, true, true);
					for (var i = 0; i < array_length(args[1]); i += 1) {
						args[1][i].getStatMana().modifyResMax(-0.15, true, true);
						args[1][i].getStatDmgPhys().modifyStat(-10, false);
					}
				}
				return args;
			}],
			[sysEvent.evShipDealHit, 0, function(args) {
				if (args[4] == dmgSrcTypeEnum.sProj || args[4] == dmgSrcTypeEnum.sBeamBurst || args[4] == dmgSrcTypeEnum.sBeamBlast) {
					var distMult = clamp(args[0].projDist/600, 0, 1) * 0.25;
					args[3] += distMult;
				}
				return args;
			}]
		]);}

	{augArr[augIDs.aRefractionMuzzle].addAugInfo("Refraction Muzzle",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aFirewall].addAugInfo("Firewall",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aBatteryByte].addAugInfo("Battery Byte",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aBinaryBrooch].addAugInfo("Binary Brooch",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aFrozenProtoCore].addAugInfo("Frozen Proto-Core",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aOrbofSun].addAugInfo("Orb of Sun",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aOrbofVoid].addAugInfo("Orb of Void",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aGaiaSword].addAugInfo("Gaia Sword",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aPowerCore].addAugInfo("Power Core",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aOddPage].addAugInfo("Odd Page",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aSerpentineBracer].addAugInfo("Serpentine Bracer",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aWitherstone].addAugInfo("Witherstone",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aBismuthShard].addAugInfo("Bismuth Shard",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aOrichalcumShard].addAugInfo("Orichalcum Shard",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aDarkGem].addAugInfo("Dark Gem",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aDistortionBelt].addAugInfo("Distortion Belt",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aGemstoneHammer].addAugInfo("Gemstone Hammer",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aDoomDisks].addAugInfo("Doom Disks",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aRocketDisks].addAugInfo("Rocket Disks",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aSawbladeDisks].addAugInfo("Sawblade Disks",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aSwarmDisks].addAugInfo("Swarm Disks",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aShockDisks].addAugInfo("Shock Disks",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aDiskArray].addAugInfo("Disk Array",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aDiskModBase].addAugInfo("DiskMod Base",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aLaserModBase].addAugInfo("LaserMod Base",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aFormModBase].addAugInfo("FormMod Base",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aBronzeDynamite].addAugInfo("Bronze Dynamite",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aSpiritMirror].addAugInfo("Spirit Mirror",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aTorkinsTombstone].addAugInfo("Torkin's Tombstone",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aHarvester].addAugInfo("Harvester",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aSackOFlak].addAugInfo("Sack O' Flak",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aSpitfireSpark].addAugInfo("Spitfire Spark",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aFissionCore].addAugInfo("Fission Core",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aTenacityBadge].addAugInfo("Tenacity Badge",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aAcidVial].addAugInfo("Acid Vial",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aSplatterMatter].addAugInfo("Splatter Matter",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aEchoAmulet].addAugInfo("Echo Amulet",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aEmptyVessel].addAugInfo("Empty Vessel",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aClockworkHeart].addAugInfo("Clockwork Heart",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aTitanolith].addAugInfo("Titanolith",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.a4DHarmonyCore].addAugInfo("D Harmony Core",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aBloodhoundDagger].addAugInfo("Bloodhound Dagger",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aSpellboundDagger].addAugInfo("Spellbound Dagger",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aKonFoundsDagger].addAugInfo("KonFound's Dagger",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aSunder].addAugInfo("Sunder",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aWaveformPrototype].addAugInfo("Waveform Prototype",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aTheODM].addAugInfo("The ODM",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aTemporalTome].addAugInfo("Temporal Tome",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aManifestStatue].addAugInfo("Manifest Statue",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aDreamGauntlet].addAugInfo("Dream Gauntlet",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aTheMothersRing].addAugInfo("The Mother's Ring",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aInfiniteCapacitor].addAugInfo("Infinite Capacitor",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aDoomPendant].addAugInfo("Doom Pendant",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aBrokenGear].addAugInfo("Broken Gear",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aRED].addAugInfo("R.E.D",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aYED].addAugInfo("Y.E.D",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aGED].addAugInfo("G.E.D",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aBED].addAugInfo("B.E.D",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aValeRuber].addAugInfo("Vale Ruber",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aAbyssalDiamond].addAugInfo("Abyssal Diamond",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aMegaGemMallet].addAugInfo("Mega-Gem Mallet",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aDiskModRend].addAugInfo("DiskMod Rend",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aDiskModWither].addAugInfo("DiskMod Wither",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aDiskModStrength].addAugInfo("DiskMod Strength",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aDiskModCrystal].addAugInfo("DiskMod Crystal",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aLaserModSplit].addAugInfo("LaserMod Split",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aLaserModVamp].addAugInfo("LaserMod Vamp",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aLaserModBlast].addAugInfo("LaserMod Blast",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aLaserModRapid].addAugInfo("LaserMod Rapid",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aInfernoChip].addAugInfo("Inferno Chip",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aThunderChip].addAugInfo("Thunder Chip",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aVenomChip].addAugInfo("Venom Chip",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aGlacierChip].addAugInfo("Glacier Chip",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aGoldenGrenade].addAugInfo("Golden Grenade",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aRunicBomb].addAugInfo("Runic Bomb",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aVoidBomb].addAugInfo("Void Bomb",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aSanguineScythe].addAugInfo("Sanguine Scythe",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aCorpseCarver].addAugInfo("Corpse Carver",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aViperRailgun].addAugInfo("Viper Railgun",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aDeltaShotgun].addAugInfo("Delta Shotgun",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aSepfectaLens].addAugInfo("Sepfecta Lens",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aFuriousFirecracker].addAugInfo("Furious Firecracker",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aTheDownpour].addAugInfo("The Downpour",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aCloakofQuicksilver].addAugInfo("Cloak of Quicksilver",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aMountainPlate].addAugInfo("Mountain Plate",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aSearingChemSpike].addAugInfo("Searing Chem-Spike",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aFumesofMadness].addAugInfo("Fumes of Madness",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aDarkEnergyCannon].addAugInfo("Dark Energy Cannon",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aRealityMelter].addAugInfo("Reality Melter",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aTrinityLoop].addAugInfo("Trinity Loop",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aOmniscientGaze].addAugInfo("Omniscient Gaze",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aFactorySoul].addAugInfo("Factory Soul",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aVoidedEmbrace].addAugInfo("Voided Embrace",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aShadowsEmbrace].addAugInfo("Shadow's Embrace",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aSarcoidPike].addAugInfo("Sarcoid Pike",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aReceptorofShatteredData].addAugInfo("Receptor of Shattered Data",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aLifebinder].addAugInfo("Lifebinder",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aPyrridsRing].addAugInfo("Pyrrid's Ring",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aProgrammaticBand].addAugInfo("Programmatic Band",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aCloakingDagger].addAugInfo("Cloaking Dagger",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aByteBlaster].addAugInfo("Byte Blaster",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aOsmiumLauncher].addAugInfo("Osmium Launcher",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aCobraHalberd].addAugInfo("Cobra Halberd",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aQuadratusConcha].addAugInfo("Quadratus Concha",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aProtoSunCrest].addAugInfo("Proto-Sun Crest",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aVoidstarCrown].addAugInfo("Voidstar Crown",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aGearofTime].addAugInfo("Gear of Time",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aEternity].addAugInfo("Eternity",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aBlackGear].addAugInfo("Black Gear",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aFetchingRing].addAugInfo("Fetching Ring",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aDecodingRing].addAugInfo("Decoding Ring",
		"",
		 -1, 0, [], [
			
		]);}

	{augArr[augIDs.aExecutingRing].addAugInfo("Executing Ring",
		"",
		 -1, 0, [], [
			
		]);}

}