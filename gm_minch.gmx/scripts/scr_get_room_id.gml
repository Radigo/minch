var room_arg = argument0;

var room_str = room_get_name(room_arg);

if (!scr_is_room_level(room_str)) {
    return room_str;
}

var world_id = string_char_at(room_str, string_length(room_str) - 1);
var level_id = string_char_at(room_str, string_length(room_str));

return world_id + "-" + level_id;
