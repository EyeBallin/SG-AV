/// @param newFontName

function scribble_super_create(_name)
{
    //Ensure we're initialised
    // Feather disable once GM2039
    __scribble_system();
    
    var _font_data = new __scribble_class_font(_name, 1, undefined);
    _font_data.__runtime   = true;
    _font_data.__superfont = true;
}