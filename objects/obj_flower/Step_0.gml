sineStep += sineSpeed;
if (sineStep >= 360)
	sineStep = 0;

for (var i = 0; i < prtCount; i += 1) {
	flowerPrts[i].currRot = sin(degtorad(sineStep)) * 720 * flowerPrts[i].sineMult;
}

if (y > global.camY + global.camH + 200) {
	instance_destroy();
	show_debug_message("Destroyed Flower");
}