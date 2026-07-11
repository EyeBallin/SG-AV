if (global.ctrlGameState.currGameState == gameStateEnum.stateActiveGame) {
	explCodeStep(self);

	//Damage targets on first frame
	if (explTimer <= 0) {
		if (explOwner.entityType == entityTypes.ePlayer || explOwner.entityType == entityTypes.eAlly)
			collCheck = obj_enemy;
		if (explOwner.entityType == entityTypes.eEnemyBoss || explOwner.entityType == entityTypes.eEnemyNormal || explOwner.entityType == entityTypes.eEnemyMinion)
			collCheck = obj_sg_av;
		switch(explType) {
			case dmgExplShapeEnum.explCone:
				collCount = collision_circle_list(x, y, explRadiusNum, collCheck, false, true, collListExpl, false);
				if (collCount > 0) {
					var explConeEdgeLX = x + lengthdir_x(explRadiusNum, explDir - explConeW/2);
					var explConeEdgeLY = y + lengthdir_y(explRadiusNum, explDir - explConeW/2);
					var explConeEdgeRX = x + lengthdir_x(explRadiusNum, explDir + explConeW/2);
					var explConeEdgeRY = y + lengthdir_y(explRadiusNum, explDir + explConeW/2);
					var newList = ds_list_create();
					for (var i = 0; i < collCount; i += 1) {
						var foundCol = collListExpl[|i];
						if (rectangle_in_triangle(
							foundCol.x - foundCol.sprite_width/2, 
							foundCol.y - foundCol.sprite_height/2,
							foundCol.x + foundCol.sprite_width/2,
							foundCol.y + foundCol.sprite_height/2,
							x, y, explConeEdgeLX, explConeEdgeLY, explConeEdgeRX, explConeEdgeRY)) {
								ds_list_add(newList, foundCol);
						}
					}
					ds_list_copy(collListExpl, newList);
					collCount = ds_list_size(collListExpl);
					ds_list_destroy(newList);
				}
				break;
			case dmgExplShapeEnum.explRect:
				var collRect = instance_create_depth(x, y, depth, obj_dmg_rect);
				collRect.image_xscale = explRectH/2;
				collRect.image_yscale = explRectW/4;
				collRect.image_angle = explDir;
				with (collRect) {
					other.collCount = instance_place_list(x, y, other.collCheck, other.collListExpl, false);
				}
				instance_destroy(collRect);
				break;
			case dmgExplShapeEnum.explRound: 
			default:
				collCount = collision_circle_list(x, y, explRadiusNum, collCheck, false, true, collListExpl, false);
				break;
		}
		if (collCount > 0) {
			collideExplosion(self, collListExpl);
		}
	}

	explTimer += 1;
	explTimePerc = explTimer/explDur;
	if (explTimePerc < 0.35) {
		explColCurr = merge_colour(explColA, explColB, explTimePerc/0.35);
	} else if (explTimePerc >= 0.35 && explTimePerc < 0.85) {
		explColCurr = merge_color(explColB, explColC, (explTimePerc - 0.35)/0.5);
	} else if (explTimePerc >= 0.85) {
		explColCurr = explColC;
	}

	switch (explDmgType) {
		case dmgExplTypeEnum.explPulse:
			explAlphaCurr = 1 - explTimePerc;
			explScaleCurr = 1;
			break;
		case dmgExplTypeEnum.explCustomFireW:
			explAlphaCurr = max(0, 1-(explTimePerc*1)); 
			explScaleCurr = min(1, explTimePerc * 4);
			break;
		case dmgExplTypeEnum.explBoom:
		default:
			explAlphaCurr = max(0, 1-(explTimePerc*1));
			explScaleCurr = min(1, explTimePerc * 2);
			break;
	}

	if (explTimePerc >= 1) {
		instance_destroy();
	}
}