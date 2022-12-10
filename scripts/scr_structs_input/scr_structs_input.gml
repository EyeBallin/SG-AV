function controllerType(name, icon) constructor {
	contName = name;
	contIcon = icon;
	
	var nullInput = new inputLine("Null Input", -1, vk_pause);
	nullInput.ownBtnSetVal = true;
	nullInput.setCurrValBtnCode = method(nullInput, function() { valLastFrame = 0; });
		
	contButtons = array_create(countInputVals, nullInput);
	
	//Returns whether the current button is being held down
	/// @func checkBtnHeld(key)
	checkBtnHeld = function(key) {
		var getBtn = contButtons[clamp(key, 0, countInputVals-1)];
		if (getBtn.ownBtnHeld)
			return getBtn.checkBtnHeldCodeOvr();
		return checkBtnHeldCode(getBtn);
	};
	//Returns whether the current button was pressed this frame
	/// @func checkBtnPressed(key)
	checkBtnPressed = function(key) {
		var getBtn = contButtons[clamp(key, 0, countInputVals-1)];
		if (getBtn.ownBtnPressed)
			return getBtn.checkBtnPressedCodeOvr();
		return checkBtnPressedCode(getBtn);
	};
	//Returns whether the current button was released this frame
	/// @func checkBtnReleased(key)
	checkBtnReleased = function(key) {
		var getBtn = contButtons[clamp(key, 0, countInputVals-1)];
		if (getBtn.ownBtnReleased)
			return getBtn.checkBtnReleasedCodeOvr();
		return checkBtnReleasedCode(getBtn);
	};
	
	//Updates the valLastFrame variable of the button
	/// @func updateBtnCurrVal(key)
	updateBtnCurrVal = function(key) {
		var getBtn = contButtons[clamp(key, 0, countInputVals-1)];
		if (getBtn.ownBtnSetVal)
			getBtn.setCurrValBtnCodeOvr();
		else
			setCurrValBtnCode(getBtn);
	}
	
	checkBtnHeldCode = function(key){};
	checkBtnPressedCode = function(key){};
	checkBtnReleasedCode = function(key){};
	setCurrValBtnCode = function(key){};
}
	
function inputLine(name, icon, value) constructor {
	btnName = name;
	btnIcon = icon;
	btnValue = value;
	
	ownBtnHeld = false;						//Unique input held code?
	ownBtnPressed = false;					//Unique input started code?
	ownBtnReleased = false;					//Unique input ended code?
	
	valLastFrame = 0;						//The current value of the input (0 = off, 1 = on, inbetween = analogue on)
	ownBtnSetVal = false;					//Unique code to set the value? (Analogue, usually)
	
	checkBtnHeldCodeOvr = function(){};
	checkBtnPressedCodeOvr = function(){};
	checkBtnReleasedCodeOvr = function(){};
	setCurrValBtnCodeOvr = function(){};
}