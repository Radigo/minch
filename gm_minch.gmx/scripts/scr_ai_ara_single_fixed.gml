if (self.patternTicker == 180)
{
    var angle = scr_aim_at_minch(self, 0, 0, 0);
    scr_bullet_shot(self.x, self.y, angle, 1.2, 0)
    self.patternTicker = floor(scr_get_moreorless(10, 10));
}
