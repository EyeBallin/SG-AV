strDictEng = {};
var engBuffer = buffer_load("strings_EN.txt");
var engStrings = buffer_read(engBuffer, buffer_text);
var stringsSplit = string_split(engStrings, ";;\r\n");
for (var i = 0; i < array_length(stringsSplit); i += 1) {
    var keyValSplit = string_split(stringsSplit[i], "::");
    struct_set(strDictEng, keyValSplit[0], keyValSplit[1]);
}
buffer_delete(engBuffer);
global.strDict = strDictEng;