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
    scr_head_shot();
    
    self.patternTicker = 0;
    self.currentPatternPhase = self.SHIELD_RANDOM;
    return 0;
}
