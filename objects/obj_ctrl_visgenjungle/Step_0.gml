flowerTimer -= 1;
hexTimer -= 1;
leafTimer -= 1;

if (flowerTimer <= 0) {
	flowerTimer = irandom_range(180, 230);
	var newFlower = instance_create_depth(global.camX + random(global.camW), global.camY - 200, 10, obj_flower);
	newFlower.direction = 270;
	newFlower.speed = random_range(0.5, 1);
	show_debug_message("Made flower");
}

if (hexTimer <= 0) {
	hexTimer = irandom_range(200, 300);
	var hexSize = irandom(1);
	instance_create_depth(global.camX + random(global.camW), global.camY - 300, 10, obj_hex, {
		image_index: hexSize,
		direction: 270,
		image_alpha: random_range(0.1, 0.3),
		speed: random_range(0.5, 0.75) / hexSize,
		image_angle: irandom(360)
	});
	show_debug_message("Made Hex");
}

if (leafTimer <= 0) {
	leafTimer = irandom_range(20, 40);
	var fallDir = irandom_range(230, 250);
	var spriteDir = irandom_range(210, 300);
	var fallSpd = 2 - abs(angle_difference(fallDir, spriteDir))/80;
	instance_create_depth(global.camX + random_range(global.camW/5, global.camW*1.3), global.camY - 100, -50, obj_leaf, {
		direction: fallDir,
		image_angle: spriteDir,
		speed: fallSpd,
		image_alpha: random_range(0.5, 0.7)
	});
}