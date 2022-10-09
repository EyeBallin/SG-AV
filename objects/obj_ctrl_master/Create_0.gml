global.ctrlCam = -999;
global.ctrlVisGen = -999;
global.ctrlInput = -999;
global.ctrlPlayer = -999;

global.ctrlCam = instance_create_depth(0, 0, -1000, obj_ctrl_camera);
global.ctrlVisGen = instance_create_depth(0, 0, 0, obj_ctrl_visgenJungle);
global.ctrlInput = instance_create_depth(0, 0, 0, obj_ctrl_input);
global.ctrlPlayer = instance_create_depth(0, 0, 0, obj_ctrl_player);