if (global.ctrlGameState.currGameState == gameStateEnum.stateActiveGame) {
	flowerTimer -= 1;
	hexTimer -= 1;
	leafTimer -= 1;

	if (flowerTimer <= 0) {
		flowerTimer = irandom_range(180, 230);
		var newFlower = instance_create_depth(random(room_width), -110, 19, obj_flower);
		newFlower.moveDir = 270;
		newFlower.moveSpd = random_range(1, 2);
	}

	if (hexTimer <= 0) {
		hexTimer = irandom_range(200, 300);
		var hexSize = irandom(1);
		var newHex = instance_create_depth(random(room_width), -200, 19, obj_hex, {
			image_index: hexSize,
			image_alpha: random_range(0.1, 0.3),
			image_angle: irandom(360)
		});
		newHex.moveSpd = random_range(1, 1.5) / hexSize;
		newHex.moveDir = 270;
	}

	if (leafTimer <= 0) {
		leafTimer = irandom_range(20, 40);
		var fallDir = irandom_range(230, 250);
		var spriteDir = irandom_range(210, 300);
		var fallSpd = 4 - abs(angle_difference(fallDir, spriteDir))/80;
		var newLeaf = instance_create_depth(random_range(room_width/5, room_width*1.3), -50, 1, obj_leaf, {
			image_angle: spriteDir,
			image_alpha: random_range(0.5, 0.7)
		});
		newLeaf.moveSpd = fallSpd;
		newLeaf.moveDir = fallDir;
	}
}