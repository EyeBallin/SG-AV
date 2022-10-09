flipTimer += flipTimerMod;
if (flipTimer >= 360)
	flipTimer = 0;
image_yscale = sin(degtorad(flipTimer)) * coreScale;

if (y > global.camH + global.camY + 100)
	instance_destroy();