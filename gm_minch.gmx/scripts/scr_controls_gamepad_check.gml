/*
Checks if given control type is ready to go (supported and connected)
*/

var controlType = argument0;

//show_debug_message("scr_controls_gamepad_check controlType: " + string(controlType));

if (!gamepad_is_supported()) {
    //show_debug_message("not supported, return to keyboard");
    return controlType == -1;
}

//show_debug_message("supported");
return gamepad_is_connected(controlType);
