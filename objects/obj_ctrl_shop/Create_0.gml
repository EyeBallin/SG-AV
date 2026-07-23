//General Display Info
shopVisible = false;
roomWidth = room_width;
roomHeight = room_height;
borderSize = roomWidth * 0.05;
shopSizeW = roomWidth - (borderSize * 2);
shopSizeH = roomHeight - (borderSize * 2);
lineDividerXA = borderSize + roomWidth * 0.32;
lineDividerXB = lineDividerXA + 3;
lineDividerYA = borderSize + roomHeight * 0.05;
lineDividerYB = (roomHeight * 0.95) - borderSize;
allAugs = global.ctrlInfo.infoAugments;
filteredAugs = allAugs;
currAugTree = new augBuildTree(-1);
draw_set_font(fnt_normal_bold);

//Aug Builder Info
augSprSize = sprite_get_width(spr_ui_test_aug)/2;
augGapSizeX = augSprSize * 0.2;
augGapSizeY = augSprSize * 0.3;
augPageX = borderSize * 1.5;
augPageY = borderSize * 1.5;
augBuilderPageNum = 0;
augBuilderPageNumTarget = 0;
augBuilderAugsPerLine = 5;
augBuilderAugLinesPerPage = 4;
augBuilderMaxPageNum = floor(array_length(allAugs) / (augBuilderAugsPerLine * augBuilderAugLinesPerPage));
augBuilderAnimScrollingDown = false;
augBuilderAnimScrollingUp = false;
augPages = array_length(allAugs) / (augBuilderAugsPerLine * augBuilderAugLinesPerPage);

//Inventory Grid Info
invGridMainX = borderSize + (roomWidth * 0.072);
invGridMainY = borderSize + (roomHeight * 0.5);
invGridCellSize = sprite_get_width(spr_ui_invGrid_slot);
invGridColumns = 4;
invGridRows = 4;

//Augment Build Tree Info
augTreeBaseX = borderSize + (roomWidth * 0.65);
augTreeBaseY = borderSize + (roomWidth * 0.05);
augTreeSpacingY = 50;
augTreeAugsOneDown = 0;
augTreeAugsTwoDown = 0;
augTreeAugsThreeDown = 0;
augTreeMaxAugsInRow = 5;
augTreeCachedBtn = new UIButton(0, 0, 0, 0);

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
selBorderScissor = false;
selectedBtn = new UIButton(0, 0, 0, 0);

/*
 *Generate Buttons
 */
allBtns = [];
augBuilderCurrBtns = [];
invGridBtns = [];
augTreeBtns = [];
uiAreaBtns = [];

//Area Buttons
var augBuilderGridBtn = new UIButton(augPageX, augPageY, (augSprSize + augGapSizeX) * augBuilderAugsPerLine + augGapSizeX,
	(augSprSize + augGapSizeY) * augBuilderAugLinesPerPage + augGapSizeY);
var invGridBtn = new UIButton(invGridMainX, invGridMainY, invGridCellSize * invGridColumns, invGridCellSize * invGridRows);
augBuilderGridBtn.onBtnPress = function() {
	global.ctrlScreenShop.shopMoveCursorIntoAugBuilder();
}
augBuilderGridBtn.navToBtnDown = invGridBtn;
invGridBtn.onBtnPress = function() {
	global.ctrlScreenShop.shopMoveCursorIntoInvGrid();
}
invGridBtn.navToBtnUp = augBuilderGridBtn;
array_push(allBtns, augBuilderGridBtn, invGridBtn);
array_push(uiAreaBtns, augBuilderGridBtn, invGridBtn);
selectedBtn = augBuilderGridBtn;
selBorderX = augBuilderGridBtn.xPos + augBuilderGridBtn.xOffset;
selBorderY = augBuilderGridBtn.yPos + augBuilderGridBtn.yOffset;
selBorderW = augBuilderGridBtn.btnWidth;
selBorderH = augBuilderGridBtn.btnHeight; 

//Augment Builder
for (var i = 0; i < array_length(allAugs); i += 1) {
	var augGot = allAugs[i];
	var augXSlot = i mod augBuilderAugsPerLine;
	var augYSlot = i div augBuilderAugsPerLine;
	var augX = augPageX + augGapSizeX + (augXSlot * (augSprSize + augGapSizeX));
	var augY = augPageY + augGapSizeY + (augYSlot * (augSprSize + augGapSizeY));
	
	var newBtn = new UIButtonAugmentAbs(augX, augY, augSprSize, augSprSize, augGot);
	newBtn.btnImage = augGot.augDataSpr;
	newBtn.augInfoXInGrid = augXSlot;
	newBtn.augInfoYInGrid = augYSlot;
	newBtn.augInfoYInPage = augYSlot mod augBuilderAugLinesPerPage;
	newBtn.drawCustomFunc = method(newBtn, function() {
		if (augInfo.augDataSpr == spr_ui_test_aug) {
			draw_text(xPos + 25 + xOffset, yPos + 57 + yOffset, augInfo.augDataID);
		}
	});
	
	array_push(allBtns, newBtn);
	array_push(augBuilderCurrBtns, newBtn);
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


//Inventory Grid
for (var i = 0; i < invGridRows * invGridColumns; i += 1) {
	var invGridCellBtn = new UIButtonEquipGrid(
		invGridMainX + (invGridCellSize * (i mod invGridColumns)),
		invGridMainY + (invGridCellSize * (i div invGridColumns)),
		invGridCellSize, invGridCellSize, i
	);
	array_push(allBtns, invGridCellBtn);
	array_push(invGridBtns, invGridCellBtn);
};
for (var i = 0; i < array_length(invGridBtns); i += 1) {
	var gotBtn = invGridBtns[i];
	if (i mod invGridColumns > 0 && i > 0) {
		gotBtn.navToBtnLeft = invGridBtns[i-1];
	}
	if (i mod invGridColumns < invGridColumns - 1 && i < array_length(invGridBtns)-1) {
		gotBtn.navToBtnRight = invGridBtns[i+1];
	}
	if (i div invGridColumns > 0) {
		gotBtn.navToBtnUp = invGridBtns[i-invGridColumns];
	}
	if (i div invGridColumns < invGridRows - 1) {
		gotBtn.navToBtnDown = invGridBtns[i+invGridColumns];
	}
};

/// @param {Struct.UIButton} trgBtn
selectButton = function(trgBtn) {
	selBorderXTrg = trgBtn.xPos + trgBtn.xOffset;
	selBorderYTrg = trgBtn.yPos + trgBtn.yOffset;
	selBorderWTrg = trgBtn.btnWidth;
	selBorderHTrg = trgBtn.btnHeight;
	selBorderTriggerMoving = true;
	selectedBtn = trgBtn;
	
	var buildTreeAugID = -1;
	if (struct_exists(trgBtn, "augInfo")) {
		buildTreeAugID = trgBtn.augInfo.augDataID;
	} else if (struct_exists(trgBtn, "invSlot")) {
		buildTreeAugID = global.ctrlInven.augEquipGrid[trgBtn.invSlot].augID;
	}
	if (global.ctrlInven.augHeldGridSlotNum == -1 && !struct_exists(trgBtn, "augNode")) {
		buildAndDisplayAugTree(buildTreeAugID);
	}
};

buildAndDisplayAugTree = function(augIDArg) {
	currAugTree = new augBuildTree(augIDArg);
	if (augIDArg != -1) {
		array_resize(augTreeBtns, 0);
		recursiveBuildAugTreeBtns(currAugTree.treeOfNodes, augTreeBtns, 0, {});
		calculateAugTreeBtnYs(augTreeBtns);
		connectAugTreeBtns(augTreeBtns);
	}
}

/// @desc Recursively builds the tree of nodes into a flat button map
/// @param {Struct.augBuildTreeNode} augNode Augment node to flatmap
/// @param {Array<Struct.UIButtonAugTreeNode>} flatArr Array to flatmap into
/// @param {Real} offset The level of offset a button is X-wise
/// @param {Struct.UIButtonAugTreeNode} parentBtn Parent button for this node button
recursiveBuildAugTreeBtns = function(augNode, flatArr, offset, parentBtn) {
	var btnX = augTreeBaseX + (augGapSizeX * (offset+1)) + (augSprSize * offset);
	var btnY = augTreeBaseY + augGapSizeY;
	var newBtn = new UIButtonAugTreeNode(btnX, btnY, augSprSize, augSprSize, augNode, offset);
	newBtn.parentBtn = parentBtn;
	if (struct_exists(parentBtn, "augNode")) {
		array_push(newBtn.parentBtn.childBtns, newBtn);
	}
	array_push(flatArr, newBtn);
	for (var i = 0; i < array_length(augNode.childNodes); i += 1) {
		recursiveBuildAugTreeBtns(augNode.childNodes[i], flatArr, offset + 1, newBtn);
	};
};

/// @param {Array<Struct.UIButtonAugTreeNode>} augTreeBtnArr Array of aug tree btns
connectAugTreeBtns = function(augTreeBtnArr) {
	var prevBtn = new UIButtonAugTreeNode(0,0,0,0,{},0);
	for (var i = 0; i < array_length(augTreeBtnArr); i += 1) {
		var currBtn = augTreeBtnArr[i];
		if (i != 0) {
			if (currBtn.btnVisible) {
				currBtn.navToBtnUp = prevBtn;
				prevBtn.navToBtnDown = currBtn;
				prevBtn = currBtn;
			}
		} else {
			prevBtn = currBtn;
		}
	}
}

/// @param {Array<Struct.UIButtonAugTreeNode>} augTreeBtnArr Array of aug tree btns
/// @param {Real} [nodeIDToChange] If present and not exactly 0, this is the node to either collapse or expand while doing this recalc
/// @param {Bool} [nodeCollapse] If present (and nodeIDToChange is also present), this determines if the node should be expanded or collapsed
calculateAugTreeBtnYs = function(augTreeBtnArr, nodeIDToChange = 0, nodeCollapse = false) {
	var baseY = augTreeBaseY + augGapSizeY;
	var incrementY = augSprSize + augGapSizeY;
	var incrementCount = 0;
	var yShift = 0;
	for (var i = 0; i < array_length(augTreeBtnArr); i += 1) {
		var btnToPos = augTreeBtnArr[i];
		if (btnToPos.btnVisible) {
			btnToPos.yOffset = yShift;
		} else {
			btnToPos.yOffset = 0;
		}
		if (nodeIDToChange == btnToPos.augNode.nodeUniqueID) {
			for (var j = 0; j < array_length(btnToPos.childBtns); j += 1) {
				//If collapsing, recursively collapse all. If expanding, only reveal the direct children
				if (nodeCollapse) {
					recursiveHideBtns(btnToPos.childBtns[j]);
				} else {
					btnToPos.childBtns[i].btnVisible = true;
				}
			}
			btnToPos.childrenVisible = !nodeCollapse;
			yShift += incrementY * array_length(btnToPos.childBtns);
			if (nodeCollapse) {
				yShift *= -1;
			}
		}
		
		if (btnToPos.btnVisible) {
			btnToPos.yPos = baseY + incrementY * incrementCount;
			incrementCount += 1;
		} else {
			btnToPos.yPos = 0;
		}
	}
}

/// @param {Struct.UIButtonAugTreeNode} augNodeBtn Node button to hide
recursiveHideBtns = function(augNodeBtn) {
	augNodeBtn.btnVisible = false;
	for (var i = 0; i < array_length(augNodeBtn.childBtns); i += 1) {
		recursiveHideBtns(augNodeBtn.childBtns[i]);
	}
}

/// @param {Struct.infoAugmentLine} augInfo
buildAugment = function(augInfo) {
	
};

shopMoveCursorIntoAugBuilder = function() {
	var trgBtn = augBuilderCurrBtns[augBuilderPageNumTarget * augBuilderAugsPerLine * augBuilderAugLinesPerPage];
	selectButton(trgBtn);
};
shopMoveCursorOutOfAugBuilder = function() {
	selectButton(uiAreaBtns[0]);
};
shopMoveCursorIntoInvGrid = function() {
	selectButton(invGridBtns[0]);
};
shopMoveCursorOutOfInvGrid = function() {
	selectButton(uiAreaBtns[1]);
};
shopMoveCursorIntoAugTree = function() {
	if (array_length(augTreeBtns) > 0) {
		
		selectButton(augTreeBtns[0]);
	}
};

augBuilderScrollPageDown = function(alsoMoveCursor = true) {
	if (augBuilderPageNum < augBuilderMaxPageNum && augBuilderPageNumTarget < augBuilderMaxPageNum) {
		augBuilderPageNumTarget += 1;
		augBuilderAnimScrollingDown = true;
		augBuilderAnimScrollingUp = false;
		if (alsoMoveCursor && struct_exists(selectedBtn, "augInfo") && selectedBtn.augInfoYInGrid < array_length(augBuilderCurrBtns) div augBuilderAugLinesPerPage) {
			var currBtnPosInGrid = selectedBtn.augInfoYInGrid * augBuilderAugsPerLine + selectedBtn.augInfoXInGrid;
			var trgBtn = augBuilderCurrBtns[min(array_length(augBuilderCurrBtns)-1, currBtnPosInGrid + (augBuilderAugsPerLine * augBuilderAugLinesPerPage))];
			selectButton(trgBtn);
		}
	}
};
augBuilderScrollPageUp = function(alsoMoveCursor = true) {
	if (augBuilderPageNum > 0 && augBuilderPageNumTarget > 0) {
		augBuilderPageNumTarget -= 1;
		augBuilderAnimScrollingUp = true;
		augBuilderAnimScrollingDown = false;
		if (alsoMoveCursor && struct_exists(selectedBtn, "augInfo") && selectedBtn.augInfoYInGrid > 0) {
			var currBtnPosInGrid = selectedBtn.augInfoYInGrid * augBuilderAugsPerLine + selectedBtn.augInfoXInGrid;
			var trgBtn = augBuilderCurrBtns[max(0, currBtnPosInGrid - (augBuilderAugsPerLine * augBuilderAugLinesPerPage))];
			selectButton(trgBtn);
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
		selectButton(trgBtn);
	}
};
moveCursorRight = function() {
	var trgBtn = selectedBtn.navToBtnRight;
	if (struct_exists(trgBtn, "xPos")) {
		selectButton(trgBtn);
	}
};
moveCursorUp = function() {
	var trgBtn = selectedBtn.navToBtnUp;
	if (struct_exists(trgBtn, "xPos")) {
		selectButton(trgBtn);
		
		if (struct_exists(trgBtn, "augInfo")) {
			var currYInPage = selectedBtn.augInfoYInPage;
			if (currYInPage == augBuilderAugLinesPerPage-1) {
				augBuilderScrollPageUp(false);	
			}
		}
	}
};
moveCursorDown = function() {
	var trgBtn = selectedBtn.navToBtnDown;
	if (struct_exists(trgBtn, "xPos")) {
		selectButton(trgBtn);
		
		if (struct_exists(trgBtn, "augInfo")) {
			if (trgBtn.augInfoYInPage == 0) {
				augBuilderScrollPageDown(false);	
			}
		}
	}
};
