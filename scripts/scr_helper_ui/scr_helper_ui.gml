function createDmgPopup(spawnX, spawnY, dmgVal, dmgCol) {
	var popup = instance_create_depth(spawnX, spawnY, -100, obj_ui_dmgNum);
	popup.dmgColTrg = dmgCol;
	popup.drawVal = scribble(string(round(dmgVal))).starting_format("fnt_lcd_border", c_white).align(fa_center, fa_middle);
}