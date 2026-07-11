if (global.ctrlGameState.currGameState == gameStateEnum.stateActiveGame) {
	x += lengthdir_x(moveSpd, moveDir);
	y += lengthdir_y(moveSpd, moveDir);
	if (y > room_height + sprite_width * 1.5) {
		instance_destroy();
	}
}