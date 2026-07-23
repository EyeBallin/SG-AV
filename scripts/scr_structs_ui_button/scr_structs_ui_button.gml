/// @param {Real} xPosArg X position on screen
/// @param {Real} yPosArg Y position on screen
/// @param {Real} wArg Button Width
/// @param {Real} hArg Button Height
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
		drawChildren = false;
		xOffsetLevel = xOffsetArg;
		yTargetRel = 0;
		btnImage = augNodeArg.augInfo.augDataSpr;
		btnVisible = xOffsetArg <= 1;
		childrenVisible = xOffsetArg == 0;
		parentBtn = new UIButtonAugTreeNode(0,0,0,0,{},0);
		childBtns = array_create(0, new UIButtonAugTreeNode(0,0,0,0,{},0));
		onBtnPress = function() {
			var btnArr = global.ctrlScreenShop.augTreeBtns;
			global.ctrlScreenShop.calculateAugTreeBtnYs(btnArr, augNode.nodeUniqueID, childrenVisible);
			global.ctrlScreenShop.connectAugTreeBtns(btnArr);
		};
		onBtnCancel = function() {
			global.ctrlScreenShop.shopMoveUpBranchInAugTree(augNode);
		};
	}
};