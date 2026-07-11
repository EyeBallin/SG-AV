if (global.ctrlGameState.currGameState == gameStateEnum.stateActiveGame) {
	var currStatusEffects = getCurrForm().formStatusEffects;
	for (var i = 0; i < array_length(currStatusEffects); i += 1) {
	  currStatusEffects[i].seCodeStep();
	}
	for (var i = 0; i < array_length(formsLoaded); i += 1) {
		var form = formsLoaded[i];
		if (form.formCooldownQ > 0) {
			form.formCooldownQ -= 1;
		}
		if (form.formCooldownW > 0) {
			form.formCooldownW -= 1;
		}
		if (form.formCooldownE > 0) {
			form.formCooldownE -= 1;
		}
	};
}