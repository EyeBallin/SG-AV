//Reduce Cooldowns
if (formSwitchCDCurr > 0)
	formSwitchCDCurr -= 1;
for (var i = 0; i < array_length(formSwitchIndivCDs); i += 1) {
	if (formSwitchIndivCDs[i].formCDCurr > 0)
		formSwitchIndivCDs[i].formCDCurr -= 1;
}

//Move Player if Needed
var mvSpd = getCurrForm().getStatSpdMove().getStatCurr();
//Forced Movement
if (moveForcedDur > 0) {
	moveForcedDur -= 1;
	shipEnt.x += lengthdir_x(moveForcedSpd, moveForcedDir);
	shipEnt.y += lengthdir_y(moveForcedSpd, moveForcedDir);
}
//Manual Movement
else {
	//Digital Movement
	if (moveDigLeft)
		shipEnt.x -= mvSpd;
	if (moveDigUp)
		shipEnt.y -= mvSpd;
	if (moveDigRight)
		shipEnt.x += mvSpd;
	if (moveDigDown)
		shipEnt.y += mvSpd;
		
	//Analogue Movement
	if (moveAnaStr > 0) {
		shipEnt.x += lengthdir_x(mvSpd * moveAnaStr, moveAnaDir);
		shipEnt.y += lengthdir_x(mvSpd * moveAnaStr, moveAnaDir);
	}
}
//Force Screen Bounds
shipEnt.x = clamp(shipEnt.x, 40, room_width-40);
shipEnt.y = clamp(shipEnt.y, 40, room_height-30);

//Firing Standard Shots
attackTimer -= 1;
var extraProj = 0;
while (attackTimer < 1) {
	var currForm = getCurrForm();
	var retVals = currForm.formScrSS(shipEnt, attackTimer, extraProj);
	attackTimer = retVals.retAttTimer;
	extraProj = retVals.retExtraProj;
}