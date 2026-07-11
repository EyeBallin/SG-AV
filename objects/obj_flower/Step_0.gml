if (global.ctrlGameState.currGameState == gameStateEnum.stateActiveGame) {
	sineStep += sineSpeed;
	if (sineStep >= 360) {
		sineStep -= 360;
	}
	
	x += lengthdir_x(moveSpd, moveDir);
	y += lengthdir_y(moveSpd, moveDir);

	for (var i = 0; i < prtCount; i += 1) {
		flowerPrts[i].currRot = sin(degtorad(sineStep)) * 720 * flowerPrts[i].sineMult;
	}

	if (y > room_height + 200) {
		instance_destroy();
	}
}