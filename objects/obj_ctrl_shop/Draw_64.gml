if (global.ctrlGameState.currGameState == gameStateEnum.stateShop && shopVisible) {
	var currRoomWidth = room_width;
	var currRoomHeight = room_height;

	var borderSize = currRoomWidth * 0.05;
	
	var shopSizeW = currRoomWidth - (borderSize * 2);
	var shopSizeH = currRoomHeight - (borderSize * 2);

	//Main Screen
	{
	draw_set_colour(c_grey);
	draw_rectangle(borderSize, borderSize, currRoomWidth - borderSize, currRoomHeight - borderSize, false);
	draw_set_colour(c_white);
	draw_rectangle(
		borderSize + currRoomWidth * 0.57, 
		borderSize + currRoomHeight * 0.05,
		borderSize + currRoomWidth * 0.571,
		(currRoomHeight * 0.95) - borderSize,
		false);
	}
		
	
	//Inventory Grid
	{
	var invGridStartX = borderSize + (shopSizeW * 0.705);
	var invGridStartY = borderSize + (shopSizeH * 0.43);
	var invGridCellSize = 136;
	draw_set_colour(#FFFFFF);
	draw_rectangle(
		invGridStartX - 4,
		invGridStartY - 4,
		invGridStartX + (invGridCellSize * 4) + 4,
		invGridStartY + (invGridCellSize * 4) + 4,
		false
	);
	draw_set_colour(#333333);
	for (var i = 0; i < 4; i += 1) {
		for (var j = 0; j < 4; j += 1) {
			draw_rectangle(
				invGridStartX + (i * invGridCellSize) + 4, 
				invGridStartY + (j * invGridCellSize) + 4,
				invGridStartX + ((i+1) * invGridCellSize) - 4,
				invGridStartY + ((j+1) * invGridCellSize) - 4,
				false
			);
		}
	}
	}
		
	//Shop Grid
	{
	var windowW = window_get_width();
	var windowH = window_get_height();
	var windowRoomRatioW = windowW / currRoomWidth;
	var windowRoomRatioH = windowH / currRoomHeight;
	var augPageW = (((augSprSize + augGapSizeX) * augBuilderAugsPerLine) + augGapSizeX) * windowRoomRatioW;
	var augPageH = (((augSprSize + augGapSizeY) * augBuilderAugLinesPerPage) + augGapSizeY) * windowRoomRatioH;
	var augPageX = borderSize * 2;
	var augPageY = borderSize * 2;
	var augPageXScaled = augPageX * windowRoomRatioW;
	var augPageYScaled = augPageY * windowRoomRatioH;
	/*Shop Grid will be done via gpu_set_scissor*/
	gpu_set_scissor(augPageXScaled, augPageYScaled, augPageW, augPageH);
	draw_set_colour(c_olive);
	draw_rectangle(0, 0, currRoomWidth, currRoomHeight, false);
	
	draw_set_colour(c_white);
	for (var i = 0; i < array_length(allAugs); i += 1) {
		var augXSlot = i mod augBuilderAugsPerLine;
		var augYSlot = i div augBuilderAugsPerLine;
		var augX = augPageX + augGapSizeX + (augXSlot * (augSprSize + augGapSizeX));
		var augY = augPageY + augGapSizeY + ((augYSlot - (augBuilderPageNum * augBuilderAugLinesPerPage)) * (augSprSize + augGapSizeY));
		draw_sprite(spr_ui_test_aug, 0, augX, augY);
		draw_text(augX + 30, augY + 30, string(i));
	}
	
	gpu_set_scissor(0, 0, currRoomWidth, currRoomHeight);
	}
		
	//Selection Border
	{
	//draw_sprite_stretched(spr_ui_bdr_sel, 0, selBorderX-5, selBorderY-5, selBorderW+10, selBorderH+10);
	}
}