var angle = 0;

if (self.patternTicker == 100)
{
    angle = scr_aim_at_minch(self, 0, -8, 0);
    scr_pattern_spread((self.x - 8), self.y, angle, 2, 0, 2, 40);
}

if (self.patternTicker == 120)
{
    angle = scr_aim_at_minch(self, 0, 8, 0);
    scr_pattern_spread((self.x + 8), self.y, angle, 1.5, 0, 3, 60);
    self.patternTicker = 0;
}
