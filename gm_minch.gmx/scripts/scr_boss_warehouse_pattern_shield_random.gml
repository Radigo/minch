// Movement
if (self.targetSpeed > 0)// Acceleration
{
    if (self.moveSpeed < self.targetSpeed)
    {
        self.moveSpeed += 0.01;
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
//show_debug_message(string(self.ticker) + "/" + string(self.tickerLimit));

if (self.ticker == self.tickerLimit)
{
    self.patternTicker = 0;
    self.patternTickerLimit = 80;
    self.tickerLimit = (60 * 3) + floor(random(60 * 10));
    if (instance_exists(obj_boss_warehouse_head))
    {
        self.currentPatternPhase = self.SHIELD_FOCUS;
    }
    return 0;
}

if (self.patternTicker = self.patternTickerLimit)
{
    if (self.sidesPatternLinesIndex < 5)
    {
        //show_debug_message("shooting line: " + string(self.sidesPatternLinesIndex));
        scr_sides_lines_shot(self.sidesPatternLinesIndex);
        self.sidesPatternLinesIndex++;
        self.patternTickerLimit = 24;
    }
    else if (self.sidesPatternFireballsIndex < 2)
    {
        //show_debug_message("shooting fireballs: " + string(self.sidesPatternFireballsIndex));
        scr_fireballs_shots(self.sidesPatternFireballsIndex);
        self.sidesPatternFireballsIndex++;    
        self.patternTickerLimit = 100;
    }
    else if (self.sidesPatternSpreadIndex < 120)
    {
        //show_debug_message("shooting spread: " + string(self.sidesPatternSpreadIndex));
        scr_spread_shot(self.sidesPatternSpreadIndex);
        self.sidesPatternSpreadIndex++;
        self.patternTickerLimit = 2;
    }
    else
    {
        self.sidesPatternLinesIndex = 0;
        self.sidesPatternFireballsIndex = 0;
        self.sidesPatternSpreadIndex = 0;
        self.patternTickerLimit = 60;
    }
    
    self.patternTicker = 0;
}
