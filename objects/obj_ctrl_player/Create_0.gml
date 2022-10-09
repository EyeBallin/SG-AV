global.ctrlPlayer = self;

//Form Information
global.sgFormData = array_create(formCount, {
	formID: sgForm.formCode,
	formCol: #808080,
	formName: "Dead Link",
	formDesc: "It's all gone, and they'll never know better.",
	formStats: {
		fsHP: 100,
		fsMana: 100,
		fsAttSpd: 1,
		fsResColl: 0,
		fsResProj: 0,
		fsResElem: 0,
		fsResType: elementTypes.eNone
	}
});

//Fire
global.sgFormData[0] = { formID: sgForm.formFire, formCol: #FF0000, formName: "Fire Form", formDesc: "Specialises in spreading damage and chaos with both standard shots and abilities.",
	formStats: { fsHP: 100, fsMana: 110, fsAttSpd: 9, fsResColl: 0.03, fsResProj: 0.02, fsResElem: 0, fsResType: elementTypes.eFire } };
//Electric
global.sgFormData[1] = { formID: sgForm.formElec, formCol: #FFFF00, formName: "Electric Form", formDesc: "Specialises in heavy damage and lockdown on single targets, and low but constant spread damage.",
	formStats: { fsHP: 100, fsMana: 110, fsAttSpd: 7, fsResColl: 0.02, fsResProj: 0.03, fsResElem: 0, fsResType: elementTypes.eElec } };
//Poison
global.sgFormData[2] = { formID: sgForm.formPsn, formCol: #00FF00, formName: "Poison Form", formDesc: "Specialises in very strong damage over time with mild crippling effects.",
	formStats: { fsHP: 90, fsMana: 105, fsAttSpd: 5, fsResColl: 0.025, fsResProj: 0.025, fsResElem: 0, fsResType: elementTypes.ePsn } };
//Ice
global.sgFormData[3] = { formID: sgForm.formIce, formCol: #00FFFF, formName: "Ice Form", formDesc: "Specialises in defensive lockdown and area denial.",
	formStats: { fsHP: 120, fsMana: 100, fsAttSpd: 6, fsResColl: 0.025, fsResProj: 0.025, fsResElem: 0, fsResType: elementTypes.eIce } };
//Light
global.sgFormData[4] = { formID: sgForm.formLight, formCol: #FFFFFF, formName: "Light Form", formDesc: "Specialises in high persistent damage through many projectiles.",
	formStats: { fsHP: 85, fsMana: 115, fsAttSpd: 10, fsResColl: 0.01, fsResProj: 0.04, fsResElem: 0, fsResType: elementTypes.eLight } };
//Dark
global.sgFormData[5] = { formID: sgForm.formDark, formCol: #000000, formName: "Dark Form", formDesc: "Specialises in close-range heavy hits while healing damage taken.",
	formStats: { fsHP: 110, fsMana: 100, fsAttSpd: 4, fsResColl: 0.04, fsResProj: 0.01, fsResElem: 0, fsResType: elementTypes.eDark } };
//Siege
global.sgFormData[6] = { formID: sgForm.formSiege, formCol: #FF00FF, formName: "Siege Form", formDesc: "Specialises in very high but very inaccurate Physical damage.",
	formStats: { fsHP: 105, fsMana: 100, fsAttSpd: 12, fsResColl: 0, fsResProj: 0.05, fsResElem: 0, fsResType: elementTypes.eNone } };
//Power
global.sgFormData[7] = { formID: sgForm.formPower, formCol: #0000FF, formName: "Power Form", formDesc: "Specialises in very high but unconvential Energy damage.",
	formStats: { fsHP: 90, fsMana: 120, fsAttSpd: 1, fsResColl: 0.05, fsResProj: 0, fsResElem: 0, fsResType: elementTypes.eNone } };
	
//Shared Stats
shipCurrHP = new entityStat(sgID, statTypesShip.statHP, "Current HP", "The current amount of HP the player has.", 100, 0, 999999999);
shipCurrShield = new entityStat(sgID, statTypesShip.statShield, "Current Shield", "The current amount of Shield the player has.", 0, 0, 999999999);

moveSpdCurr = 8;
moveSpdBase = 8;
moveSpdInit = 8;

formSwitchCDCurr = 0;
formSwitchCDBase = 120;
formSwitchCDInit = 120;

currFormNum = 0;
statusEffectsCurr = array_create(countStatusTotal-1, -1);

coreCol = #FFFFFF;
fadeCol = #FFFFFF;

formsLoaded = [
	initiateForm(0),
	initiateForm(1),
	initiateForm(2),
	initiateForm(3)
];

formSwitchIndivCDs = [
	{ formCDCurr: 0, formCDBase: 300, formCDInit: 300 },
	{ formCDCurr: 0, formCDBase: 300, formCDInit: 300 },
	{ formCDCurr: 0, formCDBase: 300, formCDInit: 300 },
	{ formCDCurr: 0, formCDBase: 300, formCDInit: 300 }
];

changeForm(0);

instance_create_depth(room_width/2, room_height/2, 0, obj_sg_av);