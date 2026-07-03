gpu_set_blendmode(bm_add);
draw_sprite_ext(auraSpr, 0, x, y, (25 + auraRadiusNum * auraScale) / (sprite_width/2), (25 + auraRadiusNum * auraScale) / (sprite_height/2), 0, auraCol, auraAlphaCurr);
gpu_set_blendmode(bm_normal);