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

/// @param {Enum.augIDs} augID The augment ID, from the augIDs enum
/// @returns {Real} Total cost of this augment assuming no already-owned sub-components
function getAugTotalCost(augID) {
	var augInfo = global.ctrlInfo.infoAugments[augID];
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
		recursiveSetAugNodeCost(treeOfNodes, foundAugs, topLevelOwned, playerInv);
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
		augCost = getAugTotalCost(augIDArg);
	
		tierInTree = tierInTreeArg;
		parentNode = parentNodeArg;
		childNodes = array_create(0, new augBuildTreeNode(-1, 0, self));
	
		for (var i = 0; i < array_length(augInfo.augDataComponents); i += 1) {
			array_push(childNodes, new augBuildTreeNode(augInfo.augDataComponents[i], tierInTree + 1, self));
		};
	}
}

/// @desc  Recursively sets costs for augments in a build tree based upon whether any components already exist in the player's inventory.
/// @param {struct.augBuildTreeNode} augNode  The node in the tree to set the cost of & return cost to parent.
/// @param {struct} foundAugsStruct  A struct that stores all augments that have already been accounted for when lowering the tree's cost.
/// @param {bool} autoSetFound  Set to `true` when a higher-tier augment is found in the inventory. Sets this node and its children to be marked as found.
/// @param {array<struct.augmentObj>} playerInv  Pre-fetched player inventory for performance purposes.
/// @returns {real} Total current cost of this node
function recursiveSetAugNodeCost(augNode, foundAugsStruct, autoSetFound, playerInv) {
	for (var i = 0; i < array_length(augNode.childNodes); i += 1) {
		for (var j = 0; j < array_length(playerInv); j += 1) {
			if (struct_exists(playerInv[j], "augID")) {
				if (autoSetFound) {
					augNode.childNodes[i].augCost = 0;
				} else {
					var childIDMatchesInvID = augNode.childNodes[i].augID == playerInv[j].augID;
					var foundStructContainsID = struct_exists(foundAugsStruct, string(playerInv[j].augUniqueID));
					if (childIDMatchesInvID && !foundStructContainsID) {
						augNode.childNodes[i].augCost = 0;
						struct_set(foundAugsStruct, string(playerInv[j].augUniqueID), true);
					};
				};
			};
		};
	};
	if (!autoSetFound && augNode.augCost == 0) {
		autoSetFound = true;
	}
	var totalCost = augNode.augCost;
	for (var i = 0; i < array_length(augNode.childNodes); i += 1) {
		totalCost += recursiveSetAugNodeCost(augNode.childNodes[i], foundAugsStruct, autoSetFound, playerInv);
	};
	augNode.augCost = totalCost;
	return totalCost;
}