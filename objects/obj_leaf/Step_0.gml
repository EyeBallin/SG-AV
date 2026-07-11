if (global.ctrlGameState.currGameState == gameStateEnum.stateActiveGame) {
	flipTimer += flipTimerMod;
	if (flipTimer >= 360) {
		flipTimer -= 360;
	}
	image_yscale = sin(degtorad(flipTimer)) * coreScale;
	x += lengthdir_x(moveSpd, moveDir);
	y += lengthdir_y(moveSpd, moveDir);

	if (y > room_height + 100) {
		instance_destroy();
	}
}