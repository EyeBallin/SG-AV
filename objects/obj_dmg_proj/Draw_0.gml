gpu_set_blendmode(bm_add);
event_inherited();
draw_sprite_ext(projSpr, 0, x, y, projSizeX, projSizeY, image_angle, projCol, projAlpha);
projCodeDraw(self);
for (var i = 0; i < array_length(projCodeCustomDraw); i += 1) {
	projCodeCustomDraw[i](self);
}
gpu_set_blendmode(bm_normal);