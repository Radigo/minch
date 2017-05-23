self.tickerLimit = 200;

if (self.ticker == self.tickerLimit)
{
    self.isIntroSequence = false;
    
    self.ticker = 0;
    self.patternTicker = 0;
    
    obj_boss_warehouse_shield.shield = false;
    return false;
}
else
{
    //show_debug_message("intro: " + string(self.ticker));
    // Move to center
    self.x += 3 * (1 - (self.ticker / self.tickerLimit));
}
