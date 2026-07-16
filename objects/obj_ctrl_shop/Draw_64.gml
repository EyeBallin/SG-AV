if (global.ctrlGameState.currGameState == gameStateEnum.stateShop && shopVisible) {
	var shopSizeW = roomWidth - (borderSize * 2);
	var shopSizeH = roomHeight - (borderSize * 2);

	//Main Screen
	draw_set_colour(c_grey);
	draw_rectangle(borderSize, borderSize, roomWidth - borderSize, roomHeight - borderSize, false);
	draw_set_colour(c_white);
	draw_rectangle(
		borderSize + roomWidth * 0.57, 
		borderSize + roomHeight * 0.05,
		borderSize + roomWidth * 0.571,
		(roomHeight * 0.95) - borderSize,
		false);
	draw_rectangle(
		borderSize + roomWidth * 0.35, 
		borderSize + roomHeight * 0.05,
		borderSize + roomWidth * 0.351,
		(roomHeight * 0.95) - borderSize,
		false);
		
	
	//Inventory Grid
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
		
	//Shop Grid
	
	var windowW = window_get_width();
	var windowH = window_get_height();
	var windowRoomRatioW = windowW / roomWidth;
	var windowRoomRatioH = windowH / roomHeight;
	var augPageW = (((augSprSize + augGapSizeX) * augBuilderAugsPerLine) + augGapSizeX) * windowRoomRatioW;
	var augPageH = (((augSprSize + augGapSizeY) * augBuilderAugLinesPerPage) + augGapSizeY) * windowRoomRatioH;
	var augPageXScaled = augPageX * windowRoomRatioW;
	var augPageYScaled = augPageY * windowRoomRatioH;
	gpu_set_scissor(augPageXScaled, augPageYScaled, augPageW, augPageH);
	draw_set_colour(c_olive);
	draw_rectangle(0, 0, roomWidth, roomHeight, false);
	
	draw_set_colour(c_white);
	for (var i = 0; i < array_length(augBuilderCurrBtns); i += 1) {
		var gotAugBtn = augBuilderCurrBtns[i];
		gotAugBtn.drawFunc();
	}
	
	gpu_set_scissor(0, 0, roomWidth, roomHeight);
	
		
	//Selection Border
	if (struct_exists(selectedBtn, "augInfo")) {
		selBorderScissor = true;
		gpu_set_scissor(augPageXScaled, augPageYScaled, augPageW, augPageH);
	}
	draw_sprite_stretched(spr_ui_bdr_sel, 0, selBorderX-5, selBorderY-5, selBorderW+10, selBorderH+10);
	if (selBorderScissor) {
		gpu_set_scissor(0, 0, roomWidth, roomHeight);
		selBorderScissor = false;
	}
	
	//Selected Augment
	if (struct_exists(selectedBtn, "augInfo")) {
		draw_set_colour(c_white);
		selectedBtn.augInfo.augScrStats.draw(roomWidth/2, roomHeight/2);
	}
}