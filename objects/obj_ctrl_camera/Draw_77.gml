var currWindowWidth = window_get_width();
var currWindowHeight = window_get_height();
var newWindowWidth = currWindowWidth;
var newWindowHeight = currWindowHeight;
var surfaceX = 0;
var surfaceY = 0;
var windowRatio = newWindowWidth / newWindowHeight;
var roomRatio = room_width / room_height;
//Window size is wider/shorter than normal
if (windowRatio >= roomRatio) {
    newWindowWidth = newWindowHeight * roomRatio;
    surfaceX = (currWindowWidth - newWindowWidth)/2;
}
//Window size is taller/thinner than normal
else {
    newWindowHeight = newWindowWidth * (1/roomRatio);
    surfaceY = (currWindowHeight - newWindowHeight)/2;
}
var widthScale = newWindowWidth/room_width;
var heightScale = newWindowHeight/room_height;

shader_set(shdr_screen_crtesque);
shader_set_uniform_f(shuAspectRatio, 1, room_width/room_height);
shader_set_uniform_f(shuWidth, room_width/2);
shader_set_uniform_f(shuHeight, room_height/2);
draw_surface_ext(application_surface, surfaceX, surfaceY, widthScale, heightScale, 0, c_white, 1);
shader_reset();
