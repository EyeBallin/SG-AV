/// @desc Populate augment info lines
/// @param {Array<Struct.infoAugmentLine>} augArr Augment info line
function dpAugments(augArr) {
	//Level 1

	
	{augArr[augIDs.aFarawayScope].addAugInfo("Faraway Scope",
		"Long Shot [1]: Damage dealt by projectiles is increased the further they've travelled. Damage dealt by beams is increased the further the target is from the ship.\n\n"+
		"Some sort of contraption that has a strong magnifying effect, powered by subtle magic.",
		-1, 350, [augIDs.aGlimmerShard, augIDs.aVoidRune, augIDs.aSharpClaw], [
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
		],
		new augStatsStruct([
			new augStatLineCreator("hp", 0.15, true),
			new augStatLineCreator("mana", 0.15, true),
			new augStatLineCreator("physDmg", 10, false)
		])
	);}
}