// Check for crate to arrive at destination to end intro

if (self.x <= (obj_conveyor_dispenser.x - 15)) {
    room_goto(rm_lvl_11);
}

if (self.ticker > (self.skipStart + self.skipFadeDuration)) {
    self.skipMessageAlpha = 1;
} else if (self.ticker > self.skipStart) {
    // Fade skip message in
    self.skipMessageAlpha = (self.ticker - self.skipStart) / self.skipFadeDuration;
} else {
    self.skipMessageAlpha = 0;
}

if ((self.skipMessageAlpha > 0.5) && keyboard_check(global.key_start)) {
    // Skip !
    room_goto(rm_lvl_11);
}
