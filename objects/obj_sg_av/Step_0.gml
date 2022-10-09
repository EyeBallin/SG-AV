if (wingChange) {
	wingFlapValA = (wingFlapValA == 1 ? 0.8 : 1);
	wingFlapValB = (wingFlapValB == 1 ? 0.8 : 1);
	wingRotVal = (wingRotVal == 0 ? 15 : 0);
	wingChange = false;
}
else
	wingChange = true;
subcoreRot += 2;
if (subcoreRot >= 360)
	subcoreRot -= 360;