self.tickerLimit = 200;

var first_booms_limit, second_booms_limit;

first_booms_limit = 60;
second_booms_limit = 160;

var i, boom_x, boom_y, level, size;

if (self.ticker == 1)
{
    self.explodingFrame = instance_create(self.x, self.y, obj_boss_tanker_frame);
    with (self.explodingFrame) depth = 0;
    scr_all_bullet_cancel();
}
else if ((self.ticker < first_booms_limit)
    && ((self.ticker % 5) == 0))
{
    self.explodingFrame.x += random(2) - 1;
    self.explodingFrame.y += random(2) - 1;
    
    boom_x = (random(96) - 48) + self.explodingFrame.x;
    boom_y = self.explodingFrame.y - ((self.ticker / first_booms_limit) * 128) + 64;
    scr_boom(boom_x, boom_y, 1, 16);
}
else if (self.ticker < second_booms_limit)
{
    self.explodingFrame.x += random(2) - 1;
    self.explodingFrame.y += random(2) - 1;
    
    if ((self.ticker % 20) == 0)
    {
        boom_x = (random(96) - 48) + self.explodingFrame.x;
        boom_y = (random(96) - 48) + self.explodingFrame.y;
        scr_boom(boom_x, boom_y, 3, 24);
    }
}
else if (self.ticker == second_booms_limit)
{
    for (i = 0; i < 8; i++)
    {
        boom_x = (random(96) - 48) + self.explodingFrame.x;
        boom_y = (random(96) - 48) + self.explodingFrame.y;
        scr_boom(boom_x, boom_y, 3, 24);
    }
}
else if (self.ticker == self.tickerLimit)
{
    global.nextBGM = bgm_stop;
    global.bgmSequencing = global.BGM_SEQUENCE_INSTANT;
    audio_stop_sound(global.currentBGM);
    scr_play_bgm();
        
    scr_boom(self.explodingFrame.x, self.explodingFrame.y, 4, 92);
    with (self.explodingFrame) instance_destroy();
    self.isDeathSequence = false;
}
