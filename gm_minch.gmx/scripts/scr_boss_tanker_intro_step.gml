self.tickerLimit = 200;

if (self.ticker == self.tickerLimit)
{
    self.isIntroSequence = false;
    
    self.ticker = 0;
    self.patternTicker = 0;
    
    obj_boss_tanker_base.shield = false;
    obj_boss_tanker_left.shield = false;
    obj_boss_tanker_right.shield = false;
}
