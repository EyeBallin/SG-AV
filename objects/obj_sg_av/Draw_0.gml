//draw_sprite_ext(spr_chr_sgav_body, 0, x, y, 1, 1, 0, c_white, 1);

//draw_sprite_ext(spr_chr_sgav_coreframe, 0, x, y, 1, 1, 0, c_white, 1);
//draw_sprite_ext(spr_chr_sgav_core, 0, x, y, 1, 1, 0, global.ctrlPlayer.coreCol, 1);

//draw_sprite_ext(spr_chr_sgav_subcore, 0, x + subcoreXDiff, y + subcoreYDiff, 1, 1, subcoreRot, global.ctrlPlayer.fadeCol, 1);
//draw_sprite_ext(spr_chr_sgav_subcore, 0, x - subcoreXDiff, y + subcoreYDiff, 1, 1, subcoreRot*-1, global.ctrlPlayer.fadeCol, 1);

//draw_sprite_ext(spr_chr_sgav_wing, 0, x, y + 3, wingFlapValA*1, 1, 0 + wingRotVal, global.ctrlPlayer.fadeCol, 1);
//draw_sprite_ext(spr_chr_sgav_wing, 0, x, y + 3, wingFlapValA*-1, 1, 0 - wingRotVal, global.ctrlPlayer.fadeCol, 1);
//draw_sprite_ext(spr_chr_sgav_wing, 0, x, y + 3, wingFlapValB*1.2, 1, -30 + wingRotVal, global.ctrlPlayer.fadeCol, 1);
//draw_sprite_ext(spr_chr_sgav_wing, 0, x, y + 3, wingFlapValB*-1.2, 1, 30 - wingRotVal, global.ctrlPlayer.fadeCol, 1);
gpu_set_blendmode(bm_add);
draw_sprite_ext(old_spr_chr_sg_body, 0, x, y, 1, 1, 0, c_white, 1);

draw_sprite_ext(old_spr_chr_sg_coreframe, 0, x, y, 1, 1, 0, c_white, 1);
draw_sprite_ext(old_spr_chr_sg_core, 0, x, y, 1, 1, 0, global.ctrlPlayer.coreCol, 1);

draw_sprite_ext(old_spr_chr_sg_subcore, 0, x + subcoreXDiff, y + subcoreYDiff, 1, 1, subcoreRot, global.ctrlPlayer.midCol, 1);
draw_sprite_ext(old_spr_chr_sg_subcore, 0, x - subcoreXDiff, y + subcoreYDiff, 1, 1, subcoreRot*-1, global.ctrlPlayer.midCol, 1);

draw_sprite_ext(old_spr_chr_sg_wing, 0, x, y + 5, wingFlapValA*1.5, 1.5, 0 + wingRotVal, global.ctrlPlayer.fadeCol, 1);
draw_sprite_ext(old_spr_chr_sg_wing, 0, x, y + 5, wingFlapValA*-1.5, 1.5, 0 - wingRotVal, global.ctrlPlayer.fadeCol, 1);
draw_sprite_ext(old_spr_chr_sg_wing, 0, x, y + 5, wingFlapValB*1.8, 1.5, -30 + wingRotVal, global.ctrlPlayer.fadeCol, 1);
draw_sprite_ext(old_spr_chr_sg_wing, 0, x, y + 5, wingFlapValB*-1.8, 1.5, 30 - wingRotVal, global.ctrlPlayer.fadeCol, 1);
gpu_set_blendmode(bm_normal);
//draw_circle(x, y, 75, true);