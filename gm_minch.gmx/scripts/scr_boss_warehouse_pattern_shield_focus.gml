show_debug_message(string(self.x - obj_minch.x));

if ((self.x - obj_minch.x) > 8)
{
    self.moveDirection = -1;
    self.moveSpeed = 1;
}
else if ((self.x - obj_minch.x) < -8)
{
    self.moveDirection = 1;
    self.moveSpeed = 1;
}
else
{
    self.moveSpeed = 0;
    self.patterTicker = self.patternTickerLimit + 1;
}

// Apply Movement
x += self.moveSpeed * self.moveDirection;

// Shoot
if (self.patternTicker > self.patternTickerLimit)
{
    origin_angle = 0;
    origin_x = 0;
    origin_y = 0;
    
    for (i = 0; i < 12; i++)
    {
        origin_angle = random(pi * 2);
        origin_x = cos(origin_angle) * random(16);
        origin_y = sin(origin_angle) * random(16);
        scr_bullet_shot((self.x + origin_x), (self.y + origin_y), scr_get_moreorless(-90, 2), (4 + random(2)), 5);
    }
    
    self.patternTicker = 0;
    self.currentPatternPhase = self.SHIELD_RANDOM;
    return 0;
}
