if (augBuilderAnimScrollingDown) {
	if (augBuilderPageNum < augBuilderPageNumTarget) {
		augBuilderPageNum += scrollAnimStepCalc();
	} else {
		augBuilderPageNum = augBuilderPageNumTarget;
		augBuilderAnimScrollingDown = false;
	}
} else if (augBuilderAnimScrollingUp) {
	if (augBuilderPageNum > augBuilderPageNumTarget) {
		augBuilderPageNum -= scrollAnimStepCalc();
	} else {
		augBuilderPageNum = augBuilderPageNumTarget;
		augBuilderAnimScrollingUp = false;
	}
}

if (selBorderTriggerMoving) {
	selBorderXDiff = selBorderXTrg - selBorderX;
	selBorderYDiff = selBorderYTrg - selBorderY;
	selBorderWDiff = selBorderWTrg - selBorderW;
	selBorderHDiff = selBorderHTrg - selBorderH;
	selBorderTriggerMoving = false;
	selBorderIsMoving = true;
}

if (selBorderIsMoving) {
	//Close enough, set all values to be their targets
	if (abs(selBorderXTrg - selBorderX) < 1) {
		selBorderX = selBorderXTrg;
		selBorderY = selBorderYTrg;
		selBorderW = selBorderWTrg;
		selBorderH = selBorderHTrg;
		selBorderIsMoving = false;
	}
	//Move and resize the border some more
	else {
		selBorderX += selBorderXDiff * 0.1;
		selBorderY += selBorderYDiff * 0.1;
		selBorderW += selBorderWDiff * 0.1;
		selBorderH += selBorderHDiff * 0.1;
	}
}