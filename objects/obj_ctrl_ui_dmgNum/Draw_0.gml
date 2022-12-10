for (var i = 0; i < instance_number(obj_ui_dmgNum); i += 1) {
	var gotObj = instance_find(obj_ui_dmgNum, i);
	gotObj.drawVal.blend(gotObj.dmgCol, gotObj.drawAlpha).draw(gotObj.x, gotObj.y);
}