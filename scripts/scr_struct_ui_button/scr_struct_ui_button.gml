function UIButton(xPosArg, yPosArg, wArg, hArg) constructor {
	xPos = xPosArg;
	yPos = yPosArg;
	width = wArg;
	height = hArg;
	
	navToBtnLeft = {};
	navToBtnUp = {};
	navToBtnRight = {};
	navToBtnDown = {};
	
	onBtnPress = function(){};
}