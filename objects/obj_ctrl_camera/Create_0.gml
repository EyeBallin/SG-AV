camera = view_camera[0];
application_surface_draw_enable(false);
shuAspectRatio = shader_get_uniform(shdr_screen_crtesque, "aspectRatio");
shuWidth = shader_get_uniform(shdr_screen_crtesque, "screenWidth");
shuHeight = shader_get_uniform(shdr_screen_crtesque, "screenHeight");