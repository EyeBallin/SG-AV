ctrlInputs[countInputTypes-1] = undefined;
currCtrl = inputTypeKeyboard;
globalvar ctrlSlot;
ctrlSlot = 0;
gamepad_set_axis_deadzone(ctrlSlot, 0.3);


//Keyboard
{
var kbInput = new controllerType("Keyboard", -1);
kbInput.checkBtnHeldCode = method(kbInput, function(key) { return keyboard_check(key.btnValue); });
kbInput.checkBtnPressedCode = method(kbInput, function(key) { return keyboard_check_pressed(key.btnValue); });
kbInput.checkBtnReleasedCode = method(kbInput, function(key) { return keyboard_check_released(key.btnValue); });
kbInput.setCurrValBtnCode = method(kbInput, function(key) { key.valLastFrame = (keyboard_check(key.btnValue) ? 1 : 0); });
kbInput.contButtons[inputVals.btnA] = new inputLine("Q Key", -1, ord("Q"));
kbInput.contButtons[inputVals.btnB] = new inputLine("W Key", -1, ord("W"));
kbInput.contButtons[inputVals.btnY] = new inputLine("E Key", -1, ord("E"));
kbInput.contButtons[inputVals.btnX] = new inputLine("R Key", -1, ord("R"));
kbInput.contButtons[inputVals.stickLLeft] = new inputLine("Left Arrow Key", -1, vk_left);
kbInput.contButtons[inputVals.stickLRight] = new inputLine("Right Arrow Key", -1, vk_right);
kbInput.contButtons[inputVals.stickLUp] = new inputLine("Up Arrow Key", -1, vk_up);
kbInput.contButtons[inputVals.stickLDown] = new inputLine("Down Arrow Key", -1, vk_down);
kbInput.contButtons[inputVals.stickRLeft] = new inputLine("1 Key", -1, ord("1"));
kbInput.contButtons[inputVals.stickRUp] = new inputLine("2 Key", -1, ord("2"));
kbInput.contButtons[inputVals.stickRRight] = new inputLine("3 Key", -1, ord("3"));
kbInput.contButtons[inputVals.stickRDown] = new inputLine("4 Key", -1, ord("4"));
kbInput.contButtons[inputVals.btnDPadLeft] = new inputLine("F11 (Full-Screen)", -1, vk_f11);
kbInput.contButtons[inputVals.btnStart] = new inputLine("Escape Key", -1, vk_escape);
ctrlInputs[inputTypeKeyboard] = kbInput;
}


/// @func getCtrl(inputVal)
function getCtrl(inputVal) {
	return ctrlInputs[currCtrl].contButtons[inputVal];
}