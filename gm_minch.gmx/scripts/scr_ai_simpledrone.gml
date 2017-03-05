self.ticker++;

if (self.patternTicker == 120)
{
    var aimed_angle = scr_aim_at_minch(self, 0, 0, 0);
    scr_bullet_shot(self.x, self.y, aimed_angle, 1, 0);
    self.patternTicker = round(random(10));
}
