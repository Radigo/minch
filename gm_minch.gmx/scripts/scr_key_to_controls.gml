var isContinuous = argument0;

// If not continuous, we check only released inputs or keyboard last key
// If continuous, regular down/pressing input

if (scr_controls_check()) {
    if (isContinuous) {
        if (gamepad_button_check(global.controlType, global.pad_up)) {
            return global.UP;
        } else if (gamepad_button_check(global.controlType, global.pad_down)) {
            return global.DOWN;
        } else if (gamepad_button_check(global.controlType, global.pad_left)) {
            return global.LEFT;
        } else if (gamepad_button_check(global.controlType, global.pad_right)) {
            return global.RIGHT;
        } else if (gamepad_button_check(global.controlType, global.pad_a)) {
            return global.A;
        } else if (gamepad_button_check(global.controlType, global.pad_b)) {
            return global.B;
        } else if (gamepad_button_check(global.controlType, global.pad_start)) {
            return global.START;
        }
    } else {
        if (gamepad_button_check_released(global.controlType, global.pad_up)) {
            return global.UP;
        } else if (gamepad_button_check_released(global.controlType, global.pad_down)) {
            return global.DOWN;
        } else if (gamepad_button_check_released(global.controlType, global.pad_left)) {
            return global.LEFT;
        } else if (gamepad_button_check_released(global.controlType, global.pad_right)) {
            return global.RIGHT;
        } else if (gamepad_button_check_released(global.controlType, global.pad_a)) {
            return global.A;
        } else if (gamepad_button_check_released(global.controlType, global.pad_b)) {
            return global.B;
        } else if (gamepad_button_check_released(global.controlType, global.pad_start)) {
            return global.START;
        }
    }
} else {

get inputKey from keyboard or last key
    switch (inputKey) {
        case global.key_up:
            return global.UP;
        case global.key_down:
            return global.DOWN;
        case global.key_left:
            return global.LEFT;
        case global.key_right:
            return global.RIGHT;
        case global.key_a:
            return global.A;
        case global.key_b:
            return global.B;
        case global.key_start:
            return global.START;
    }
}

return false;
