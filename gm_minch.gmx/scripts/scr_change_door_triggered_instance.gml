 // Replace triggered door instance with the good one

var triggered_door_istance = argument1;

var door_object_name, new_door_object_name, new_door_object;

door_object_name = object_get_name(triggered_door_istance.object_index);

if (argument0 == global.DOOR_CLOSE)
{
    // By default, all dynamically closed doors are Cyan.
    // TODO: keep track of door color.
    new_door_object_name = string_copy(door_object_name, 1, 12) + "_cy";
}
else
{
    new_door_object_name = string_copy(door_object_name, 1, 12) + "_open";
}

new_door_object = asset_get_index(new_door_object_name);

with (triggered_door_istance) instance_change(new_door_object, false);
triggered_door_istance.depth = 100;
