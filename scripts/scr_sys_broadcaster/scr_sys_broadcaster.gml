/// @desc Creates a Listener Controller for Broadcasts
/// @returns {Struct.listenCtrl} The Controller
function listenCtrl() constructor {
	//Initialise listener lists
  
  var dummyStruct = broadcastListenerInfo(function(){}, 0 ,-1);
  listHolder = [];
  listHolder[countSysListenType-1] = [];
	listHolder = array_create(countSysListenType-1, array_create(1, dummyStruct));
	for (var i = 0; i < countSysListenType; i += 1)
		listHolder[i] = [];

  /// @desc Adds a listening function into a given list, settings its priority and ship form filter
  /// @param {Function} functionToCall What function to call when there's a given broadcast
  /// @param {Enum.sysEvent} listToPutIn The broadcast list to put it in - IE, what event does this function subscribe to
  /// @param {Real} functionPrio The priority of the event, to determine if it needs to occur before or after other events
  /// @param {Array<Struct.shipForms>, Real} functionForms Which ship forms this event can trigger from, if needed (Augments, etc.). -1 means no 
  registerListener = function(functionToCall, listToPutIn, functionPrio, functionForms) {
		var insertPos = 0;
		for (var i = 0; i < array_length(listHolder[listToPutIn]); i += 1) {
			if (listHolder[listToPutIn][i].funcPrio < functionPrio)
				break;
			insertPos += 1;
		}
		array_insert(listHolder[listToPutIn], insertPos, new broadcastListenerInfo(functionToCall, functionPrio, functionForms));
	}
	
	/// @desc Remove an event from a listener list
  /// @param {Function} functionToRemove The function code that needs to be removed
  /// @param {Enum.sysEvent} listToRemoveFrom The list that this function needs to be removed from
  /// @param {Real} functionPrio The priority of the function (used to help identify which exact function needs to be removed)
  /// @param {Array<Struct.shipForms>, Real} functionForms Which ship forms the function applies to, if relevant (used to help identify)
	deregisterListener = function(functionToRemove, listToRemoveFrom, functionPrio, functionForms) {
		for (var i = 0; i < array_length(listHolder[listToRemoveFrom]); i += 1) {
			var gotFunc = listHolder[listToRemoveFrom][i];
			if (gotFunc.funcPrio == functionPrio && gotFunc.funcCode == functionToRemove && gotFunc.funcForms = functionForms) {
				array_delete(listHolder[listToRemoveFrom], i, 1);
				break;
			}
		}
	}
	
  /// @desc Clears a given list
  /// @param {Enum.sysEvent} listToClear Which list to clear
	clearList = function(listToClear) {
		listHolder[listToClear] = [];
	}
	
	/// @desc Broadcast an event
  /// @param {Enum.sysEvent} listToBroadcastTo Which list to broadcast the event to
  /// @param {Struct} params Freeform struct of params that this event broadcasts with
	broadcast = function(listToBroadcastTo, params) {
		var list = listHolder[listToBroadcastTo];
		for (var i = 0;	i < array_length(list); i += 1) {
			var ev = list[i];
			var callCode = true;
			if (ev.funcForms != -1) {
        var currForm = getCurrForm();
        if (currForm != -1) {
          callCode = false;
  				for (var j = 0; j < array_length(ev.funcForms); j += 1) {
  					if (ev.funcForms[j].formID == currForm.formID) {
  						callCode = true;
  						break;
  					}
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

/// @desc Details about an event that can trigger when the broadcast channel it's listening to emits something.
/// @param {Function} funcCodeParam Function code to run when triggered.
/// @param {Real} funcPrioParam Priority of when the function triggers in relation to other listening functions.
/// @param {Array<Struct.shipForm>, real} funcFormsParam Which ship forms this code applies to, if relevant (EG: Augments). -1 if irrelevant.
/// @returns {Struct.broadcastListenerInfo} Broadcast listener info struct
function broadcastListenerInfo(funcCodeParam, funcPrioParam, funcFormsParam) constructor {
  funcCode = funcCodeParam;
  funcPrio = funcPrioParam;
  funcForms = funcFormsParam;
}