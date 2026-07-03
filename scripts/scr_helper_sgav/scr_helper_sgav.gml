/// @param {real} formNum SG Form Number (0 - 8ish?)
/// @returns {struct.shipForm} Constructed SG Form Struct
function initiateForm(formNum) {
	var newForm = new shipForm(global.ctrlInfo.infoForms[formNum]);
	newForm.formScrSS = method(newForm, global.ctrlInfo.infoForms[formNum].formSSCode);
	newForm.formScrQ = method(newForm, global.ctrlInfo.infoForms[formNum].formQCode);
	newForm.formScrW = method(newForm, global.ctrlInfo.infoForms[formNum].formWCode);
	newForm.formScrE = method(newForm, global.ctrlInfo.infoForms[formNum].formECode);
	newForm.formScrSwitchTo = method(newForm, global.ctrlInfo.infoForms[formNum].formSwitchToCode);
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
	
	currForm.formScrSwitchTo();
};

/// @func setFormCol()
/// @desc Sets the core and fade colour to those of the specified form
function setFormCol() {
	global.ctrlPlayer.coreCol = getCurrForm().formCol;
	global.ctrlPlayer.fadeCol = merge_colour(global.ctrlPlayer.coreCol, #FFFFFF, 0.5);
	global.ctrlPlayer.midCol = merge_colour(global.ctrlPlayer.coreCol, #FFFFFF, 0.2);
}

/// @func useAbility(shipFormStruct, abilityFunc)
/// @desc Given a form and function, uses an ability.
/// @arg {Struct.shipForm} shipFormStruct The form to source the ability from (typically via `getCurrForm()`)
/// @arg {function} abilityFunc The ability function to call (eg: `formSrcQ()`)
function useAbility(shipFormStruct, abilityFunc) {
    //Broadcast attempt to use ability
    var broadcastArgs = [shipFormStruct, abilityFunc]
    
    shipFormStruct.abilityFunc();
}
