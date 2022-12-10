/// @func listenCtrl()
function listenCtrl() constructor {
	//Initialise listener lists
	listHolder = [];
	listHolder[countSysListenType-1] = [];
	for (var i = 0; i < countSysListenType; i += 1)
		listHolder[i] = [];
	
	//Add an event to a listener list
	/// @func registerListener(functionToCall, listToPutIn, functionPrio, functionForms)
	registerListener = function(functionToCall, listToPutIn, functionPrio, functionForms) {
		var insertPos = 0;
		for (var i = 0; i < array_length(listHolder[listToPutIn]); i += 1) {
			if (listHolder[listToPutIn][i].funcPrio < functionPrio)
				break;
			insertPos += 1;
		}
		array_insert(listHolder[listToPutIn], insertPos, {funcCode: functionToCall, funcPrio: functionPrio, funcForms: functionForms});
	}
	
	
	/// @func deregisterListener(functionToRemove, listToRemoveFrom, functionPrio, functionForms)
	/// @desc Remove an event from a listener list
	deregisterListener = function(functionToRemove, listToRemoveFrom, functionPrio, functionForms) {
		for (var i = 0; i < array_length(listHolder[listToRemoveFrom]); i += 1) {
			var gotFunc = listHolder[listToRemoveFrom][i];
			if (gotFunc.funcPrio == functionPrio && gotFunc.funcCode == functionToRemove && gotFunc.funcForms = functionForms) {
				array_delete(listHolder[listToRemoveFrom], i, 1);
				break;
			}
		}
	}
	
	//Clear a listener list
	/// @func clearList(listToClear)
	clearList = function(listToClear) {
		listHolder[listToClear] = [];
	}
	
	//Broadcast an event
	/// @func broadcast(listToBroadcastTo, params)
	broadcast = function(listToBroadcastTo, params) {
		var list = listHolder[listToBroadcastTo];
		for (var i = 0;	i < array_length(list); i += 1) {
			var ev = list[i];
			var currForm = getCurrForm();
			var callCode = true;
			if (currForm != -1 && ev.funcForms != -1) {
				callCode = false;
				for (var j = 0; j < array_length(ev.funcForms); j += 1) {
					if (ev.funcForms[j].formID == currForm.formID) {
						callCode = true;
						break;
					}
				}
			}
			if (callCode) {
				var eventToCall = list[i].funcCode;
				params = eventToCall(params);
			}
		}
		return params;
	}
}