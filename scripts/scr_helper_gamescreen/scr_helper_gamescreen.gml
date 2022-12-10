//Game Size Rescale
/// @func rescaleGame(newWidth, newHeight)
function rescaleGame(newWidth, newHeight) {
	
	if (newWidth <= 0 || newHeight <= 0)
		return;
		
	var screenXMultBase = 0;
	var screenXMult = 0;		//X Multiplier for the view. IE how much the game is scaled up
	var screenYMultBase = 0;
	var screenYMult = 0;		//Y Multiplier for the view. IE how much the game is scaled up
	
	if (newWidth < room_width || newHeight < room_height) {
		screenXMultBase = 2*newWidth/room_width;
		screenXMult = floor(screenXMultBase)/2;							
		screenYMultBase = 2*newHeight/room_height;
		screenYMult = floor(screenYMultBase)/2;
	}
	else {
		screenXMultBase = newWidth/room_width;
		screenXMult = floor(screenXMultBase);							
		screenYMultBase = newHeight/room_height;
		screenYMult = floor(screenYMultBase);							
	}
	
	var screenMultDiff = screenXMult/screenYMult;
	var screenMultBase = min(screenXMult, screenYMult);

	var camWidth = room_width * (max(screenMultDiff, 1) + frac(screenXMultBase)/screenMultBase);
	var camHeight = room_height * (max(1/screenMultDiff, 1) + frac(screenYMultBase)/screenMultBase);

	var camXOffset = (-newWidth/screenMultBase + room_width) / 2		//Negative X offset of the camera to keep the game in the middle of the screen
	var camYOffset = (-newHeight/screenMultBase + room_height) / 2	//Negative Y offset of the camera to keep the game in the middle of the screen
	
	camera_set_view_pos(global.mainCamera, camXOffset, camYOffset);
	camera_set_view_size(global.mainCamera, camWidth, camHeight);

	//view_set_wport(0, newWidth);
	//view_set_hport(0, newHeight);
	
	global.camX = camXOffset;
	global.camY = camYOffset;
	global.camW = camWidth;
	global.camH = camHeight;

	/*
	if (instance_exists(global.ctrlUIDialogue) && global.ctrlUIDialogue.textboxActive) {
		with (global.ctrlUIDialogue) {
			refreshTextboxCoordsCore();
			textboxResize();
		}
	}
	*/
	
	surface_resize(application_surface, newWidth, newHeight);
	
	show_debug_message("Changed size of window");
}