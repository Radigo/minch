if (self.ticker > self.tickerLimit)
{
    self.ticker = 0;
}

if (self.patternTicker > self.patternTickerLimit)
{
    self.patternTicker = 0;
}

self.ticker++;
self.patternTicker++;
