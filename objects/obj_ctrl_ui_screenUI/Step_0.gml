if (global.ctrlGameState.currGameState == gameStateEnum.stateActiveGame) {
	var currForm = getCurrForm();

	var cooldownExactQ = currForm.formCooldownQ / 60;
	var cooldownExactW = currForm.formCooldownW / 60;
	var cooldownExactE = currForm.formCooldownE / 60;

	if (cooldownExactQ == 0) {
		if (cooldownStringQ != "Ready!") {
			cooldownStringQ = "Ready!";
			cooldownCurrQ = scribble(string("{0}: {1}", currForm.formInfoAbilityQ.abilName, cooldownStringQ)).starting_format("fnt_lcd_border", c_white);
		}
	} else {
		var cooldownQFloor = string(floor(cooldownExactQ));
		if (cooldownQFloor != cooldownStringQ) {
			cooldownStringQ = cooldownQFloor;
			cooldownCurrQ = scribble(string("{0}: {1}", currForm.formInfoAbilityQ.abilName, cooldownStringQ)).starting_format("fnt_lcd_border", c_white);
		}
	}

	if (cooldownExactW == 0) {
		if (cooldownStringW != "Ready!") {
			cooldownStringW = "Ready!";
			cooldownCurrW = scribble(string("{0}: {1}", currForm.formInfoAbilityW.abilName, cooldownStringW)).starting_format("fnt_lcd_border", c_white);
		}
	} else {
		var cooldownWFloor = string(floor(cooldownExactW));
		if (cooldownWFloor != cooldownStringW) {
			cooldownStringW = cooldownWFloor;
			cooldownCurrW = scribble(string("{0}: {1}", currForm.formInfoAbilityW.abilName, cooldownStringW)).starting_format("fnt_lcd_border", c_white);
		}
	}

	if (cooldownExactE == 0) {
		if (cooldownStringE != "Ready!") {
			cooldownStringE = "Ready!";
			cooldownCurrE = scribble(string("{0}: {1}", currForm.formInfoAbilityE.abilName, cooldownStringE)).starting_format("fnt_lcd_border", c_white);
		}
	} else {
		var cooldownEFloor = string(floor(cooldownExactE));
		if (cooldownEFloor != cooldownStringE) {
			cooldownStringE = cooldownEFloor;
			cooldownCurrE = scribble(string("{0}: {1}", currForm.formInfoAbilityE.abilName, cooldownStringE)).starting_format("fnt_lcd_border", c_white);
		}
	}
}