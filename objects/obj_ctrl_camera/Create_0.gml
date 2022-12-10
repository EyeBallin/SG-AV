randomise();

screenWidth = window_get_width();
screenHeight = window_get_height();
view_enabled = true;
view_visible[0] = true;
global.mainCamera = camera_create_view(0, 0, view_get_wport(0), view_get_hport(0));
//global.mainCamera = camera_create_view(0, 0, screenWidth, screenHeight);
global.camX = 0;
global.camY = 0;
global.camW = 0;
global.camH = 0;
view_set_camera(0, global.mainCamera);

window_set_size(1920, 1080);
rescaleGame(screenWidth, screenHeight);

