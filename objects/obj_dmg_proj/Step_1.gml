if (global.ctrlGameState.currGameState == gameStateEnum.stateActiveGame) {
	xPrev = x;
	yPrev = y;
	dirPrev = projDir;
	if (setDeletion) {
		instance_destroy();
	}
}