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
	return augPassiveArr;
}