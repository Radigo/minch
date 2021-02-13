var angle = 0;

if (self.patternTicker == 10)
{
    angle = scr_aim_at_minch(self, 0, -12, -12);
    if (scr_pattern_spread((self.x - 12), (self.y - 12), angle, 1, 1, 24, 300))
    {
        audio_play_sound(snd_bullet_shot, global.SFX_LOW_PRIORITY, false);
    }
}

if (self.patternTicker == 20)
{
    angle = scr_aim_at_minch(self, 0, 12, -12);
    if (scr_pattern_spread((self.x + 12), (self.y - 12), angle, 1.2, 1, 24, 300))
    {
        audio_play_sound(snd_bullet_shot, global.SFX_LOW_PRIORITY, false);
    }
}

if (self.patternTicker == 30)
{
    angle = scr_aim_at_minch(self, 0, -12, 12);
    if (scr_pattern_spread((self.x - 12), (self.y + 12), angle, 1.4, 1, 24, 300))
    {
        audio_play_sound(snd_bullet_shot, global.SFX_LOW_PRIORITY, false);
    }
}

if (self.patternTicker == 40)
{
    angle = scr_aim_at_minch(self, 0, 12, 12);
    if (scr_pattern_spread((self.x + 12), (self.y + 12), angle, 1.6, 1, 24, 300))
    {
        audio_play_sound(snd_bullet_shot, global.SFX_LOW_PRIORITY, false);
    }
}



if (self.patternTicker == 80)
{
    angle = scr_aim_at_minch(self, 0, 0, 0);
    scr_bullet_shot(self.x, self.y, angle, 2.6, 3);
    scr_bullet_shot(self.x, self.y, angle, 2.2, 2);
    scr_bullet_shot(self.x, self.y, angle, 1.8, 2);
    scr_bullet_shot(self.x, self.y, angle, 1.4, 2);
    if (scr_bullet_shot(self.x, self.y, angle, 1, 2))
    {
        audio_play_sound(snd_bullet_shot, 0, false);
    }
}

if (self.patternTicker == 200)
{
    if (scr_pattern_spread(self.x, self.y, -1, 2, 0, 8, 360))
    {
        audio_play_sound(snd_bullet_shot, 0, false);
    }
    self.patternTicker = 0;
}
