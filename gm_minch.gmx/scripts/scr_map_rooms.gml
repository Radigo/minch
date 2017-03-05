var i, ds_map;

ds_map = argument0;

for (i = 0; i < global.NUM_LEVELS; i += 1)
{
    if (room_exists(i))
    {
        if (scr_is_room_level(room_get_name(i)))
        {
            show_debug_message("Adding room " + room_get_name(i) + " to map_list under key: " + scr_get_room_id(i));
            ds_map_add(ds_map, scr_get_room_id(i), i);
        }
    }
}

return ds_map;
