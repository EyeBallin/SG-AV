draw_sprite_ext(spr_chr_sgav_body, 0, x, y, 1, 1, 0, c_white, 1);

draw_sprite_ext(spr_chr_sgav_coreframe, 0, x, y, 1, 1, 0, c_white, 1);
draw_sprite_ext(spr_chr_sgav_core, 0, x, y, 1, 1, 0, global.ctrlPlayer.coreCol, 1);

draw_sprite_ext(spr_chr_sgav_subcore, 0, x + subcoreXDiff, y + subcoreYDiff, 1, 1, subcoreRot, global.ctrlPlayer.fadeCol, 1);
draw_sprite_ext(spr_chr_sgav_subcore, 0, x - subcoreXDiff, y + subcoreYDiff, 1, 1, subcoreRot*-1, global.ctrlPlayer.fadeCol, 1);

draw_sprite_ext(spr_chr_sgav_wing, 0, x, y + 3, wingFlapValA*1, 1, 0 + wingRotVal, global.ctrlPlayer.fadeCol, 1);
draw_sprite_ext(spr_chr_sgav_wing, 0, x, y + 3, wingFlapValA*-1, 1, 0 - wingRotVal, global.ctrlPlayer.fadeCol, 1);
draw_sprite_ext(spr_chr_sgav_wing, 0, x, y + 3, wingFlapValB*1.2, 1, -30 + wingRotVal, global.ctrlPlayer.fadeCol, 1);
draw_sprite_ext(spr_chr_sgav_wing, 0, x, y + 3, wingFlapValB*-1.2, 1, 30 - wingRotVal, global.ctrlPlayer.fadeCol, 1);