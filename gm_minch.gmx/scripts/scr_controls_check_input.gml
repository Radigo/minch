var requiredControl = argument0;

if (global.control_type < 0) {
    switch (requiredControl) {
        case global.UP:
            return keyboard_check(global.key_up);
        case global.DOWN:
            return keyboard_check( global.key_down);
        case global.LEFT:
            return keyboard_check( global.key_left);
        case global.RIGHT:
            return keyboard_check( global.key_right);
        case global.A:
            return keyboard_check( global.key_a);
        case global.B:
            return keyboard_check( global.key_b);
        case global.START:
            return keyboard_check( global.key_start);
    }
} else {
    switch (requiredControl) {
        case global.UP:
            return gamepad_button_check(global.control_type, global.pad_up);
        case global.DOWN:
            return gamepad_button_check(global.control_type, global.pad_down);
        case global.LEFT:
            return gamepad_button_check(global.control_type, global.pad_left);
        case global.RIGHT:
            return gamepad_button_check(global.control_type, global.pad_right);
        case global.A:
            return gamepad_button_check(global.control_type, global.pad_a);
        case global.B:
            return gamepad_button_check(global.control_type, global.pad_b);
        case global.START:
            return gamepad_button_check(global.control_type, global.pad_start);
    }
}

return false;
