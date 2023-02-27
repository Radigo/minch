var deathDuration = 120;
if (self.ticker < deathDuration) {
    self.y -= (1 - (self.ticker / deathDuration)) * 1;
    
    if ((self.ticker % 12) == 0) {
        scr_boom(scr_get_moreorless(self.x, 16), scr_get_moreorless(self.y, 16), 1, 8);
    }
} else {
    global.nextBGM = bgm_stop;
    global.bgmSequencing = global.BGM_SEQUENCE_INSTANT;
    audio_stop_sound(global.currentBGM);
    scr_play_bgm();
    
    scr_boom(self.x, self.y, 4, 24);
    with (self)
        instance_destroy();
}

self.ticker++;
