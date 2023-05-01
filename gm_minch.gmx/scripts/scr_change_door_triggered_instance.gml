 // Replace triggered door instance with the good one

var triggered_door_istance = argument1;

var door_object_name, new_door_object_name, new_door_object;

door_object_name = object_get_name(triggered_door_istance.object_index);

if (argument0 == global.DOOR_CLOSE)
{
    new_door_object_name = string_copy(door_object_name, 1, 12) + "_" + scr_colors_int_to_str(self.color);
}
else
{
    new_door_object_name = string_copy(door_object_name, 1, 12) + "_open_" + scr_colors_int_to_str(self.color);
}

show_debug_message("scr_change_door_triggered_instance " + door_object_name + " > " + new_door_object_name);

new_door_object = asset_get_index(new_door_object_name);

with (triggered_door_istance) instance_change(new_door_object, false);

triggered_door_istance.depth = 100;
triggered_door_istance.image_alpha = 0;

return triggered_door_istance;
