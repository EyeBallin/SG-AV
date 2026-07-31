/// @func createAugObj(augID)
/// @desc Returns an Augment object
/// @param {Enum.augIDs} augID augIDs enum for which augment this will be
/// @returns {Struct.augmentObj} augment object
function createAugObj(augID) {
	if (augID < countAugs) { 
		var augInfo = global.ctrlInfo.infoAugments[augID];
		var augObj = new augmentObj(augInfo);
		for (var i = 0; i < array_length(augInfo.augDataPassives); i += 1) {
			var gotPassive = augInfo.augDataPassives[i];
			var objPassive = augObj.augPassives[i];
			for (var j = 0; j < array_length(gotPassive.augPassFunctions); j += 1) {
				var objFunc = objPassive.passiveFunctions[j];
				var infoFunc = gotPassive.augPassFunctions[j];
				
				objFunc.funcCode = method(augObj, infoFunc.funcCode);
			}
		}
		return augObj;
	}
	return -1;
}

/// @desc  getAugSlotForms(slotNum)  Returns the ship forms associated with the given slot in the aug grid
/// @param {real} slotNum Description
/// @returns {Array<Struct.shipForm>}
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
		return [];
}

/// @desc Given a form ID, return an array of the aug slots that form reads from.
/// @param {Enum.sgForm} sgFormID The ship form ID
/// @returns {Array<Real>} Array of ints - all keys in the aug grid that this form uses
function getAugSlotsFormUses(sgFormID) {
	var cellsArr = [];
	var formLoadedSlot = -1;
	//Return an empty array if the queried form isn't loaded
	for (var i = 0; i < array_length(global.ctrlPlayer.formsLoaded); i += 1) {
		if (global.ctrlPlayer.formsLoaded[i].formID == sgFormID) {
			formLoadedSlot = i;
			break;
		}
	}
	if (formLoadedSlot != -1) {
		array_push(cellsArr, 5, 6, 9, 10);
		switch (formLoadedSlot) {
			case 0: array_push(cellsArr, 0, 4, 8, 12); break;
			case 1: array_push(cellsArr, 0, 1, 2, 3); break;
			case 2: array_push(cellsArr, 3, 7, 11, 15); break;
			case 3: array_push(cellsArr, 12, 13, 14, 15); break;
		}
	}
	return cellsArr;
}

/// @func equipAugment(augObj, slotNum)
/// @desc Puts the currently held augment in the given slot. If there's another augment already there, they are swapped.
/// @param {Struct.augmentObj} augObj Augment struct object
/// @param {Real} slotNum Inventory slot number (0 - 15 inclusive)
function equipAugment(augObj, slotNum) {
	if (struct_exists(augObj, "augID") && slotNum >= 0 && slotNum <= 15) {
		var formsUsed = getAugSlotForms(slotNum);
		//If this is a picked up augment, then it's no longer picked up
		if (struct_exists(global.ctrlInven.augHeld, "augID") && augObj.augUniqueID == global.ctrlInven.augHeld.augUniqueID) {
			global.ctrlInven.augHeld = {};
			global.ctrlInven.augHeldGridSlotNum = -1;
		}
			
		//Register the augment's functions	
		for (var i = 0; i < array_length(augObj.augPassives); i += 1) {
			var passiveInfo = augObj.augPassives[i];
			for (var j = 0; j < array_length(passiveInfo.passiveFunctions); j += 1) {
				var funcInfo = passiveInfo.passiveFunctions[j];
				global.ctrlBC.registerListener(funcInfo.funcCode, funcInfo.eventID, funcInfo.priority, formsUsed);
			}
		}
	
		//Place the augment in the grid, taking out whatever's underneath (if it's not the same augment - IE a cancellation of picking up that augment)
		var tmpAug = new augmentObj({}, true);
		if (struct_exists(global.ctrlInven.augEquipGrid[slotNum], "augID")) {
			tmpAug = global.ctrlInven.augEquipGrid[slotNum];
		}
		global.ctrlInven.augEquipGrid[slotNum] = augObj;
		if (struct_exists(tmpAug, "augID")) {
			global.ctrlInven.augHeld = tmpAug;
			global.ctrlInven.augHeldGridSlotNum = slotNum;
			global.ctrlScreenShop.buildAndDisplayAugTree(tmpAug.augID);
			
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
			
			for (var i = 0; i < array_length(tmpAug.augPassives); i += 1) {
				var passiveInfo = tmpAug.augPassives[i];
				for (var j = 0; j < array_length(passiveInfo.passiveFunctions); j += 1) {
					var funcInfo = passiveInfo.passiveFunctions[j];
					global.ctrlBC.deregisterListener(funcInfo.funcCode, funcInfo.eventID, funcInfo.priority, formsUsed);
				}
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
	if (global.ctrlInven.augHeldGridSlotNum == -1 && slotNum >= 0 && slotNum <= 15) {
		var tmpAug = global.ctrlInven.augEquipGrid[slotNum];
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
		global.ctrlInven.augHeldGridSlotNum = slotNum;
		global.ctrlBC.broadcast(sysEvent.evAugUnequip, { tmpAug: tmpAug, formsUsed: formsUsed });
		tmpAug.slotEquipped = -1;
		tmpAug.formsEquipped = [];
			
		for (var i = 0; i < array_length(tmpAug.augPassives); i += 1) {
			var passiveInfo = tmpAug.augPassives[i];
			for (var j = 0; j < array_length(passiveInfo.passiveFunctions); j += 1) {
				var funcInfo = passiveInfo.passiveFunctions[j];
				global.ctrlBC.deregisterListener(funcInfo.funcCode, funcInfo.eventID, funcInfo.priority, getAugSlotForms(slotNum));
			}
		}
		
		global.ctrlInven.augEquipGrid[slotNum] = {};
	}
}

function destroyEquippedAugment(slotNum) {
	if (global.ctrlInven.augHeldGridSlotNum == -1 && slotNum >= 0 && slotNum <= 15) {
		var tmpAug = global.ctrlInven.augEquipGrid[slotNum];
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
		
		global.ctrlBC.broadcast(sysEvent.evAugUnequip, { tmpAug: tmpAug, formsUsed: formsUsed });
		tmpAug.slotEquipped = -1;
		tmpAug.formsEquipped = [];
		
		for (var i = 0; i < array_length(tmpAug.augPassives); i += 1) {
			var passiveInfo = tmpAug.augPassives[i];
			for (var j = 0; j < array_length(passiveInfo.passiveFunctions); j += 1) {
				var funcInfo = passiveInfo.passiveFunctions[j];
				global.ctrlBC.deregisterListener(funcInfo.funcCode, funcInfo.eventID, funcInfo.priority, getAugSlotForms(slotNum));
			}
		}
		
		global.ctrlInven.augEquipGrid[slotNum] = {};
		
		delete tmpAug;
	}
}

/// @param {Enum.augIDs} augID The augment ID, from the augIDs enum
/// @returns {Real} Total cost of this augment assuming no already-owned sub-components
function getAugTotalCost(augID) {
	var augInfo = ctrlInfo().infoAugments[augID];
	var infoBaseCost = augInfo.augDataBuildCost;
	for (var i = 0; i < array_length(augInfo.augDataComponents); i += 1) {
		infoBaseCost += getAugTotalCost(augInfo.augDataComponents[i]);	
	}
	return infoBaseCost;
}

/// @param {Enum.augIDs} augID The augment ID, from the augIDs enum. -1 can be used for a null obj for feather purposes
function augBuildTree(augID) constructor {
	baseAugID = augID;
	if (augID != -1) {
		var augInfo = global.ctrlInfo.infoAugments[augID];
		baseCost = getAugTotalCost(augID);
		treeOfNodes = new augBuildTreeNode(augID, 0, {});
		var foundAugs = {};
		var playerInv = global.ctrlInven.augEquipGrid;
		var topLevelOwned = false;
		for (var i = 0; i < array_length(playerInv); i += 1) {
			if (struct_exists(playerInv[i], "augID") && playerInv[i].augID == augID) {
				topLevelOwned = true;
				struct_set(foundAugs, string(playerInv[i].augUniqueID), true);
			};
		};
		var alreadyOwnedCounts = {};
		var alreadyOwnedCountsFinal = {};
		for (var i = 0; i < array_length(playerInv); i += 1) {
			var invSlot = playerInv[i];
			if (struct_exists(invSlot, "augID")) {
				var augIDStr = string(invSlot.augID);
				if (struct_exists(alreadyOwnedCounts, augIDStr)) {
					alreadyOwnedCounts[$ augIDStr] += 1;
				} else {
					alreadyOwnedCounts[$ augIDStr] = 1;
				}
			}
		}
		recursiveSetAugNodeCost(treeOfNodes, playerInv, alreadyOwnedCounts, topLevelOwned);
		var done = true;
	}
}

/// @param {Enum.augIDs} augIDArg The augment ID, from the augIDs enum
/// @param {Real} tierInTreeArg What level of the tree they're on
/// @param {Struct.augBuilderTreeNode} parentNodeArg The tree node that is this node's parent
function augBuildTreeNode(augIDArg, tierInTreeArg, parentNodeArg) constructor {
	nodeUniqueID = random(999999999);
	if (augIDArg != -1) {
		augID = augIDArg;
		augInfo = global.ctrlInfo.infoAugments[augIDArg];
		augBaseCost = augInfo.augDataBuildCost;
		augTotalCost = getAugTotalCost(augIDArg);
		augCost = getAugTotalCost(augIDArg);
		augCostScr = scribble("");
		augAlreadyOwned = false;
	
		tierInTree = tierInTreeArg;
		parentNode = parentNodeArg;
		childNodes = array_create(0, new augBuildTreeNode(-1, 0, self));
		childrenAlreadyOwned = {};
	
		for (var i = 0; i < array_length(augInfo.augDataComponents); i += 1) {
			array_push(childNodes, new augBuildTreeNode(augInfo.augDataComponents[i], tierInTree + 1, self));
		};
	}
}

/// @param {Enum.augIDs} augIDToCheckFor
/// @param {Struct.infoAugmentLine} augInfo
/// @returns {bool}
function recursiveCheckIfBuildPathHasAugID(augIDToCheckFor, augInfo) {
	var augComponents = augInfo.augDataComponents;
	for (var i = 0; i < array_length(augComponents); i += 1) {
		if (augComponents[i] == augIDToCheckFor || recursiveCheckIfBuildPathHasAugID(augIDToCheckFor, global.ctrlInfo.infoAugments[augComponents[i]])) {
			return true;
		}
	}
	return false;
}

/// @param {Enum.augIDs} augIDToCheckFor
/// @param {struct.augBuildTreeNode} augNode The node in the tree to calculate.
/// @returns {struct.augBuildTreeNode}
function recursiveGetNodeInPathFromID(augIDToGetNodeFor, nodeToCheck) {
	if (nodeToCheck.augID == augIDToGetNodeFor) {
		return nodeToCheck;
	} else {
		var subcheck = {};
		for (var i = 0; i < array_length(nodeToCheck.childNodes); i += 1) {
			var subRet = recursiveGetNodeInPathFromID(augIDToGetNodeFor, nodeToCheck.childNodes[i]);
			if (struct_exists(subRet, "augID")) {
				subcheck = subRet;
				break;
			}
		}
		return subcheck;
	}
}

/// @param {struct.augBuildTreeNode} augNode The node in the tree to calculate.
/// @param {array<Struct.augmentObj>} playerInv Player inventory for easy access.
/// @param {struct} alreadyOwnedCounts Struct of how many of each augment are already owned.
function recursiveSetAugNodeCost(augNode, playerInv, alreadyOwnedCounts, autoMarkedOwned) {
	var alreadyOwnedCountsDed = {};
	var ownedCountsKeys = struct_get_names(alreadyOwnedCounts);
	for (var i = 0; i < array_length(ownedCountsKeys); i += 1) {
		alreadyOwnedCountsDed[$ ownedCountsKeys[i]] = alreadyOwnedCounts[$ ownedCountsKeys[i]];
	};
	for (var i = 0; i < array_length(augNode.childNodes); i += 1) {
		recursiveDeductOwned(augNode.childNodes[i], alreadyOwnedCountsDed);
	}
	var finalCost = augNode.augTotalCost;
	for (var i = 0; i < array_length(ownedCountsKeys); i += 1) {
		var ownedDiff = abs(alreadyOwnedCountsDed[$ ownedCountsKeys[i]] - alreadyOwnedCounts[$ ownedCountsKeys[i]]);
		if (ownedDiff > 0) {
			var augIDInt = real(ownedCountsKeys[i]);
			augNode.childrenAlreadyOwned[$ ownedCountsKeys[i]] = ownedDiff;
			finalCost -= getAugTotalCost(augIDInt) * ownedDiff;
		};
	};
	augNode.augCost = finalCost;
	augNode.augCostScr = scribble(augNode.augCost).starting_format("fnt_desc", #FFFFFF);
	
	for (var i = 0; i < array_length(augNode.childNodes); i += 1) {
		recursiveSetAugNodeCost(augNode.childNodes[i], playerInv, alreadyOwnedCounts, );
	}
}

/// @param {struct.augBuildTreeNode} augNode  The node in the tree to set the cost of & return cost to parent.
function recursiveDeductOwned(augNode, alreadyOwnedCounts) {
	var strID = string(augNode.augID);
	if (struct_exists(alreadyOwnedCounts, strID) && alreadyOwnedCounts[$ strID] > 0) {
		alreadyOwnedCounts[$ strID] -= 1;
		recursiveMarkedChildrenAsOwned(augNode);
	} else if (!augNode.augAlreadyOwned) {
		for (var i = 0; i < array_length(augNode.childNodes); i += 1) {
			recursiveDeductOwned(augNode.childNodes[i], alreadyOwnedCounts);
		}
	}
}

/// @param {struct.augBuildTreeNode} augNode  The node in the tree to set the cost of & return cost to parent.
function recursiveMarkedChildrenAsOwned(augNode) {
	augNode.augAlreadyOwned = true;
	for (var i = 0; i < array_length(augNode.childNodes); i += 1) {
		recursiveMarkedChildrenAsOwned(augNode.childNodes[i]);
	}
}