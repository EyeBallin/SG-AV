function scribble_external_sound_remove(_alias)
{
    //Ensure we're initialized
    // Feather disable once GM2039
    __scribble_system();
    
    ds_map_delete(global.__scribble_external_sound_map, _alias);
}