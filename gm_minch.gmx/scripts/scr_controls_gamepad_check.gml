/*
Checks if given control type is ready to go (supported and connected)
*/

var controlType = argument0;

if (!gamepad_is_supported()) {
    return controlType == -1;
}

return gamepad_is_connected(controlType);
