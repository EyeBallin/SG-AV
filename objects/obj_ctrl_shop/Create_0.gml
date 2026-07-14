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
augPages = array_length(allAugs) / (augBuilderAugsPerLine * augBuilderAugLinesPerPage);
augBuilderPageNum = 0;
augBuilderPageNumTarget = 0;
augBuilderAugsPerLine = 5;
augBuilderAugLinesPerPage = 5;
augBuilderMaxPageNum = floor(array_length(global.ctrlInfo.infoAugments) / (augBuilderAugsPerLine * augBuilderAugLinesPerPage));
augBuilderAnimScrollingDown = false;
augBuilderAnimScrollingUp = false;

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
selectedBtn = {};

//Generate Buttons

augBuilderScrollPageDown = function() {
	if (augBuilderPageNum < augBuilderMaxPageNum && !augBuilderAnimScrollingDown) {
		augBuilderPageNumTarget += 1;
		augBuilderAnimScrollingDown = true;
		augBuilderAnimScrollingUp = false;
	}
};
augBuilderScrollPageUp = function() {
	if (augBuilderPageNum > 0 && !augBuilderAnimScrollingUp) {
		augBuilderPageNumTarget -= 1;
		augBuilderAnimScrollingUp = true;
		augBuilderAnimScrollingDown = false;
	}
};
scrollAnimStepCalc = function() {
	var currDiff = abs(augBuilderPageNum - augBuilderPageNumTarget);
	var currDiffMult = currDiff * 0.18;
	return max(currDiffMult, 0.015);
};
