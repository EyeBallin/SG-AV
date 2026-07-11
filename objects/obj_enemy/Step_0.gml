if (global.ctrlGameState.currGameState == gameStateEnum.stateActiveGame) {
	if (enemySpriteRotToDir) {
		image_angle = direction;
	}
	enemyScriptStep();
}