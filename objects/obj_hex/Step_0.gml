if (y > global.camY + global.camH + sprite_width * 1.5) {
	instance_destroy();
	show_debug_message("Destroyed Hex");
}