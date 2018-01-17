// free rotate like crazy
if ((self.patternTicker % self.shotDelay) == 0)
{
    if (self.patternTicker < 500)
    {
        self.rotateSpeed += 1;
    }
    else if (self.patternTicker < 700)
    {
        // Still
    }
    else if (self.spreadAngle > 0)
    {
        self.rotateSpeed -= 1;
    }
    else
    {
        self.spreadAngle = 0;
        self.rotateSpeed = 0;
        self.patternTicker = 0;
    }
    
    self.spreadAngle += self.rotateSpeed;
    
    scr_pattern_spread(self.x, self.y,
                               self.spreadAngle,
                               1.2 + (self.rotateSpeed * 0.02),
                               3,
                               self.numArms, (360 - (360 / self.numArms)));
}
