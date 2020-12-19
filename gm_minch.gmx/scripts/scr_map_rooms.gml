global.allLevels = ds_map_create();
global.orderedLevelNames = ds_list_create();

var roomIndex = 0;
while (room_exists(roomIndex)) {
    if (scr_is_room_level(room_get_name(roomIndex), false)) {
        show_debug_message("Adding room " + room_get_name(roomIndex));
        ds_map_add(global.allLevels, room_get_name(roomIndex), roomIndex);
        ds_list_add(global.orderedLevelNames, room_get_name(roomIndex));
    }
    roomIndex = room_next(roomIndex);
}
