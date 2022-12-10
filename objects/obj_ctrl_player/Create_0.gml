global.ctrlPlayer = self;
	
//Shared Stats
shipCurrHP = new entityStat(sgID, statTypesShip.statHP, "HP", "The amount of HP the player has.", 100, 0, 999999999);
shipCurrShield = new entityStat(sgID, statTypesShip.statShield, "Shield", "The amount of Shield the player has.", 0, 0, 999999999);
shipCurrHP.eStatIsRes = true;
shipCurrShield.eStatIsRes = true;

moveDigLeft = false;
moveDigUp = false;
moveDigRight = false;
moveDigDown = false;
moveAnaStr = 0;
moveAnaDir = 0;
moveForcedDur = 0;
moveForcedSpd = 0;
moveForcedDir = 0;

formSwitchCDCurr = 0;
formSwitchCDBase = 120;
formSwitchCDInit = 120;

attackTimer = 0;

currFormNum = -1;
statusEffectsCurr = array_create(countStatusTotal-1, -1);

coreCol = #FFFFFF;
fadeCol = #FFFFFF;
midCol = #FFFFFF;

formsLoaded = [
	initiateForm(0),
	initiateForm(5),
	initiateForm(6),
	initiateForm(7)
];

formSwitchIndivCDs = [
	{ formCDCurr: 0, formCDBase: 300, formCDInit: 300 },
	{ formCDCurr: 0, formCDBase: 300, formCDInit: 300 },
	{ formCDCurr: 0, formCDBase: 300, formCDInit: 300 },
	{ formCDCurr: 0, formCDBase: 300, formCDInit: 300 }
];

changeForm(0);

shipEnt = createPlayerEntity();

