if (global.ctrlGameState.currGameState == gameStateEnum.stateShop && shopVisible) {
	//Main Screen
	draw_set_colour(c_grey);
	draw_rectangle(borderSize, borderSize, roomWidth - borderSize, roomHeight - borderSize, false);
	draw_set_colour(c_white);
	draw_rectangle(
		lineDividerXA, 
		lineDividerYA,
		lineDividerXB,
		lineDividerYB,
		false);
		
	
	//Inventory Grid
	for (var i = 0; i < array_length(invGridBtns); i += 1) {
		invGridBtns[i].drawFunc();
	};
		
	//Shop Grid
	var augPageXScaled = 0;
	var augPageYScaled = 0;
	var augPageW = 0;
	var augPageH = 0;
	if (global.ctrlInven.augHeldGridSlotNum == -1) {
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
	
		augPageW = (((augSprSize + augGapSizeX) * augBuilderAugsPerLine) + augGapSizeX) * widthScale;
		augPageH = (((augSprSize + augGapSizeY) * augBuilderAugLinesPerPage) + augGapSizeY) * heightScale;
		augPageXScaled = (augPageX * widthScale) + clipX;
		augPageYScaled = (augPageY * heightScale) + clipY;
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
	}
	
		
	//Selection Border
	if (global.ctrlInven.augHeldGridSlotNum == -1 && struct_exists(selectedBtn, "augInfo")) {
		selBorderScissor = true;
		gpu_set_scissor(augPageXScaled, augPageYScaled, augPageW, augPageH);
	}
	draw_sprite_stretched(spr_ui_bdr_sel, 0, selBorderX-5, selBorderY-5, selBorderW+10, selBorderH+10);
	if (selBorderScissor) {
		gpu_set_scissor(0, 0, roomWidth, roomHeight);
		selBorderScissor = false;
	}
	
	//Selected / Held Augment
	if (global.ctrlInven.augHeldGridSlotNum != -1) {
		global.ctrlInven.augHeld.augScrDetails.draw(borderSize + shopSizeW * 0.38, borderSize + shopSizeH * 0.03);
		var objPosX = borderSize + (shopSizeW * 0.12);
		var objPosY = borderSize + (shopSizeH * 0.3);
		draw_sprite(global.ctrlInven.augHeld.augSpr, 0, objPosX, objPosY);
		draw_sprite_stretched(spr_ui_bdr_augHeld, 0, objPosX-5, objPosY-5, (augSprSize*2)+10, (augSprSize*2)+10);
	} else if (struct_exists(selectedBtn, "augInfo")) {
		selectedBtn.augInfo.augScrDetails.draw(borderSize + shopSizeW * 0.38, borderSize + shopSizeH * 0.03);
	} else if (struct_exists(selectedBtn, "invSlot")) {
		var slotAug = global.ctrlInven.augEquipGrid[selectedBtn.invSlot];
		if (struct_exists(slotAug, "augID")) {
			slotAug.augScrDetails.draw(borderSize + shopSizeW * 0.38, borderSize + shopSizeH * 0.03);
		}
	}
	
	//Current augment build tree
	if (currAugTree.baseAugID != -1) {
		for (var i = 0; i < array_length(currAugTreeFlatmapped); i += 1) {
			var node = currAugTreeFlatmapped[i];
			var drawX = augTreeBaseX + (node.dispX * (augSprSize + augGapSizeX));
			var drawY = augTreeBaseY + (node.dispY * (augSprSize + augGapSizeY));
			draw_sprite_stretched(node.augInfo.augDataSpr, 0, drawX, drawY, augSprSize, augSprSize);
		}
	}
}