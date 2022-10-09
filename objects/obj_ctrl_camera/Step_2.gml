var currW = window_get_width();
var currH = window_get_height();
if (screenWidth != currW || screenHeight != currH) {
	screenWidth = currW;
	screenHeight = currH;
	rescaleGame(currW, currH);
}