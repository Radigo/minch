// Adds animated door instance over triggered door 

var animation_speed_multiplier = 1;
var triggered_door_istance = argument1;

var door_object_name, door_object_animation_name, door_object_animation, door_animation_instance;

if (argument0 == global.DOOR_CLOSE) {
    animation_speed_multiplier = -1;
    audio_play_sound(snd_door_close, global.SFX_LEVEL_DESIGN, false);
} else {
    audio_play_sound(snd_door_open, global.SFX_LEVEL_DESIGN, false);
}

door_object_name = object_get_name(triggered_door_istance.object_index);
door_object_animation_name = string_copy(door_object_name, 1, 12) + "_anim";
door_object_animation = asset_get_index(door_object_animation_name);


door_animation_instance = instance_create(triggered_door_istance.x, triggered_door_istance.y, door_object_animation);
door_animation_instance.image_speed = animation_speed_multiplier * 0.5;
door_animation_instance.depth = 100;
door_animation_instance.triggeredDoorInstance = triggered_door_istance;

show_debug_message("scr_add_door_anim_object " + door_object_animation_name);
