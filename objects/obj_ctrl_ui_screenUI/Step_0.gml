var currForm = getCurrForm();

var cooldownExactQ = currForm.formCooldownQ;
var cooldownExactW = currForm.formCooldownW;
var cooldownExactE = currForm.formCooldownE;

if (cooldownExactQ == 0) {
	if (cooldownStringQ != "Ready!") {
		cooldownStringQ = "Ready!";
		cooldownCurrQ = scribble(cooldownStringQ);
	}
} else {
	var cooldownQFloor = string(floor(cooldownExactQ));
	if (cooldownQFloor != cooldownStringQ) {
		cooldownStringQ = cooldownQFloor;
		cooldownCurrQ = scribble(cooldownStringQ);
	}
}