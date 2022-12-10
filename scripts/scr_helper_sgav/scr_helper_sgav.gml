/// @func initiateForm(formNum)
/// @desc Initiates a form - used at the start of the game.
function initiateForm(formNum) {
	var newForm = new shipForm(global.sgFormData[formNum]);
	newForm.formScrSS = method(newForm, global.sgFormData[formNum].formSSCode);
	newForm.formScrQ = method(newForm, global.sgFormData[formNum].formQCode);
	newForm.formScrW = method(newForm, global.sgFormData[formNum].formWCode);
	newForm.formScrE = method(newForm, global.sgFormData[formNum].formECode);
	return newForm;
};

/// @func getCurrForm()
/// @desc Gets the current form.
function getCurrForm() {
	return global.ctrlPlayer.formsLoaded[global.ctrlPlayer.currFormNum];	
}

/// @func changeForm(formNumPressed)
/// @desc Changes the current ship form.
function changeForm(formNumPressed) {
	var ctrlP = global.ctrlPlayer;
	var currHPPerc = 1;
	if (ctrlP.currFormNum != -1 && ctrlP.currFormNum != formNumPressed && ctrlP.formSwitchCDCurr <= 0 && ctrlP.formSwitchIndivCDs[formNumPressed].formCDCurr <= 0) {
		currHPPerc = ctrlP.shipCurrHP.getStatCurr() / ctrlP.shipCurrHP.eStatResMaxCurr;
	
		ctrlP.formSwitchCDCurr = ctrlP.formSwitchCDBase;
		ctrlP.formSwitchIndivCDs[formNumPressed].formCDCurr = ctrlP.formSwitchIndivCDs[formNumPressed].formCDBase;
	}
	ctrlP.currFormNum = formNumPressed;
	
	var currForm = getCurrForm();
	currForm.getStatHP().eStatCurr = currForm.getStatHP().eStatResMaxCurr * currHPPerc;
	setFormCol();
};

/// @func setFormCol()
/// @desc Sets the core and fade colour to those of the specified form
function setFormCol() {
	global.ctrlPlayer.coreCol = getCurrForm().formCol;
	global.ctrlPlayer.fadeCol = merge_colour(global.ctrlPlayer.coreCol, #FFFFFF, 0.5);
	global.ctrlPlayer.midCol = merge_colour(global.ctrlPlayer.coreCol, #FFFFFF, 0.2);
}
