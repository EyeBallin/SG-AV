strDictEng = {};

//Load in the strings data
var engBuffer = buffer_load("strings_EN.txt");
var engStrings = buffer_read(engBuffer, buffer_text);

//Homogenise all new lines to use just ;;\n, then split using that token into an array
var newLineToken = ";;\n";
var stringNLParse = string_replace_all(engStrings, ";;\r\n", newLineToken);
var stringsSplit = string_split(stringNLParse, newLineToken);

//Populate the dictionary struct using the array
for (var i = 0; i < array_length(stringsSplit); i += 1) {
  var keyValSplit = string_split(stringsSplit[i], "::");
  struct_set(strDictEng, keyValSplit[0], keyValSplit[1]);
}

//Cleanup and global var setting
buffer_delete(engBuffer);
global.strDict = strDictEng;