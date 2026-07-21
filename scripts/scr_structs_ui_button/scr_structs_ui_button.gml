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
	
	drawFunc = function() {
		if (btnImage != -1) {
			draw_sprite_stretched(btnImage, btnSubImg, xPos + xOffset, yPos + yOffset, btnWidth, btnHeight);
		};
		drawCustomFunc();
	}
	
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
	onBtnPress = function() {
		global.ctrlScreenShop.buildAugment(augInfo);
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
			draw_sprite_stretched(gotAug.augSpr, 0, xPos + xOffset, yPos + yOffset, btnWidth, btnHeight);
		}
	};
	onBtnCancel = function() {
		if (global.ctrlInven.augHeldGridSlotNum != -1) {
			equipAugment(global.ctrlInven.augHeld, global.ctrlInven.augHeldGridSlotNum);
		} else {
			global.ctrlScreenShop.shopMoveCursorOutOfInvGrid();
		}
	};
}