augHeld = {};

augEquipGrid = array_create(0, new augmentObj({}, true));
for (var i = 0; i < 16; i += 1) {
	augEquipGrid[i] = {};
}
augEquipInven = array_create(48, {});

augVertex = [
	global.ctrlPlayer.formsLoaded[0],
	global.ctrlPlayer.formsLoaded[1],
	global.ctrlPlayer.formsLoaded[2],
	global.ctrlPlayer.formsLoaded[3]
]