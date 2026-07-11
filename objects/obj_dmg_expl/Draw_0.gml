gpu_set_blendmode(bm_add);
switch(explType) {
  case dmgExplShapeEnum.explRect:
    draw_sprite_ext(explSpr, 0, x, y,
      explScaleCurr * explMaxScaleX,
      explScaleCurr * explMaxScaleY,
    explDir, explColCurr, explAlphaCurr);
    break;
  case dmgExplShapeEnum.explRound:
  case dmgExplShapeEnum.explCone:
  default:
    draw_sprite_ext(explSpr, 0, x, y,
      (25 + explRadiusNum * explScaleCurr * explMaxScaleX) / (sprite_width/2),
      (25 + explRadiusNum * explScaleCurr * explMaxScaleY) / (sprite_height/2),
      explDir, explColCurr, explAlphaCurr);
    break;
}

if (explDmgType == dmgExplTypeEnum.explBoom && explType == dmgExplShapeEnum.explRound && explTimer < 12) {
	repeat(irandom_range(3,5)) {
		draw_sprite_ext(spr_vis_gen_explFlare, 0, x, y,
      (25 + explRadiusNum * explMaxScaleX) / (sprite_width/3),
      (25 + explRadiusNum * explMaxScaleY) / (sprite_height/3),
      random(360), explColCurr, 1
		);
  }
}
gpu_set_blendmode(bm_normal);