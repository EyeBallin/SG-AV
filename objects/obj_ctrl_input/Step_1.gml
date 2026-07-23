var currCtrler = ctrlInputs[currCtrl];
var currCtrlerBtns = currCtrler.contButtons;

for (var i = 0; i < array_length(currCtrlerBtns); i += 1) {
	var gotBtn = currCtrlerBtns[i];
	
	//Skip null inputs (unbound buttons)
	if (gotBtn.btnName == "Null Input") {
		continue;
	}
	
	var currState = inputStateOff;
	
	//Check the input
	if (currCtrler.checkBtnPressed(i)) {
		currState = inputStatePressed;
	} else if (currCtrler.checkBtnReleased(i)) {
		currState = inputStateReleased;
	} else if (currCtrler.checkBtnHeld(i)) {
		currState = inputStateHeld;
	}
		
	//Perform one final update of the input's last frame var if it's determined to be off
	if (currState == inputStateOff) {
		if (gotBtn.valLastFrame != 0) {
			currCtrler.updateBtnCurrVal(i);
		}
		continue;
	}
	
	//Early Check For Screen-Related Buttons
	if (currCtrl == inputTypeKeyboard && currState == inputStatePressed) {
		//Full Screen Switch
		if (i == inputVals.btnSel) {
			var currFullscreen = window_get_fullscreen();
			window_set_fullscreen(!currFullscreen);
			continue;
		}
		else if (i == inputVals.btnL) {
			game_end();
		} else if (i == inputVals.btnStart) {
			if (global.ctrlGameState.currGameState != gameStateEnum.statePause) {
				global.ctrlGameState.cacheGameState = global.ctrlGameState.currGameState;
				global.ctrlGameState.currGameState = gameStateEnum.statePause;
				part_system_automatic_update(global.partSystem, false);
			} else {
				global.ctrlGameState.currGameState = global.ctrlGameState.cacheGameState;
				global.ctrlGameState.cacheGameState = gameStateEnum.statePause;
				part_system_automatic_update(global.partSystem, true);
			}
		} else if (i == inputVals.btnR) {
			if (global.ctrlGameState.currGameState == gameStateEnum.stateActiveGame) {
				global.ctrlGameState.currGameState = gameStateEnum.stateShop;
				global.ctrlScreenShop.shopVisible = true;
			} else if (global.ctrlGameState.currGameState == gameStateEnum.stateShop) {
				global.ctrlGameState.currGameState = gameStateEnum.stateActiveGame;
				global.ctrlScreenShop.shopVisible = false;
			}
		}
	}
	
	if (global.ctrlGameState.currGameState == gameStateEnum.stateActiveGame) {
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
	      getCurrForm().formUseQ(global.ctrlPlayer.shipEnt, currState, false);
				break;
	    case inputVals.btnB:
	      //W Ability
	      getCurrForm().formUseW(global.ctrlPlayer.shipEnt, currState, false);
	      break;
	    case inputVals.btnY:
	      //E Ability
	      getCurrForm().formUseE(global.ctrlPlayer.shipEnt, currState, false);
	      break;
		}
	} else if (global.ctrlGameState.currGameState == gameStateEnum.stateShop) {
		switch(i) {
			case inputVals.stickRUp:
				if (currState == inputStatePressed) {
					global.ctrlScreenShop.augBuilderScrollPageUp();
				}
				break;
			case inputVals.stickRDown:
				if (currState == inputStatePressed) {
					global.ctrlScreenShop.augBuilderScrollPageDown();
				}
				break;
			case inputVals.stickLLeft:
				if (currState == inputStatePressed) {
					global.ctrlScreenShop.moveCursorLeft();
				}
				break;
			case inputVals.stickLUp:
				if (currState == inputStatePressed) {
					global.ctrlScreenShop.moveCursorUp();
				}
				break;
			case inputVals.stickLRight:
				if (currState == inputStatePressed) {
					global.ctrlScreenShop.moveCursorRight();
				}
				break;
			case inputVals.stickLDown:
				if (currState == inputStatePressed) {
					global.ctrlScreenShop.moveCursorDown();
				}
				break;
			case inputVals.btnA:
				if (currState == inputStatePressed) {
					global.ctrlScreenShop.selectedBtn.onBtnPress();
				}
				break;
			case inputVals.btnB:
				if (currState == inputStatePressed) {
					global.ctrlScreenShop.selectedBtn.onBtnCancel();
				}
				break;
			case inputVals.btnX:
				if (currState == inputStatePressed) {
					global.ctrlScreenShop.selectedBtn.onBtnInfo();
				}
		}
	}
}