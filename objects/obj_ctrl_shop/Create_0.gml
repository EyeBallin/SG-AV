//General Display Info
shopVisible = false;
roomWidth = room_width;
roomHeight = room_height;
borderSize = roomWidth * 0.05;
allAugs = global.ctrlInfo.infoAugments;
filteredAugs = allAugs;

//Aug Builder Info
augSprSize = sprite_get_width(spr_ui_test_aug);
augGapSizeX = augSprSize * 0.2;
augGapSizeY = augSprSize * 0.3;
augPageX = borderSize * 2;
augPageY = borderSize * 2;
augBuilderPageNum = 0;
augBuilderPageNumTarget = 0;
augBuilderAugsPerLine = 5;
augBuilderAugLinesPerPage = 5;
augBuilderMaxPageNum = floor(array_length(allAugs) / (augBuilderAugsPerLine * augBuilderAugLinesPerPage));
augBuilderAnimScrollingDown = false;
augBuilderAnimScrollingUp = false;
augPages = array_length(allAugs) / (augBuilderAugsPerLine * augBuilderAugLinesPerPage);

//Selector Info
selBorderX = 0;
selBorderY = 0;
selBorderW = 0;
selBorderH = 0;
selBorderXTrg = 0;
selBorderYTrg = 0;
selBorderWTrg = 0;
selBorderHTrg = 0;
selBorderXDiff = 0;
selBorderYDiff = 0;
selBorderWDiff = 0;
selBorderHDiff = 0;
selBorderIsMoving = false;
selBorderTriggerMoving = false;
selectedBtn = new UIButton(0, 0, 0, 0);

//Generate Buttons
allBtns = [];
augBuilderCurrBtns = [];
for (var i = 0; i < array_length(allAugs); i += 1) {
	var augGot = allAugs[i];
	var augXSlot = i mod augBuilderAugsPerLine;
	var augYSlot = i div augBuilderAugsPerLine;
	var augX = augPageX + augGapSizeX + (augXSlot * (augSprSize + augGapSizeX));
	var augY = augPageY + augGapSizeY + (augYSlot * (augSprSize + augGapSizeY));
	
	var newBtn = new UIButtonAugmentAbs(augX, augY, augSprSize, augSprSize, augGot);
	newBtn.btnImage = spr_ui_test_aug;
	newBtn.augInfoXInGrid = augXSlot;
	newBtn.augInfoYInGrid = augYSlot;
	newBtn.augInfoYInPage = augYSlot mod augBuilderAugLinesPerPage;
	newBtn.drawCustomFunc = method(newBtn, function() {
		draw_text(xPos + 30 + xOffset, yPos + 30 + yOffset, augInfo.augDataID);
	});
	
	array_push(allBtns, newBtn);
	array_push(augBuilderCurrBtns, newBtn);
	
	if (i == 0) {
		selectedBtn = newBtn;
		selBorderX = newBtn.xPos + newBtn.xOffset;
		selBorderY = newBtn.yPos + newBtn.yOffset;
		selBorderW = newBtn.btnWidth;
		selBorderH = newBtn.btnHeight;
	}
}
for (var i = 0; i < array_length(augBuilderCurrBtns); i += 1) {
	var gotBtn = augBuilderCurrBtns[i];
	var gridX = i mod augBuilderAugsPerLine;
	var gridY = i div augBuilderAugsPerLine;
	var btnArrLen = array_length(augBuilderCurrBtns);
	
	if (gridX != 0 && i != 0) {
		gotBtn.navToBtnLeft = augBuilderCurrBtns[i-1];
	}
	if (gridX != augBuilderAugsPerLine -1 && i != btnArrLen -1) {
		gotBtn.navToBtnRight = augBuilderCurrBtns[i+1];	
	}
	if (i >= augBuilderAugsPerLine) {
		gotBtn.navToBtnUp = augBuilderCurrBtns[i-augBuilderAugsPerLine];
	}
	if (i + augBuilderAugsPerLine < btnArrLen) {
		gotBtn.navToBtnDown = augBuilderCurrBtns[i+augBuilderAugsPerLine];
	} else {
		gotBtn.navToBtnDown = augBuilderCurrBtns[btnArrLen-1];
	}
}

augBuilderScrollPageDown = function(alsoMoveCursor = true) {
	if (augBuilderPageNum < augBuilderMaxPageNum && !augBuilderAnimScrollingDown) {
		augBuilderPageNumTarget += 1;
		augBuilderAnimScrollingDown = true;
		augBuilderAnimScrollingUp = false;
		if (alsoMoveCursor && struct_exists(selectedBtn, "augInfo") && selectedBtn.augInfoYInGrid < array_length(augBuilderCurrBtns) div augBuilderAugLinesPerPage) {
			var currBtnPosInGrid = selectedBtn.augInfoYInGrid * augBuilderAugLinesPerPage + selectedBtn.augInfoXInGrid;
			var trgBtn = augBuilderCurrBtns[min(array_length(augBuilderCurrBtns)-1, currBtnPosInGrid + (augBuilderAugsPerLine * augBuilderAugLinesPerPage))];
			selBorderXTrg = trgBtn.xPos + trgBtn.xOffset;
			selBorderYTrg = trgBtn.yPos + trgBtn.yOffset;
			selBorderWTrg = trgBtn.btnWidth;
			selBorderHTrg = trgBtn.btnHeight;
			selBorderTriggerMoving = true;
			selectedBtn = trgBtn;
		}
	}
};
augBuilderScrollPageUp = function(alsoMoveCursor = true) {
	if (augBuilderPageNum > 0 && !augBuilderAnimScrollingUp) {
		augBuilderPageNumTarget -= 1;
		augBuilderAnimScrollingUp = true;
		augBuilderAnimScrollingDown = false;
		if (alsoMoveCursor && struct_exists(selectedBtn, "augInfo") && selectedBtn.augInfoYInGrid > 0) {
			var currBtnPosInGrid = selectedBtn.augInfoYInGrid * augBuilderAugLinesPerPage + selectedBtn.augInfoXInGrid;
			var trgBtn = augBuilderCurrBtns[max(0, currBtnPosInGrid - (augBuilderAugsPerLine * augBuilderAugLinesPerPage))];
			selBorderXTrg = trgBtn.xPos + trgBtn.xOffset;
			selBorderYTrg = trgBtn.yPos + trgBtn.yOffset;
			selBorderWTrg = trgBtn.btnWidth;
			selBorderHTrg = trgBtn.btnHeight;
			selBorderTriggerMoving = true;
			selectedBtn = trgBtn;
		}
	}
};
scrollAnimStepCalc = function() {
	var currDiff = abs(augBuilderPageNum - augBuilderPageNumTarget);
	var currDiffMult = currDiff * 0.18;
	return max(currDiffMult, 0.015);
};
cursorAnimStepCalc = function(currVal, trgVal) {
	var currDiff = trgVal - currVal;
	var absCurrDiff = abs(currDiff);
	var signCurrDiff = sign(currDiff);
	var currDiffMult = absCurrDiff * 0.24;
	return max(currDiffMult, 3) * signCurrDiff;
}
moveCursorLeft = function() {
	var trgBtn = selectedBtn.navToBtnLeft;
	if (struct_exists(trgBtn, "xPos")) {
		selectedBtn = trgBtn;
		selBorderXTrg = trgBtn.xPos + trgBtn.xOffset;
		selBorderYTrg = trgBtn.yPos + trgBtn.yOffset;
		selBorderWTrg = trgBtn.btnWidth;
		selBorderHTrg = trgBtn.btnHeight;
		selBorderTriggerMoving = true;
	}
};
moveCursorRight = function() {
	var trgBtn = selectedBtn.navToBtnRight;
	if (struct_exists(trgBtn, "xPos")) {
		selectedBtn = trgBtn;
		selBorderXTrg = trgBtn.xPos + trgBtn.xOffset;
		selBorderYTrg = trgBtn.yPos + trgBtn.yOffset;
		selBorderWTrg = trgBtn.btnWidth;
		selBorderHTrg = trgBtn.btnHeight;
		selBorderTriggerMoving = true;
	}
};
moveCursorUp = function() {
	var trgBtn = selectedBtn.navToBtnUp;
	if (struct_exists(trgBtn, "xPos")) {
		var currYInPage = selectedBtn.augInfoYInPage;
		selectedBtn = trgBtn;
		selBorderXTrg = trgBtn.xPos + trgBtn.xOffset;
		selBorderYTrg = trgBtn.yPos + trgBtn.yOffset;
		selBorderWTrg = trgBtn.btnWidth;
		selBorderHTrg = trgBtn.btnHeight;
		selBorderTriggerMoving = true;
		
		if (struct_exists(trgBtn, "augInfo")) {
			if (currYInPage == 0) {
				augBuilderScrollPageUp(false);	
			}
		}
	}
};
moveCursorDown = function() {
	var trgBtn = selectedBtn.navToBtnDown;
	if (struct_exists(trgBtn, "xPos")) {
		selectedBtn = trgBtn;
		selBorderXTrg = trgBtn.xPos + trgBtn.xOffset;
		selBorderYTrg = trgBtn.yPos + trgBtn.yOffset;
		selBorderWTrg = trgBtn.btnWidth;
		selBorderHTrg = trgBtn.btnHeight;
		selBorderTriggerMoving = true;
		
		if (struct_exists(trgBtn, "augInfo")) {
			if (trgBtn.augInfoYInPage == 0) {
				augBuilderScrollPageDown(false);	
			}
		}
	}
};