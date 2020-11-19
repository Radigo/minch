if (self.ticker > self.tickerLimit) {
    self.ticker = 0;
}

if (self.patternTicker > self.patternTickerLimit) {
    self.patternTicker = 0;
}

if (self.lastHitTicker >= 0) {
    self.lastHitTicker++;
    if (self.lastHitTicker > 10)
        self.lastHitTicker = -1;
}

self.ticker++;
self.patternTicker++;

// Conveyor influence
if (self.followConveyors) {
    x += self.conveyorMoveX;
    y += self.conveyorMoveY;
}

self.conveyorMoveX = 0;
self.conveyorMoveY = 0;
