if (self.currentPatternPhase == self.HEAD_FOCUS)
{
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
    }
}

// Apply Movement
x += self.moveSpeed * self.moveDirection;

if (self.currentPatternPhase == self.HEAD_RAM)
{
    scr_head_ram();
}

//Weapons
if (self.patternTicker = self.patternTickerLimit)
{
    if (self.headPatternFunnelIndex < 50)
    {
        self.currentPatternPhase = self.HEAD_FOCUS;
        //show_debug_message("shooting line: " + string(self.headPatternFunnelIndex));
        scr_funnel_shot(self.headPatternFunnelIndex, 50);
        self.headPatternFunnelIndex++;
        self.patternTickerLimit = 2;
    }
    else if (self.headPatternRamIndex < 4)
    {
        self.currentPatternPhase = self.HEAD_RAM;
        //show_debug_message("ram: " + string(self.headPatternRamIndex));
        scr_ram_side_shot(self.headPatternRamIndex);
        self.patternTickerLimit = 60;
    }
    else
    {
        show_debug_message("reset");
        self.headPatternFunnelIndex = 0;
        self.headPatternRamIndex = 0;
        self.patternTickerLimit = 10;
    }
    
    self.patternTicker = 0;
}
