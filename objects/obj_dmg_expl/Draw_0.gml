gpu_set_blendmode(bm_add);
draw_sprite_ext(explSpr, 0, x, y, explScaleCurr * explMaxScaleX, explScaleCurr * explMaxScaleY, image_angle, explColCurr, explAlphaCurr);
if (explDmgType == dmgExplTypeEnum.explBoom && explType == dmgExplShapeEnum.explRound && explTimer < 4) {
	repeat(irandom_range(3,5))
		draw_sprite_ext(spr_vis_gen_explFlare, 0, x, y, explScaleCurr * 2 * explMaxScaleX, explScaleCurr * 2 * explMaxScaleY, random(360), explColCurr, 1);
}
gpu_set_blendmode(bm_normal);