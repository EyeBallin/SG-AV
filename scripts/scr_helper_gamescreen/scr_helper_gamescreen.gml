//Game Size Rescale
/// @func rescaleGame(newWidth, newHeight)
function rescaleGame(newWidth, newHeight) {
	if (newWidth <= 0 || newHeight <= 0)
		return;
		
	var screenXMultBase = newWidth/roomWidth;
	var screenXMult = floor(screenXMultBase);							//X Multiplier for the view. IE how much the game is scaled up
	var screenYMultBase = newHeight/roomHeight;
	var screenYMult = floor(screenYMultBase);							//Y Multiplier for the view. IE how much the game is scaled up
	
	var screenMultDiff = screenXMult/screenYMult;
	var screenMultBase = min(screenXMult, screenYMult);

	var camWidth = roomWidth * (max(screenMultDiff, 1) + frac(screenXMultBase)/screenMultBase);
	var camHeight = roomHeight * (max(1/screenMultDiff, 1) + frac(screenYMultBase)/screenMultBase);

	var camXOffset = (-newWidth/screenMultBase + roomWidth) / 2		//Negative X offset of the camera to keep the game in the middle of the screen
	var camYOffset = (-newHeight/screenMultBase + roomHeight) / 2	//Negative Y offset of the camera to keep the game in the middle of the screen
	
	camera_set_view_pos(global.mainCamera, camXOffset, camYOffset);
	camera_set_view_size(global.mainCamera, camWidth, camHeight);
	view_set_wport(0, newWidth);
	view_set_hport(0, newHeight);
	
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