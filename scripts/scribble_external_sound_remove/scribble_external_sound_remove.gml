function scribble_external_sound_exists(_alias)
{
    //Ensure we're initialized
    // Feather disable once GM2039
    __scribble_system();
    
    return ds_map_exists(global.__scribble_external_sound_map, _alias);
}