global.ctrlBC = -999;
global.ctrlInfo = -999;
global.ctrlCam = -999;
global.ctrlVisGen = -999;
global.ctrlInput = -999;
global.ctrlPlayer = -999;
global.ctrlEnt = -999;
global.ctrlUIDmgNum = -999;
global.ctrlInven = -999;

global.ctrlBC = new listenCtrl(); 
global.ctrlInfo = instance_create_depth(0, 0, 0, obj_ctrl_info);
global.ctrlCam = instance_create_depth(0, 0, -1000, obj_ctrl_camera);
global.ctrlVisGen = instance_create_depth(0, 0, 0, obj_ctrl_visgenJungle);
global.ctrlInput = instance_create_depth(0, 0, 0, obj_ctrl_input);
global.ctrlEnt = instance_create_depth(0, 0, 0, obj_ctrl_entityReg);
global.ctrlPlayer = instance_create_depth(0, 0, 0, obj_ctrl_player);
global.ctrlInven = instance_create_depth(0, 0, 0, obj_ctrl_inventory);
global.ctrlUIDmgNum = instance_create_depth(0, 0, 0, obj_ctrl_ui_dmgNum);

createEnemy(room_width/2, room_height*0.3, enemyIDs.eTest);

//for (var i = 0; i < 16; i += 1)
	equipAugment(createAugObj(augIDs.aFarawayScope), 3);
	
