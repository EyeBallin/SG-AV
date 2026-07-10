/// @func createAugObj(augID)
/// @desc Returns an Augment object
function createAugObj(augID) {
	if (augID < countAugs) {
		var augInfo = global.ctrlInfo.infoAugments[augID];
		var augObj = new augmentObj(augInfo);
		for (var i = 0; i < array_length(augInfo.augDataFunctions); i += 1) {
			augObj.augFunctions[i][0] = augInfo.augDataFunctions[i][0];
			augObj.augFunctions[i][1] = augInfo.augDataFunctions[i][1];	
			augObj.augFunctions[i][2] = method(augObj, augInfo.augDataFunctions[i][2]);	
		}
		return augObj;
	}
	return -1;
}

/// @func getAugSlotForms(slotNum)
/// @desc Returns the ship forms associated with the given slot in the aug grid
function getAugSlotForms(slotNum) {
	var arr = global.ctrlInven.augVertex;
	
	//If the middle 4, return all forms
	if (slotNum == 5 || slotNum == 6 || slotNum == 9 || slotNum == 10)
		return arr;
		
	//If the corners, return the correct two
	else if (slotNum == 0)
		return [arr[0], arr[3]];
	else if (slotNum == 3)
		return [arr[0], arr[1]];
	else if (slotNum == 12)
		return [arr[2], arr[3]];
	else if (slotNum == 15)
		return [arr[1], arr[2]];
		
	//Else, return the single form for that given side
	else if (slotNum == 1 || slotNum == 2)
		return [arr[0]];
	else if (slotNum == 4 || slotNum == 8)
		return [arr[3]];
	else if (slotNum == 7 || slotNum == 11)
		return [arr[1]];
	else if (slotNum == 13 || slotNum == 14)
		return [arr[2]];
	
	//If somehow none of these numbers, you fucked up
	else
		return -1;
}

/// @func equipAugment(augObj, slotNum)
/// @desc Puts the currently held augment in the given slot. If there's another augment already there, they are swapped.
function equipAugment(augObj, slotNum) {
	if (augObj != -1 && slotNum >= 0 && slotNum <= 15) {
		var formsUsed = getAugSlotForms(slotNum);
		//If this is a picked up augment, then it's no longer picked up
		if (augObj == global.ctrlInven.augHeld)
			global.ctrlInven.augHeld = -1;
			
		//Register the augment's functions	
		for (var i = 0; i < array_length(augObj.augFunctions); i += 1) {
			var funcInfo = augObj.augFunctions[i];
			global.ctrlBC.registerListener(funcInfo[2], funcInfo[0], funcInfo[1], formsUsed);
		}
	
		//Place the augment in the grid, taking out whatever's underneath
		var tmpAug = -1;
		if (global.ctrlInven.augEquipGrid[slotNum] != -1)
			tmpAug = global.ctrlInven.augEquipGrid[slotNum];
		global.ctrlInven.augEquipGrid[slotNum] = augObj;
		if (tmpAug != -1) {
			global.ctrlInven.augHeld = tmpAug;
			
			tmpAug.slotEquipped = -1;
			tmpAug.formsEquipped = [];
			
			//Automatically remove augment stats
			var augStatsArr = struct_get_names(tmpAug.augStats);
			for (var i = 0; i < array_length(augStatsArr); i += 1) {
				var statName = augStatsArr[i];
				var statVal = struct_get(tmpAug.augStats, statName);
			
				if (statName == "hp") {
					formsUsed[0].getStatHP().modifyResMax(-statVal.val, statVal.percentMod, true);
				}
				else {
					for (var j = 0; j < array_length(formsUsed); j += 1) {
	          var statPointer = formsUsed[j].getStringStat(statName);
	          var statToMod = statPointer();
						if (statToMod.eStatIsRes)
							statToMod.modifyResMax(-statVal.val, statVal.percentMod, true);
						else
							statToMod.modifyStat(-statVal.val, statVal.percentMod);
					}
				}
			}
			
			global.ctrlBC.broadcast(sysEvent.evAugUnequip, { tmpAug: tmpAug, formsUsed: formsUsed });
			
			for (var i = 0; i < array_length(tmpAug.augFunctions); i += 1) {
				var funcInfo = tmpAug.augFunctions[i];
				global.ctrlBC.deregisterListener(funcInfo[2], funcInfo[0], funcInfo[1], formsUsed);
			}
		}
		//Automatically apply augment stats
		var augStatsArr = struct_get_names(augObj.augStats);
		for (var i = 0; i < array_length(augStatsArr); i += 1) {
			var statName = augStatsArr[i];
			var statVal = struct_get(augObj.augStats, statName);
			
			if (statName == "hp") {
				formsUsed[0].getStatHP().modifyResMax(statVal.val, statVal.percentMod, true);
			}
			else {
				for (var j = 0; j < array_length(formsUsed); j += 1) {
					var statPointer = formsUsed[j].getStringStat(statName);
          var statToMod = statPointer();
					if (statToMod.eStatIsRes)
						statToMod.modifyResMax(statVal.val, statVal.percentMod, true);
					else
						statToMod.modifyStat(statVal.val, statVal.percentMod);
				}
			}
		}
			
		augObj.slotEquipped = slotNum;
		augObj.formsEquipped = formsUsed;
		
		global.ctrlBC.broadcast(sysEvent.evAugEquip,  { augObj: augObj, formsUsed: formsUsed });
	}
}

/// @func unequipAugment(slotNum)
/// @desc Unequips the augment at the given slot, if there's no currently-held augment
function unequipAugment(slotNum) {
	if (global.ctrlInven.augHeld == -1 && slotNum >= 0 && slotNum <= 15) {
		var tmpAug = global.ctrlInven.augGridEquipped[slotNum];
		var formsUsed = getAugSlotForms(slotNum);
		
		//Automatically remove augment stats
		var augStatsArr = struct_get_names(tmpAug.augStats);
		for (var i = 0; i < array_length(augStatsArr); i += 1) {
			var statName = augStatsArr[i];
			var statVal = struct_get(tmpAug.augStats, statName);
			
			if (statName == "hp") {
				formsUsed[0].getStatHP().modifyResMax(-statVal.val, statVal.percentMod, true);
			}
			else {
				for (var j = 0; j < array_length(formsUsed); j += 1) {
                    var statPointer = formsUsed[j].getStringStat(statName);
                    var statToMod = statPointer();
					if (statToMod.eStatIsRes)
						statToMod.modifyResMax(-statVal.val, statVal.percentMod, true);
					else
						statToMod.modifyStat(-statVal.val, statVal.percentMod);
				}
			}
		}
		
		global.ctrlInven.augHeld = tmpAug;
		global.ctrlBC.broadcast(sysEvent.evAugUnequip, { tmpAug: tmpAug, formsUsed: formsUsed });
		tmpAug.slotEquipped = -1;
		tmpAug.formsEquipped = [];
			
		for (var i = 0; i < array_length(tmpAug.augFunctions); i += 1) {
			var funcInfo = tmpAug.augFunctions[i];
			global.ctrlBC.deregisterListener(funcInfo[2], funcInfo[0], funcInfo[1], getAugSlotForms(slotNum));
		}
	}
}