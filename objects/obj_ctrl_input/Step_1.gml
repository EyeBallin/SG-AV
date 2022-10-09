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
	
	switch(i) {
		case inputVals.stickRLeft:
			//Swap to the 1st form
			changeForm(0);
			break;
		case inputVals.stickRUp:
			//Swap to the 2nd form
			changeForm(1);
			break;
		case inputVals.stickRRight:
			//Swap to the 3rd form
			changeForm(2);
			break;
		case inputVals.stickRDown:
			//Swap to the 4th form
			changeForm(3);
			break;
	}
}