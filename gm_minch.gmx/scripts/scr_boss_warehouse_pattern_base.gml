// Movement
if (self.targetSpeed > 0)// Acceleration
{
    if (self.moveSpeed < self.targetSpeed)
    {
        self.moveSpeed += 0.02;
    }
    else
    {
        self.targetSpeed = 0;
    }
}
else if (self.targetSpeed == 0)// Slow down
{
    if (self.moveSpeed > self.targetSpeed)
    {
        self.moveSpeed -= 0.03;
    }
    else
    {
        self.moveDirection = -self.moveDirection;
        self.targetSpeed = random(1) + 0.5;
    }
}

// Apply Movement
x += self.moveSpeed * self.moveDirection;

// Patterns
if (self.patternTicker = self.patternTickerLimit)
{
    if (self.baseRaflesiaIndex < 120)
    {
        scr_raflesia_shot(self.baseRaflesiaIndex);
        self.baseRaflesiaIndex++;
        self.patternTickerLimit = 1;
    }
    else if (self.baseFrontIndex < 20)
    {
        scr_front_round_cross_shot(self.baseFrontIndex);
        self.baseFrontIndex++;    
        self.patternTickerLimit = 6;
    }
    else
    {
        self.baseRaflesiaIndex = 0;
        self.baseFrontIndex = 0;
        self.patternTickerLimit = 10;
    }
    
    self.patternTicker = 0;
}
