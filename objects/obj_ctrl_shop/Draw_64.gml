if (global.ctrlGameState.currGameState == gameStateEnum.stateShop && shopVisible) {
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
		borderSize + roomWidth * 0.25, 
		borderSize + roomHeight * 0.05,
		borderSize + roomWidth * 0.251,
		(roomHeight * 0.95) - borderSize,
		false);
		
	
	//Inventory Grid
	var invGridStartX = borderSize + (shopSizeW * 0.705);
	var invGridStartY = borderSize + (shopSizeH * 0.43);
	var invGridCellSize = augSprSize + 8;
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
	var currWindowWidth = window_get_width();
	var currWindowHeight = window_get_height();
	var newWindowWidth = currWindowWidth;
	var newWindowHeight = currWindowHeight;
	var clipX = 0;
	var clipY = 0;
	var windowRatio = newWindowWidth / newWindowHeight;
	var roomRatio = room_width / room_height;
	//Window size is wider/shorter than normal
	if (windowRatio >= roomRatio) {
	  newWindowWidth = newWindowHeight * roomRatio;
	  clipX = (currWindowWidth - newWindowWidth)/2;
	}
	//Window size is taller/thinner than normal
	else {
	  newWindowHeight = newWindowWidth * (1/roomRatio);
	  clipY = (currWindowHeight - newWindowHeight)/2;
	}
	var widthScale = newWindowWidth/room_width;
	var heightScale = newWindowHeight/room_height;
	
	var augPageW = (((augSprSize + augGapSizeX) * augBuilderAugsPerLine) + augGapSizeX) * widthScale;
	var augPageH = (((augSprSize + augGapSizeY) * augBuilderAugLinesPerPage) + augGapSizeY) * heightScale;
	var augPageXScaled = (augPageX * widthScale) + clipX;
	var augPageYScaled = (augPageY * heightScale) + clipY;
	gpu_set_scissor(augPageXScaled, augPageYScaled, augPageW, augPageH);
	draw_set_colour(c_olive);
	draw_rectangle(0, 0, roomWidth, roomHeight, false);
	
	draw_set_colour(c_white);
	var baseDrawLine = augBuilderPageNum * augBuilderAugsPerLine * augBuilderAugLinesPerPage;
	var minDrawNum = baseDrawLine - augBuilderAugsPerLine;
	var maxDrawNum = baseDrawLine + (augBuilderAugsPerLine * augBuilderAugLinesPerPage) + augBuilderAugsPerLine;
	for (var i = 0; i < array_length(augBuilderCurrBtns); i += 1) {
		if (i >= minDrawNum && i <= maxDrawNum) {
			var gotAugBtn = augBuilderCurrBtns[i];
			gotAugBtn.drawFunc();
		}
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
		selectedBtn.augInfo.augScrDetails.draw(borderSize + shopSizeW * 0.305, borderSize + shopSizeH * 0.05);
	}
}