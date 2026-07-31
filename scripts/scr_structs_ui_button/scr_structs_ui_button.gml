/// @param {Real} xPosArg X position on screen
/// @param {Real} yPosArg Y position on screen
/// @param {Real} wArg Button Width
/// @param {Real} hArg Button Height
/// @returns {Struct.UIButton}
function UIButton(xPosArg, yPosArg, wArg, hArg) constructor {
	xPos = xPosArg;
	yPos = yPosArg;
	xOffset = 0;
	yOffset = 0;
	btnWidth = wArg;
	btnHeight = hArg;
	
	btnImage = spr_singlePixel;
	btnSubImg = 0;
	btnAnimSpd = 0;
	
	navToBtnLeft = {};
	navToBtnUp = {};
	navToBtnRight = {};
	navToBtnDown = {};
	
	onBtnPress = function(){};
	onBtnCancel = function(){};
	onBtnInfo = function(){};
	
	/// @self UIButton
	drawFunc = function() {
		if (btnImage != -1) {
			draw_sprite_stretched(btnImage, btnSubImg, xPos + xOffset, yPos + yOffset, btnWidth, btnHeight);
		};
		drawCustomFunc();
	}
	
	/// @self UIButtonAugmentAbs
	drawCustomFunc = function(){};
}

/// @param {Real} xPosArg X position on screen
/// @param {Real} yPosArg Y position on screen
/// @param {Real} wArg Button Width
/// @param {Real} hArg Button Height
/// @param {Struct.infoAugmentLine} augInfoArg The augment info struct that this button represents
function UIButtonAugmentAbs(xPosArg, yPosArg, wArg, hArg, augInfoArg) : UIButton(xPosArg, yPosArg, wArg, hArg) constructor {
	augInfo	= augInfoArg;
	augInfoXInGrid = 0;
	augInfoYInGrid = 0;
	augInfoYInPage = 0;
	onBtnCancel = function() {
		global.ctrlScreenShop.shopMoveCursorOutOfAugBuilder();
	};
	/// @self UIButtonAugmentAbs
	onBtnPress = function() {
		global.ctrlScreenShop.buildAugment(augInfo);
	};
	onBtnInfo = function() {
		global.ctrlScreenShop.augTreeCachedBtn = global.ctrlScreenShop.selectedBtn;
		global.ctrlScreenShop.shopMoveCursorIntoAugTree();
	};
}

/// @param {Real} xPosArg X position on screen
/// @param {Real} yPosArg Y position on screen
/// @param {Real} wArg Button Width
/// @param {Real} hArg Button Height
/// @param {Real} invSlotToTrack Which inventory slot this button tracks
function UIButtonEquipGrid(xPosArg, yPosArg, wArg, hArg, invSlotToTrack) : UIButton(xPosArg, yPosArg, wArg, hArg) constructor {
	invSlot = invSlotToTrack;
	btnImage = spr_ui_invGrid_slot;
	faded = false;
	onBtnPress = function() {
		if (struct_exists(global.ctrlInven.augHeld, "augID")) {
			equipAugment(global.ctrlInven.augHeld, invSlot);	
		} else {
			var currSlotAug = global.ctrlInven.augEquipGrid[invSlot];
			if (struct_exists(currSlotAug, "augID")) {
				unequipAugment(invSlot);
			}
		}
	};
	drawCustomFunc = function() {
		var gotAug = global.ctrlInven.augEquipGrid[invSlot];
		if (struct_exists(gotAug, "augID")) {
			draw_sprite_stretched(gotAug.augSpr, 0, xPos + 4, yPos + 4, btnWidth - 8, btnHeight - 8);
		}
		if (faded) {
			draw_set_alpha(0.7);
			draw_rectangle_colour(xPos, yPos, xPos + btnWidth, yPos + btnHeight, $000000, $000000, $000000, $000000, false);
			draw_set_alpha(1);
		}
	};
	onBtnCancel = function() {
		if (global.ctrlInven.augHeldGridSlotNum != -1) {
			equipAugment(global.ctrlInven.augHeld, global.ctrlInven.augHeldGridSlotNum);
		} else {
			global.ctrlScreenShop.shopMoveCursorOutOfInvGrid();
		}
	};
	onBtnInfo = function() {
		global.ctrlScreenShop.augTreeCachedBtn = global.ctrlScreenShop.selectedBtn;
		global.ctrlScreenShop.shopMoveCursorIntoAugTree();
	};
}

/// @param {Real} xPosArg X position on screen
/// @param {Real} yPosArg Y position on screen
/// @param {Real} wArg Button Width
/// @param {Real} hArg Button Height
/// @param {Struct.augBuildTreeNode} augNodeArg The node of the tree that this button represents
/// @param {Real} xOffsetArg Number that determines amount of indentation for this button (and whether it's hidden or shown by default)
function UIButtonAugTreeNode(xPosArg, yPosArg, wArg, hArg, augNodeArg, xOffsetArg) : UIButton(xPosArg, yPosArg, wArg, hArg) constructor {
	if (xPosArg != 0 && yPosArg != 0) {
		augNode = augNodeArg;
		xOffsetLevel = xOffsetArg;
		yTargetRel = 0;
		yLevel = 0;
		btnImage = augNodeArg.augInfo.augDataSpr;
		btnVisible = xOffsetArg <= 1;
		childrenVisible = xOffsetArg == 0;
		parentBtn = new UIButtonAugTreeNode(0,0,0,0,{},0);
		childBtns = array_create(0, new UIButtonAugTreeNode(0,0,0,0,{},0));
		
		drawOpenYStops = array_create(0, 0);
		
		onBtnPress = function() {
			if (array_length(childBtns) > 0) {
				var btnArr = global.ctrlScreenShop.augTreeBtns;
				global.ctrlScreenShop.calculateShowOrHideAugBtns(btnArr, augNode.nodeUniqueID, childrenVisible);
				global.ctrlScreenShop.calculateAugTreeBtnYs(btnArr);
				global.ctrlScreenShop.connectAugTreeBtns(btnArr);
				global.ctrlScreenShop.calculateAugTreeLinePoints(btnArr);
			}
		};
		onBtnCancel = function() {
			global.ctrlScreenShop.shopMoveCursorOutOfAugTree();
		};
		drawCustomFunc = function() {
			augNode.augCostScr.draw(xPos + btnWidth * 1.1, yPos + yOffset);
			if (childrenVisible) {
				draw_set_colour(c_white);
				var recXA = xPos + btnWidth/2 - 2;
				var recXB = xPos + btnWidth/2 + 2;
				for (var i = 0; i < array_length(drawOpenYStops); i += 1) {
					var recYA = (i == 0 ? yPos + btnHeight : drawOpenYStops[i-1]) + yOffset;
					var recYB = drawOpenYStops[i] + yOffset;
					draw_rectangle(recXA, recYA, recXB, recYB, false);
					draw_rectangle(recXA, recYB, recXA + btnWidth * 0.7 + 1, recYB + 4, false);
					draw_rectangle(recXA - 4, recYB - 4, recXB + 5, recYB + 8, false);
				}
			}
		};
	}
};

/// @param {real} xPosArg  X position on screen
/// @param {real} yPosArg  Y position on screen
/// @param {real} wArg  Button Width
/// @param {real} hArg  Button Height
/// @param {struct.shipForm} shipFormArg  The ship form struct that this button tracks
/// @returns {Struct.UIButtonSGForm}
function UIButtonSGForm(xPosArg, yPosArg, wArg, hArg, shipFormArg): UIButton(xPosArg, yPosArg, wArg, hArg) constructor {
	if (xPosArg != -1 && yPosArg != -1) {
		shipFormTracked = shipFormArg;
		formPosNumber = -1;
		for (var i = 0; i < array_length(global.ctrlPlayer.formsLoaded); i += 1) {
			if (global.ctrlPlayer.formsLoaded[i].formID == shipFormArg.formID) {
				formPosNumber = i;
				break;
			}
		}
		
		drawCustomFunc = function() {
			draw_set_colour(#00FFFF);
			
		}
		
		onBtnCancel = function() {
			global.ctrlScreenShop.shopMoveCursorOutOfInvGrid();
		};
	}
}