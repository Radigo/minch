if (self.ticker > self.tickerLimit)
{
    self.ticker = 0;
}

if (self.patternTicker > self.patternTickerLimit)
{
    self.patternTicker = 0;
}

if (self.lastHitTicker >= 0)
{
    self.lastHitTicker++;
    if (self.lastHitTicker > 10)
        self.lastHitTicker = -1;
}

self.ticker++;
self.patternTicker++;
