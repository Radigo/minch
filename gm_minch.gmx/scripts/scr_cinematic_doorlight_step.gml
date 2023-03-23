if (self.status == "inactive") {
    return false;
}

if (self.image_xscale <= 0) {
    audio_stop_sound(snd_gate_closing);
    scr_play_sound(snd_gate_closed, global.SFX_ENVIRONMENT, false);
    with (self) instance_destroy();
} else {
    if (self.image_xscale >= 5.5) {
        scr_play_sound(snd_gate_closing, global.SFX_ENVIRONMENT, true);
    }
    self.image_xscale = self.image_xscale - 0.05;
}
