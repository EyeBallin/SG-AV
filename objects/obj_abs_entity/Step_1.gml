if (global.ctrlGameState.currGameState == gameStateEnum.stateActiveGame) {
	for (var i = 0; i < array_length(entityStatusEffects); i += 1) {
		entityStatusEffects[i].seCodeStep();
	}
}