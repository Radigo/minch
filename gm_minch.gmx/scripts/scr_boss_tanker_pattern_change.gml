if (!instance_exists(obj_boss_tanker_left)
    && instance_exists(obj_boss_tanker_right))
{
    obj_boss_tanker_right.hp += 500;
}
else if (instance_exists(obj_boss_tanker_left)
    && !instance_exists(obj_boss_tanker_right))
{
    obj_boss_tanker_left.hp += 500;
}

with (obj_boss_tanker)
{
    self.patternHasStarted = false
    self.canonPatternTicker = 0;
    self.ballsPatternTicker = 0;
    self.frontPatternTicker = 0;
    self.ticker = 0;
}
