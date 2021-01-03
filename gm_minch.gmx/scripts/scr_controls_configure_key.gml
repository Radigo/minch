var controlKey = argument0;
var inputKey = argument1;

if (scr_controls_gamepad_check(global.control_type)) {
    switch (controlKey) {
        case global.UP:
            show_debug_message("scr_controls_configure_key " + string(global.pad_up) + " = " + string(inputKey));
            global.pad_up = inputKey;
            break;
        case global.DOWN:
            show_debug_message("scr_controls_configure_key " + string(global.pad_down) + " = " + string(inputKey));
            global.pad_down = inputKey;
            break;
        case global.LEFT:
            show_debug_message("scr_controls_configure_key " + string(global.pad_left) + " = " + string(inputKey));
            global.pad_left = inputKey;
            break;
        case global.RIGHT:
            show_debug_message("scr_controls_configure_key " + string(global.pad_right) + " = " + string(inputKey));
            global.pad_right = inputKey;
            break;
        case global.A:
            show_debug_message("scr_controls_configure_key " + string(global.pad_a) + " = " + string(inputKey));
            global.pad_a = inputKey;
            break;
        case global.B:
            show_debug_message("scr_controls_configure_key " + string(global.pad_b) + " = " + string(inputKey));
            global.pad_b = inputKey;
            break;
        case global.C:
            show_debug_message("scr_controls_configure_key " + string(global.pad_c) + " = " + string(inputKey));
            global.pad_c = inputKey;
            break;
        case global.START:
            show_debug_message("scr_controls_configure_key " + string(global.pad_start) + " = " + string(inputKey));
            global.pad_start = inputKey;
            break;
    }
} else if (global.control_type < 0) {
    switch (controlKey) {
        case global.UP:
            show_debug_message("scr_controls_configure_key " + string(global.key_up) + " = " + string(inputKey));
            global.key_up = inputKey;
            break;
        case global.DOWN:
            show_debug_message("scr_controls_configure_key " + string(global.key_down) + " = " + string(inputKey));
            global.key_down = inputKey;
            break;
        case global.LEFT:
            show_debug_message("scr_controls_configure_key " + string(global.key_left) + " = " + string(inputKey));
            global.key_left = inputKey;
            break;
        case global.RIGHT:
            show_debug_message("scr_controls_configure_key " + string(global.key_right) + " = " + string(inputKey));
            global.key_right = inputKey;
            break;
        case global.A:
            show_debug_message("scr_controls_configure_key " + string(global.key_a) + " = " + string(inputKey));
            global.key_a = inputKey;
            break;
        case global.B:
            show_debug_message("scr_controls_configure_key " + string(global.key_b) + " = " + string(inputKey));
            global.key_b = inputKey;
            break;
        case global.C:
            show_debug_message("scr_controls_configure_key " + string(global.key_c) + " = " + string(inputKey));
            global.key_c = inputKey;
            break;
        case global.START:
            show_debug_message("scr_controls_configure_key " + string(global.key_start) + " = " + string(inputKey));
            global.key_start = inputKey;
            break;
    }
} else {
    show_debug_message("error configuring key");
}
