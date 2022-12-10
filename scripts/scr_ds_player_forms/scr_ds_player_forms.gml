function infoFormLine(newFormID) constructor {
	formID = newFormID;
	formCol = #808080;
	formName = "Dead Link";
	formDesc = "It's all gone, and they'll never know better.";
	formShot = projIDEnum.ssFire;
	formStats = {
		fsHP: 100,
		fsMana: 100,
		fsHPRegen: 1,
		fsManaRegen: 1,
		fsAttSpd: 1,
		fsMoveSpd: 15,
		fsResColl: 0,
		fsResProj: 0,
		fsResElem: 0,
		fsResType: elementTypes.eNone,
		fsLSAtt: 0,
		fsLSSpell: 0
	};
	
	formSwitchToCode = function() {};
	formSwitchFromCode = function() {};
	formStepCode = function() {};
	formDrawCode = function() {};
	formSSCode = function(shipCtrl, attTimer, extraProj) {};
	formQCode = function() {};
	formWCode = function() {};
	formECode = function() {};
	
	/// @func addFormInfo(formCol, formName, formDesc, formShot, formStats)
	/// @desc Set all relevant form info
	addFormInfo = function(fiCol, fiName, fiDesc, fiShot, fiStats) {
		formCol = fiCol;
		formName = fiName;
		formDesc = fiDesc;
		formShot = fiShot;
		formStats = fiStats;
	}
}

function initFormInfo() {
	global.sgFormData[countSGForms-1] = 0;
	
	for (var i = 0; i < countSGForms; i += 1)
		global.sgFormData[i] = new infoFormLine(i);

	dpFormsPlayer();
}