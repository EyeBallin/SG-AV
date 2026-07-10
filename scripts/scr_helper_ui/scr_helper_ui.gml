function createDmgPopup(spawnX, spawnY, dmgVal, dmgCol) {
	var popup = instance_create_depth(spawnX, spawnY, -10, obj_ui_dmgNum);
	popup.dmgColTrg = dmgCol;
	popup.drawVal = scribble(string(round(dmgVal))).starting_format("fnt_lcd_border", c_white).align(fa_center, fa_middle);
}

/// Creates a new font with an outline based on a given source font
///
/// @param sourceFontName   Name, as a string, of the font to use as a basis for the effect
/// @param newFontName      Name of the new font to create, as a strintg
/// @param outlineColour    Colour of the outline
/// @param smooth           Whether or not to interpolate the outline. Set to <false> for pixel fonts, set to <true> for anti-aliased fonts
/// @param [textureSize]

function scribble_font_bake_outline_8dir_4px(_source_font_name, _new_font_name, _outline_color, _smooth, _textureSize = undefined) {
  if (is_string(_outline_color)) {
    static _colors_struct = __scribble_config_colours();
    var _found = _colors_struct[$ _outline_color];
    if (_outline_color == undefined) {
      __scribble_error("Colour \"", _outline_color, "\" not recognised");
      exit;
    }
    _outline_color = _found & 0xFFFFFF;
  }

  //Set our shader uniforms before use
  shader_set(__shd_scribble_bake_outline_8dir_2px);
  shader_set_uniform_f(
		shader_get_uniform(
			shader_current(), 
			"u_vOutlineColor"
		),
		color_get_red(_outline_color)/255,
    color_get_green(_outline_color)/255,
    color_get_blue(_outline_color)/255
	);
  shader_reset();

  //Run the baking operation
  scribble_font_bake_shader(_source_font_name, _new_font_name, __shd_scribble_bake_outline_8dir_4px,
    2, 4, 4, 4, 4,
    4, _smooth, _textureSize);
}