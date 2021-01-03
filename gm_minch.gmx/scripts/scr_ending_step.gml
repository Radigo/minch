// Just wait for any press to return to tile

var inputKey = -1;

for (var key = 2; key < 200; key++) {
    if (keyboard_check_pressed(key)) {
        inputKey = key;
        break;
    }
}

for (var inp = 0; inp < gamepad_button_count(global.control_type); inp++) {
    if (gamepad_button_check_pressed(global.control_type, inp)) {
        inputKey = inp;
        break;
    }
}

if (inputKey < 0) {
    return false;
}

room_goto(rm_title);
