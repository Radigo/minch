self.tickerLimit = 200;

if (self.ticker == self.tickerLimit)
{
    global.nextBGM = bgm_stop;
    global.bgmSequencing = global.bgmSequenceInstant;
    audio_stop_sound(global.currentBGM);
    scr_play_bgm();
        
    //scr_boom(self.explodingFrame.x, self.explodingFrame.y, 4, 92);
    //with (self.explodingFrame) instance_destroy();
    self.isDeathSequence = false;
    
    scr_switch_machine(10);
}
