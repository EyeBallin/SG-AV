/// @param {Real} xPosArg
/// @param {Real} yPosArg
/// @param {Real} wArg
/// @param {Real} hArg
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
	
	drawFunc = function() {
		draw_sprite_stretched(btnImage, btnSubImg, xPos + xOffset, yPos + yOffset, btnWidth, btnHeight);
		drawCustomFunc();
	}
	
	drawCustomFunc = function(){};
}

/// @param {Real} xPosArg
/// @param {Real} yPosArg
/// @param {Real} wArg
/// @param {Real} hArg
/// @param {Struct.infoAugmentLine} augInfoArg
function UIButtonAugmentAbs(xPosArg, yPosArg, wArg, hArg, augInfoArg) : UIButton(xPosArg, yPosArg, wArg, hArg) constructor {
	augInfo	= augInfoArg;
	augInfoXInGrid = 0;
	augInfoYInGrid = 0;
	augInfoYInPage = 0;
}

/// @param {Real} xPosArg
/// @param {Real} yPosArg
/// @param {Real} wArg
/// @param {Real} hArg
/// @param {Struct.augmentObj} augStructArg
function UIButtonEquipGrid(xPosArg, yPosArg, wArg, hArg, augStructArg): UIButton(xPosArg, yPosArg, wArg, hArg) constructor {
	augStruct = augStructArg;
}