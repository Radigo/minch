if (global.control_type < 0) {
    return scr_text("keyboard");
} else {
    return gamepad_get_description(global.control_type);
}
