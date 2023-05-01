// Check for crate to arrive at destination to end intro

if (self.x <= (obj_conveyor_dispenser.x - 15)) {
    global.currentRoom = rm_lvl_11;
    room_goto(global.currentRoom);
}

if (self.ticker > (self.skipStart + self.skipFadeDuration)) {
    self.skipMessageAlpha = 1;
} else if (self.ticker > self.skipStart) {
    // Fade skip message in
    self.skipMessageAlpha = (self.ticker - self.skipStart) / self.skipFadeDuration;
} else {
    self.skipMessageAlpha = 0;
}

if ((self.skipMessageAlpha > 0.5) && (keyboard_check(global.key_start) || gamepad_button_check_pressed(global.control_type, global.pad_start))) {
    // Skip !
    audio_sound_gain(bgm_intro, 0, 2000);
    global.currentRoom = rm_lvl_11;
    room_goto(global.currentRoom);
}
