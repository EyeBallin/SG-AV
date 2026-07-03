drawAlpha -= 0.03;
dmgCol = merge_colour(c_white, dmgColTrg, 1-drawAlpha);
y -= yRand;
x += xRand;
if (drawAlpha <= 0)
	instance_destroy();