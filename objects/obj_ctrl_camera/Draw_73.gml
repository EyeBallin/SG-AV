//draw_sprite(spr_vignette, 0, -384, -216);
//draw_set_colour(#110044);
var gradCol = #110044;
var drkCol = #000000;

draw_set_colour(drkCol);
draw_rectangle(global.camX, global.camY, room_width-global.camX, 40, false);
draw_rectangle(global.camX, room_height-30, room_width-global.camX, room_height-global.camY, false);

draw_rectangle(global.camX, global.camY, 40, room_height-global.camY, false);
draw_rectangle(room_width-40, global.camY, room_width-global.camX, room_height-global.camY, false);

//Top Left
draw_rectangle_colour(0, 0, 40, 40, drkCol, drkCol, gradCol, drkCol, false);
//Top Middle
draw_rectangle_colour(40, 0, room_width-40, 40, drkCol, drkCol, gradCol, gradCol, false);
//Top Right
draw_rectangle_colour(room_width-40, 0, room_width, 40, drkCol, drkCol, drkCol, gradCol, false);

//Middle Left
draw_rectangle_colour(0, 40, 40, room_height-30, drkCol, gradCol, gradCol, drkCol, false);
//Middle Right
draw_rectangle_colour(room_width-40, 40, room_width, room_height-30, gradCol, drkCol, drkCol, gradCol, false);

//Bottom Left
draw_rectangle_colour(0, room_height-30, 40, room_height, drkCol, gradCol, drkCol, drkCol, false);
//Bottom Middle
draw_rectangle_colour(40, room_height-30, room_width-40, room_height, gradCol, gradCol, drkCol, drkCol, false);
//Bottom Right
draw_rectangle_colour(room_width-40, room_height-30, room_width, room_height, gradCol, drkCol, drkCol, drkCol, false);