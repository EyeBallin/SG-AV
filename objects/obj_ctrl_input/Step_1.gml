var currCtrler = ctrlInputs[currCtrl];
var currCtrlerBtns = currCtrler.contButtons;

for (var i = 0; i < array_length(currCtrlerBtns); i += 1) {
	var gotBtn = currCtrlerBtns[i];
	
	//Skip null inputs (unbound buttons)
	if (gotBtn.btnName == "Null Input")
		continue;
	
	var currState = inputStateOff;
	
	//Check the input
	if (currCtrler.checkBtnPressed(i))
		currState = inputStatePressed;
	else if (currCtrler.checkBtnReleased(i))
		currState = inputStateReleased;
	else if (currCtrler.checkBtnHeld(i))
		currState = inputStateHeld;
		
	//Perform one final update of the input's last frame var if it's determined to be off
	if (currState == inputStateOff) {
		if (gotBtn.valLastFrame != 0)
			currCtrler.updateBtnCurrVal(i);
		continue;
	}
	
	//Early Check For Screen-Related Buttons
	if (currCtrl == inputTypeKeyboard && currState == inputStatePressed) {
		//Full Screen Switch
		if (i == inputVals.btnDPadLeft) {
			window_set_fullscreen(!window_get_fullscreen());
			continue;
		}
		else if (i == inputVals.btnStart)
			game_end();
	}
	
	switch(i) {
		case inputVals.stickLLeft:
			//Move left
			if (currState == inputStatePressed)
				global.ctrlPlayer.moveDigLeft = true;
			else if (currState == inputStateReleased)
				global.ctrlPlayer.moveDigLeft = false;
			break;
		case inputVals.stickLRight:
			//Move right
			if (currState == inputStatePressed)
				global.ctrlPlayer.moveDigRight = true;
			else if (currState == inputStateReleased)
				global.ctrlPlayer.moveDigRight = false;
			break;
		case inputVals.stickLUp:
			//Move up
			if (currState == inputStatePressed)
				global.ctrlPlayer.moveDigUp = true;
			else if (currState == inputStateReleased)
				global.ctrlPlayer.moveDigUp = false;
			break;
		case inputVals.stickLDown:
			//Move down
			if (currState == inputStatePressed)
				global.ctrlPlayer.moveDigDown = true;
			else if (currState == inputStateReleased)
				global.ctrlPlayer.moveDigDown = false;
			break;
		case inputVals.stickRLeft:
			//Swap to the 1st form
			if (currState == inputStatePressed)
				changeForm(0);
			break;
		case inputVals.stickRUp:
			//Swap to the 2nd form
			if (currState == inputStatePressed)
				changeForm(1);
			break;
		case inputVals.stickRRight:
			//Swap to the 3rd form
			if (currState == inputStatePressed)
				changeForm(2);
			break;
		case inputVals.stickRDown:
			//Swap to the 4th form
			if (currState == inputStatePressed)
				changeForm(3);
			break;
		case inputVals.btnA:
			//Q Ability
			if (currState == inputStatePressed)
				getCurrForm().formScrQ(global.ctrlPlayer.shipEnt);
			break;
	}
}