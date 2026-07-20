randomise();

global.ctrlStr = instance_create_depth(0, 0, 0, obj_ctrl_strings);
global.ctrlBC = new listenCtrl(); 
global.ctrlInfo = instance_create_depth(0, 0, 0, obj_ctrl_info);
global.ctrlCam = instance_create_depth(0, 0, -1000, obj_ctrl_camera);
global.ctrlVisGen = instance_create_depth(0, 0, 0, obj_ctrl_visgenJungle);
global.ctrlInput = instance_create_depth(0, 0, 0, obj_ctrl_input);
global.ctrlEnt = instance_create_depth(0, 0, 0, obj_ctrl_entityReg);
global.ctrlPlayer = instance_create_depth(0, 0, 0, obj_ctrl_player);
global.ctrlInven = instance_create_depth(0, 0, 0, obj_ctrl_inventory);
global.ctrlUIDmgNum = instance_create_depth(0, 0, 0, obj_ctrl_ui_dmgNum);
global.ctrlPartSys = instance_create_depth(0, 0, 0, obj_ctrl_particleSys);
global.ctrlUIScreen = instance_create_depth(0, 0, 0, obj_ctrl_ui_screenUI);
global.ctrlGameState = instance_create_depth(0, 0, 0, obj_ctrl_gameState);
global.ctrlScreenShop = instance_create_depth(0, 0, 0, obj_ctrl_shop);

createEnemy(room_width/2, room_height*0.3, enemyIDs.eTest);
createEnemy(room_width/2 + 100, room_height*0.3, enemyIDs.eTest);