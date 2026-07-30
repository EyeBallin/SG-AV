//General Display Info
shopVisible = false;
roomWidth = room_width;
roomHeight = room_height;
borderSize = roomWidth * 0.04;
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
invGridMainX = borderSize + (roomWidth * 0.087);
invGridMainY = borderSize + (roomHeight * 0.525);
invGridCellSize = sprite_get_width(spr_ui_invGrid_slot);
invGridColumns = 4;
invGridRows = 4;

//Augment Build Tree Info
augTreeBaseX = borderSize + (roomWidth * 0.63);
augTreeBaseY = borderSize + (roomWidth * 0.05);
augTreeWidth = (augSprSize * 5) + (augGapSizeX * 5);
augTreeHeight = (augSprSize * 7) + (augGapSizeY * 8);
augTreeSpacingY = 50;
augTreeAugsOneDown = 0;
augTreeAugsTwoDown = 0;
augTreeAugsThreeDown = 0;
augTreeMaxAugsInRow = 5;
augTreeCachedBtn = new UIButton(0, 0, 0, 0);
augTreeTopBtn = new UIButtonAugTreeNode(0,0,0,0,{},0);
augTreeScrollLevel = 0;
augTreeScrollTargY = 0;
augTreeScrollStart = 6;
augTreeAnimScrollingDown = false;
augTreeAnimScrollingUp = false;

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
invGridFormBtns = [];
augTreeBtns = [];
augTreeDrawBtns = [];
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
		augInfo.augScrTotalCost.draw(xPos + xOffset + btnWidth/2, yPos + yOffset + btnHeight - 2);
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
var invGridFormABtn = new UIButton(invGridMainX - (invGridCellSize * 1.25), invGridMainY + (invGridCellSize * ((invGridRows-1)/2)), invGridCellSize, invGridCellSize);
var invGridFormBBtn = new UIButton(invGridMainX + (invGridCellSize * ((invGridColumns-1)/2)), invGridMainY - (invGridCellSize * 1.25), invGridCellSize, invGridCellSize);
var invGridFormCBtn = new UIButton(invGridMainX + (invGridCellSize * (invGridColumns+0.25)), invGridMainY + (invGridCellSize * 1.5), invGridCellSize, invGridCellSize);
var invGridFormDBtn = new UIButton(invGridMainX + (invGridCellSize * ((invGridColumns-1)/2)), invGridMainY + (invGridCellSize * (invGridRows+0.25)), invGridCellSize, invGridCellSize);

invGridFormABtn.btnImage = spr_aug_aRED;
invGridFormBBtn.btnImage = spr_aug_aYED;
invGridFormCBtn.btnImage = spr_aug_aGED;
invGridFormDBtn.btnImage = spr_aug_aBED;

invGridFormABtn.navToBtnUp = invGridFormBBtn;
invGridFormABtn.navToBtnDown = invGridFormDBtn;
invGridFormBBtn.navToBtnLeft = invGridFormABtn;
invGridFormBBtn.navToBtnRight = invGridFormCBtn;
invGridFormCBtn.navToBtnUp = invGridFormBBtn;
invGridFormCBtn.navToBtnDown = invGridFormDBtn;
invGridFormDBtn.navToBtnLeft = invGridFormABtn;
invGridFormDBtn.navToBtnRight = invGridFormCBtn;

invGridFormABtn.onBtnCancel = function() { global.ctrlScreenShop.shopMoveCursorOutOfInvGrid(); };
invGridFormBBtn.onBtnCancel = function() { global.ctrlScreenShop.shopMoveCursorOutOfInvGrid(); };
invGridFormCBtn.onBtnCancel = function() { global.ctrlScreenShop.shopMoveCursorOutOfInvGrid(); };
invGridFormDBtn.onBtnCancel = function() { global.ctrlScreenShop.shopMoveCursorOutOfInvGrid(); };

array_push(allBtns, invGridFormABtn, invGridFormBBtn, invGridFormCBtn, invGridFormDBtn);
array_push(invGridFormBtns, invGridFormABtn, invGridFormBBtn, invGridFormCBtn, invGridFormDBtn);

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
	} else {
		gotBtn.navToBtnLeft = invGridFormABtn;
	}
	if (i mod invGridColumns < invGridColumns - 1 && i < array_length(invGridBtns)-1) {
		gotBtn.navToBtnRight = invGridBtns[i+1];
	} else {
		gotBtn.navToBtnRight = invGridFormCBtn;
	}
	if (i div invGridColumns > 0) {
		gotBtn.navToBtnUp = invGridBtns[i-invGridColumns];
	} else {
		gotBtn.navToBtnUp = invGridFormBBtn;
	}
	if (i div invGridColumns < invGridRows - 1) {
		gotBtn.navToBtnDown = invGridBtns[i+invGridColumns];
	} else {
		gotBtn.navToBtnDown = invGridFormDBtn;
	}
};
var halfLeft = ((invGridRows * invGridColumns)/2);
var halfTop = invGridColumns/2;
var halfRight = halfLeft-1;
var halfBottom = (invGridRows * invGridColumns)-1-halfTop;
invGridFormABtn.navToBtnRight = invGridBtns[halfLeft];
invGridFormBBtn.navToBtnDown = invGridBtns[halfTop];
invGridFormCBtn.navToBtnLeft = invGridBtns[halfRight];
invGridFormDBtn.navToBtnUp = invGridBtns[halfBottom];

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
		var augInInvSlot = global.ctrlInven.augEquipGrid[trgBtn.invSlot];
		buildTreeAugID = struct_exists(augInInvSlot, "augID") ? augInInvSlot.augID : -1;
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
		calculateShowOrHideAugBtns(augTreeBtns);
		calculateAugTreeBtnYs(augTreeBtns);
		connectAugTreeBtns(augTreeBtns);
		calculateAugTreeLinePoints(augTreeBtns);
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
		currBtn.navToBtnDown = {};
		currBtn.navToBtnUp = {};
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
calculateShowOrHideAugBtns = function(augTreeBtnArr, nodeIDToChange = 0, nodeCollapse = false) {
	for (var i = 0; i < array_length(augTreeBtnArr); i += 1) {
		var btnToPos = augTreeBtnArr[i];
		if (nodeIDToChange == btnToPos.augNode.nodeUniqueID) {
			for (var j = 0; j < array_length(btnToPos.childBtns); j += 1) {
				//If collapsing, recursively collapse all. If expanding, only reveal the direct children
				if (nodeCollapse) {
					recursiveHideBtns(btnToPos.childBtns[j]);
				} else {
					btnToPos.childBtns[j].btnVisible = true;
				}
			}
			btnToPos.childrenVisible = !nodeCollapse;
		}
	}
}

/// @param {Array<Struct.UIButtonAugTreeNode>} augTreeBtnArr Array of aug tree btns
calculateAugTreeBtnYs = function(augTreeBtnArr) {
	var baseY = augTreeBaseY + augGapSizeY;
	var incrementY = augSprSize + augGapSizeY;
	var incrementCount = 0;
	for (var i = 0; i < array_length(augTreeBtnArr); i += 1) {
		var btnToPos = augTreeBtnArr[i];
		if (btnToPos.btnVisible) {
			btnToPos.yPos = baseY + incrementY * incrementCount;
			btnToPos.yLevel = incrementCount;
			incrementCount += 1;
		} else {
			btnToPos.yPos = 0;
			btnToPos.yLevel = 0;
		}
	}
}

/// @param {Array<Struct.UIButtonAugTreeNode>} augTreeBtnArr Array of aug tree btns
calculateAugTreeLinePoints = function(augTreeBtnArr) {
	for (var i = 0; i < array_length(augTreeBtnArr); i += 1) {
		var gotBtn = augTreeBtnArr[i];
		if (gotBtn.childrenVisible) {
			for (var j = 0; j < array_length(gotBtn.childBtns); j += 1) {
				var childBtn = gotBtn.childBtns[j];
				gotBtn.drawOpenYStops[j] = childBtn.yPos + childBtn.btnHeight / 2;
			}
		} else {
			gotBtn.drawOpenYStops = [];
		}
	}
}

/// @param {Struct.UIButtonAugTreeNode} augNodeBtn Node button to hide
recursiveHideBtns = function(augNodeBtn) {
	augNodeBtn.btnVisible = false;
	augNodeBtn.childrenVisible = false;
	for (var i = 0; i < array_length(augNodeBtn.childBtns); i += 1) {
		recursiveHideBtns(augNodeBtn.childBtns[i]);
	}
}

/// @param {Struct.infoAugmentLine} augInfo
buildAugment = function(augInfo) {
	var foundFreeSpace = -1;
	var freeSlot = {};
	var eqGrid = global.ctrlInven.augEquipGrid;
	for (var i = 0; i < array_length(eqGrid); i += 1) {
		var invSlot = eqGrid[i];
		if (struct_exists(invSlot, "augID") && recursiveCheckIfBuildPathHasAugID(invSlot.augID, augInfo)) {
			foundFreeSpace = i;
			freeSlot = invSlot;
			break;
		}
	}
	if (foundFreeSpace == -1) {
		for (var i = 0; i < array_length(eqGrid); i += 1) {
			var invSlot = eqGrid[i];
			if (!struct_exists(invSlot, "augID")) {
				foundFreeSpace = i;
				freeSlot = invSlot;
				break;
			}
		}
	}
	if (foundFreeSpace >= 0) {
		var augNode = augTreeBtns[0].augNode;
		
		if (struct_exists(freeSlot, "augID")) {
			var childrenOwnedKeys = struct_get_names(augNode.childrenAlreadyOwned);
			for (var i = 0; i < array_length(childrenOwnedKeys); i += 1) {
				for (var j = 0; j < array_length(eqGrid); j += 1) {
					var invSlot = eqGrid[j];
					if (struct_exists(invSlot, "augID") && struct_exists(augNode.childrenAlreadyOwned, string(invSlot.augID))) {
						var childID = string(invSlot.augID);
						var amtLeft = augNode.childrenAlreadyOwned[$ childID];
						if (amtLeft > 0) {
							destroyEquippedAugment(j);
							augNode.childrenAlreadyOwned[$ childID] -= 1;
						}
					}
				}
			}
		}
			
		global.ctrlInven.playerCurrPackets -= augNode.augCost;
		equipAugment(new augmentObj(augInfo), foundFreeSpace);
		buildAndDisplayAugTree(augInfo.augDataID);
	}
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
		augTreeScrollLevel = 0;
	}
};
shopMoveCursorOutOfAugTree = function() {
	if (struct_exists(augTreeCachedBtn, "xPos")) {
		selectButton(augTreeCachedBtn);
		augTreeCachedBtn = {};
	} else {
		selectButton(uiAreaBtns[0]);
	}
}

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
/// @param {Struct.UIButtonAugTreeNode} augBtn 
checkScrollUpAugTree = function(augBtn) {
	if (augBtn.yLevel - augTreeScrollTargY <= 0 && augTreeScrollTargY > 0) {
		augTreeScrollTargY -= 1;
		augTreeAnimScrollingUp = true;
		augTreeAnimScrollingDown = false;
	}
};
/// @param {Struct.UIButtonAugTreeNode} augBtn 
checkScrollDownAugTree = function(augBtn) {
	if (augBtn.yLevel - augTreeScrollTargY >= augTreeScrollStart 
	&& augTreeScrollTargY < array_length(array_filter(augTreeBtns, function(a) { return a.btnVisible; }))) {
		augTreeScrollTargY += 1;
		augTreeAnimScrollingDown = true;
		augTreeAnimScrollingUp = false;
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
treeScrollAnimStepCalc = function() {
	var currDiff = abs(augTreeScrollLevel - augTreeScrollTargY);
	var currDiffMult = currDiff * 0.1;
	return max(currDiffMult, 0.01);
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
		} else if (struct_exists(trgBtn, "augNode")) {
			checkScrollUpAugTree(trgBtn);
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
		} else if (struct_exists(trgBtn, "augNode")) {
			checkScrollDownAugTree(trgBtn);
		}
	}
};
