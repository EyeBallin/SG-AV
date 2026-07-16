if (augBuilderAnimScrollingDown) {
	if (augBuilderPageNum + scrollAnimStepCalc() < augBuilderPageNumTarget) {
		augBuilderPageNum += scrollAnimStepCalc();
	} else {
		augBuilderPageNum = augBuilderPageNumTarget;
		augBuilderAnimScrollingDown = false;
	}
	
	for (var i = 0; i < array_length(augBuilderCurrBtns); i += 1) {
		var gotBtn = augBuilderCurrBtns[i];
		gotBtn.yOffset = -augBuilderPageNum * augBuilderAugLinesPerPage * (augSprSize + augGapSizeY);
	}
	
	if (struct_exists(selectedBtn, "augInfo")) {
		selBorderYTrg = selectedBtn.yPos + selectedBtn.yOffset;
	}
} else if (augBuilderAnimScrollingUp) {
	if (augBuilderPageNum - scrollAnimStepCalc() > augBuilderPageNumTarget) {
		augBuilderPageNum -= scrollAnimStepCalc();
	} else {
		augBuilderPageNum = augBuilderPageNumTarget;
		augBuilderAnimScrollingUp = false;
	}
	
	for (var i = 0; i < array_length(augBuilderCurrBtns); i += 1) {
		var gotBtn = augBuilderCurrBtns[i];
		gotBtn.yOffset = -augBuilderPageNum * augBuilderAugLinesPerPage * (augSprSize + augGapSizeY);
	}
	
	if (struct_exists(selectedBtn, "augInfo")) {
		selBorderYTrg = selectedBtn.yPos + selectedBtn.yOffset;
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
	if (abs(selBorderXTrg - selBorderX) < 5 && abs(selBorderYTrg - selBorderY) < 5 && !augBuilderAnimScrollingDown && !augBuilderAnimScrollingUp) {
		selBorderX = selBorderXTrg;
		selBorderY = selBorderYTrg;
		selBorderW = selBorderWTrg;
		selBorderH = selBorderHTrg;
		selBorderIsMoving = false;
	}
	//Move and resize the border some more
	else {
		selBorderX += cursorAnimStepCalc(selBorderX, selBorderXTrg);
		selBorderY += cursorAnimStepCalc(selBorderY, selBorderYTrg);
		selBorderW += cursorAnimStepCalc(selBorderW, selBorderWTrg);
		selBorderH += cursorAnimStepCalc(selBorderH, selBorderHTrg);
	}
}