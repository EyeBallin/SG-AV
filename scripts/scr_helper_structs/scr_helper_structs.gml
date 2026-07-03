/// func mergeStructs(structTrg, structSrc, dupePrioSrc)

function mergeStructs(structTrg, structSrc, dupePrioSrc) {
	var newStruct = structTrg.copy();
	var srcVarCount = variable_struct_names_count(structSrc);
	var srcVars = variable_struct_get_names(structSrc);
	
	for (var q = 0; q < srcVarCount; q += 1) {
		var structVarName = srcVars[q];
		if (dupePrioSrc || !variable_struct_exists(newStruct, structVarName))
			variable_struct_set(newStruct, structVarName, variable_struct_get(structSrc, structVarName));
	}
	
	return newStruct;
}

//Credits: Zhanghua
/*
function deepCloneArray(s) {
	return array_map(s, function(e) {
		if (is_array(e))
			return deepCloneArray(e);
		else if (is_struct(e))
			return deepCloneStruct(e);
		return e;
  });
}

function deepCloneStruct(s){
    return array_map(variable_struct_get_names(s), method(
		{ ctx: s }, function(nm) {
            var e = ctx[$ nm];
            if (is_array(e))
				return deepCloneArray(e);
            else if (is_struct(e)) 
				return deepCloneStruct(e);
            return e;
        })
    );
}

function deepClone(s){
    if (is_array(s))
		return deepCloneArray(s);
    else if (is_struct(s))
		return deepCloneStruct(s);
    return s;
}*/

