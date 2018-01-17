// straight lines of bullets
var numBulletsByLine = 12;
var patternDuration = self.shotDelay * numBulletsByLine;

if ((self.patternTicker % self.shotDelay) == 0)
{
    if (self.patternTicker <= (patternDuration))
    {
         self.spreadAngle = 0;
         self.patternIndex = 0;
    }
    else if (self.patternTicker <= (patternDuration * 2))
    {
         self.spreadAngle = 45;
         self.patternIndex = 1;
    }
    else if (self.patternTicker <= (patternDuration * 3))
    {
         if (self.patternIndex == 1)
         {
             self.spreadAngle = random(360);
         }
         self.patternIndex = 2;
    }
    else if (self.patternTicker <= (patternDuration * 4))
    {
         if (self.patternIndex == 2)
         {
             self.spreadAngle = random(360);
         }
         self.patternIndex = 3;
    }
    else
    {
        self.spreadAngle = 0;
        self.patternTicker = 0;
    }
    
    scr_pattern_spread(self.x, self.y,
                               self.spreadAngle,
                               2.5,
                               3,
                               self.numArms, (360 - (360 / self.numArms)));
}
