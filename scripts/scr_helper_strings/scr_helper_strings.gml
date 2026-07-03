/// @desc Gets the given string from the dictionary, given an ID. Returns an error string if none found.
/// @param {string} strKey The ID of the string to fetch
/// @return {string} The found string, or "--ERROR--" if no string with given ID is found.
function getString(strKey) {
    var foundStr = variable_struct_get(global.ctrlStr.strDictEng, strKey);
    return (!is_undefined(foundStr)? foundStr : "--ERROR--");
}


/// @desc Using a 2-width array of placeholders and actual values, replaces all found placeholders in the given string with their actual value.
/// @param {string} str The core string that will be parsed
/// @param {array} Width 2, Length Any. [x][0] is the placeholder to target, [x][1] is the string to replace it with
function fillStringInfo(str, keyValMapArr) {
	for (var mapI = 0; mapI < array_length(keyValMapArr); i += 1) {
		str = string_replace_all(str, keyValMapArr[mapI][0], keyValMapArr[mapI][1]);
	}
	return str;
}