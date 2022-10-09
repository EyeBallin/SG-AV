/// @func initiateForm(formNum)
/// @desc Initiates a form - used at the start of the game.
function initiateForm(formNum) {
	return new shipForm(global.sgFormData[formNum]);
};

/// @func getCurrForm()
/// @desc Gets the current form.
function getCurrForm() {
	return global.ctrlPlayer.formsLoaded[global.ctrlPlayer.currFormNum];	
}

/// @func changeForm(formNumPressed)
/// @desc Changes the current ship form.
function changeForm(formNumPressed) {
	var currHPPerc = global.ctrlPlayer.shipCurrHP.getStatCurr() / getCurrForm().formHPMax.getStatCurr();
	global.ctrlPlayer.currFormNum = formNumPressed;
	
	global.ctrlPlayer.formSwitchCDCurr = global.ctrlPlayer.formSwitchCDBase;
	global.ctrlPlayer.formSwitchIndivCDs[global.ctrlPlayer.currFormNum].formCDCurr = global.ctrlPlayer.formSwitchIndivCDs[global.ctrlPlayer.currFormNum].formCDBase;
	
	setFormCol(global.ctrlPlayer.currFormNum);
};

/// @func setFormCol(formNum)
/// @desc Sets the core and fade colour to those of the specified form
function setFormCol(formNum) {
	global.ctrlPlayer.coreCol = getCurrForm().formCol;
	global.ctrlPlayer.fadeCol = merge_colour(global.ctrlPlayer.coreCol, #FFFFFF, 0.5);
}