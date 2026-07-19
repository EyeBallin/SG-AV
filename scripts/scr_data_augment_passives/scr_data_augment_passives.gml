/// @desc Populate Augment passives array
/// @return Array<Array<Struct.infoAugmentPassive>> Populated Augment passive array
function dpAugmentPassives(augPassiveArr) {
	augPassiveArr[augPassiveIDs.apLongShot][0] = new infoAugmentPassive(augPassiveIDs.apLongShot, "Long Shot",
		"Your projectiles and beam bursts deal more damage the further they've travelled.",
		"Your projectiles gain damage as they travel, up to +15% damage after 750px distance.\nYour beam bursts deal more damage the further away the hit enemy is from you, up to 15% more damage at 750px.\n[slant]Copies of this passive stack additively.[/slant]",
		0,
		[
			{ eventID: sysEvent.evShipDealHit, 
				priority: 0, 
				funcCode: function(args) {
					if (args.dmgCat == dmgSrcTypeEnum.sProj || args.dmgCat == dmgSrcTypeEnum.sBeamBurst || args.dmgCat == dmgSrcTypeEnum.sBeamBlast) {
						var distMult = clamp(args.dmgObj.projDist/600, 0, 1) * 0.25;
						args.extraMult += distMult;
					}
					return args;
				}
			}
		]
	);
	
	augPassiveArr[augPassiveIDs.apLastStand][0] = new infoAugmentPassive(augPassiveIDs.apLastStand, "Last Stand",
		"While your HP is low, your HP Regen and Mana Regen are heavily multiplied.",
		"While your HP is below 20% full, your final HP Regen and Mana Regen are multiplied by x2.\n[slant]Copies of this passive increase the multiplier by +1.[/slant]",
		0,
		[]
	);
	augPassiveArr[augPassiveIDs.apLastStand][1] = new infoAugmentPassive(augPassiveIDs.apLastStand, "Last Stand",
		"While your HP is low, your HP Regen and Mana Regen are heavily multiplied.",
		"While your HP is below 20% full, your final HP Regen and Mana Regen are multiplied by x3.\n[slant]Copies of this passive increase the multiplier by +2.[/slant]",
		1,
		[]
	);
	augPassiveArr[augPassiveIDs.apSoulbound][0] = new infoAugmentPassive(augPassiveIDs.apSoulbound, "Soulbound",
		"You occasionally become bound to a random enemy, healing from damage it takes and deals.\nDestroying the bound enemy briefly boosts your damage.",
		"Every 10 seconds, you become bound to a random enemy for 4 seconds. You heal for 50% of the damage dealt to the bound enemy, and for 100% of the damage the bound enemy deals to you. These numbers are halved for bound bosses.\r\n\r\nAdditionally, when a bound enemy is destroyed, gain the Soulburst buff for 2 seconds, which increases your Physical Dmg and Energy Dmg stats by +25.\r\n\r\n[slant]Copies of this passive increase the amount of enemies you can be bound to by +1.[/slant]",
		0,
		[]
	);
	augPassiveArr[augPassiveIDs.apCausticWounds][0] = new infoAugmentPassive(augPassiveIDs.apCausticWounds, "Caustic Wounds",
		"Standard shots deal damage on-hit and over time that uses Spell Dmg, scales with the target's Max HP, and reduces Attack Res.",
		"Gain the Caustic Wounds on-hit effect for your Standard Shots, which deals X Attack-type damage and applies the Caustic Pain debuff for 2 seconds.\r\n\r\nCaustic Pain deals X damage every 0.5 seconds, plus 1.5% of their Max HP. Every time Caustic Pain deals damage, it also applies a stack of the Caustic Melt debuff for 2 seconds, up to 8 stacks.\r\nCaustic Melt reduces Attack Res by -2.5% per stack.\r\n\r\n[slant]Copies of this passive additively stack the damage of Caustic Wounds, the damage of the Caustic Pain debuff, and the strength per stack of the Caustic Melt debuff.[/slant]",
		0,
		[]
	);
	augPassiveArr[augPassiveIDs.apCausticWounds][1] = new infoAugmentPassive(augPassiveIDs.apCausticWounds, "Caustic Wounds",
		"Standard shots deal damage on-hit and over time that uses Spell Dmg, scales with the target's Max HP, and reduces Attack Res.",
		"Gain the Caustic Wounds on-hit effect for your Standard Shots, which deals X Attack-type damage and applies the Caustic Pain debuff for 2 seconds.\r\n\r\nCaustic Pain deals X damage every 0.5 seconds, plus 2.5% of their Max HP. Every time Caustic Pain deals damage, it also applies a stack of the Caustic Melt debuff for 2 seconds at +40% strength, up to 8 stacks.\r\nCaustic Melt reduces Attack Res by -3.5% per stack (2.5% at +40% strength).\r\n\r\n[slant]Copies of this passive additively stack the damage of Caustic Wounds, the damage of the Caustic Pain debuff, and the strength per stack of the Caustic Melt debuff.[/slant]",
		1,
		[]
	);
	augPassiveArr[augPassiveIDs.apSplat][0] = new infoAugmentPassive(augPassiveIDs.apSplat, "Splat",
		"Standard Shots create cone-shaped damaging pulses on-hit that scale with your Energy Dmg stat.",
		"Your Standard Shots gain the Splat on-hit effect, which causes them to release a conical pulse on-hit that deals X Spell-type damage. The pulse has a 75px radius and a 60-degree arc.\r\n\r\n[slant]Copies of this passive stack the pulse damage additively.[/s]",
		0,
		[]
	);
	augPassiveArr[augPassiveIDs.apSplat][1] = new infoAugmentPassive(augPassiveIDs.apSplat, "Splat",
		"Standard Shots create cone-shaped damaging pulses on-hit that scale with your Energy Dmg stat.",
		"Your Standard Shots gain the Splat on-hit effect, which causes them to release a conical pulse on-hit that deals X Spell-type damage. The pulse has a 100px radius and a 75-degree arc.\r\n\r\n[slant]Copies of this passive stack the pulse damage additively.[/s]",
		1,
		[]
	);
	augPassiveArr[augPassiveIDs.apFlareConduit][0] = new infoAugmentPassive(augPassiveIDs.apFlareConduit, "Flare Conduit",
		"Increases Max Shields by +10%, and converts 25% of incoming Fire-elemental damage into Shield.",
		"Increases your Max Shields by +10%. Upon taking Fire-elemental damage, 25% of the incoming damage is instead applied as a Shield after the remaining 75% of damage is dealt.\r\n\r\n[slant]Copies of this passive stack additively.[/slant]",
		0,
		[]
	);
	augPassiveArr[augPassiveIDs.apMeltdown][0] = new infoAugmentPassive(augPassiveIDs.apMeltdown, "Meltdown",
		"Your explosions and pulses apply on-hit effects at 50% of their normal strength, stacks, and duration.",
		"All of your explosions and pulses now apply all persistent on-hit effects that your Standard Shots normally do. Explosions and pulses made by Standard Shots additionally inherit any temporary on-hit effects that particular shot may have had. On-hit effects triggered by pulses and explosions thanks to Meltdown have 50% less strength, duration, and stacks.\r\n\r\n[slant]Copies of this passive increase the strength of on-hit effects applied by explosions and pulses by +50%.[/slant]",
		0,
		[]
	);
	return augPassiveArr;
}