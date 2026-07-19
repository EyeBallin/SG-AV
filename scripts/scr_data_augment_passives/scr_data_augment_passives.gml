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
	augPassiveArr[augPassiveIDs.apSoulbound][0] = new infoAugmentPassive(augPassiveIDs.apLastStand, "Soulbound",
		"You occasionally become bound to a random enemy, healing from damage it takes and deals.\nDestroying the bound enemy briefly boosts your damage.",
		"Every 10 seconds, you become bound to a random enemy for 4 seconds. You heal for 50% of the damage dealt to the bound enemy, and for 100% of the damage the bound enemy deals to you. These numbers are halved for bound bosses.\nAdditionally, when a bound enemy is destroyed, gain the Soulburst buff for 2 seconds, which increases your Physical Dmg and Energy Dmg stats by +25.\n[slant]Copies of this passive increase the amount of enemies you can be bound to by +1.[/slant]",
		0,
		[]
	);
	return augPassiveArr;
}