/**
Second pattern of Tanker
Either left or right part is opened

2. With 1 protection left:
    A. Alternate shots, the broken protection side shots harder
    B. Medium aimed shots
    C. Medium spread
    D. Medium aimed spread
    E. Hard rotary spread when MinCH goes behind boss

*/

var side = argument0;// "left" or "right"

var move_speed = (1 / self.tickerLimit) * (2 * pi);
var move_range_h = 64;
var move_range_v = 24;

self.tickerLimit = 400;
var patternFaderLimit = 100;

self.canonPatternLimit = 200;
self.ballsPatternLimit = 200;
self.frontPatternLimit = 120;

// Pattern fader
if (patternHasStarted)
{
    if (self.patternFader < patternFaderLimit)
    {
        self.patternFader++;
    }
}
else
{
    if (self.patternFader > 0)
    {
        self.patternFader--;
    }
    else
    {
        self.patternHasStarted = true;
    }
}

// Movements
if (self.patternHasStarted
    && (self.patternFader > 0))
{
    self.x = self.initX + cos(self.ticker * move_speed) * (move_range_h * (self.patternFader / patternFaderLimit));
    self.y = self.initY + sin(self.ticker * move_speed) * (move_range_v * (self.patternFader / patternFaderLimit));
}
else
{
    self.x = self.initX + ((self.x - self.initX) * 0.9);
    self.y = self.initY + ((self.y - self.initY) * 0.9);
}

// Attacks
// Canons
if (self.canonPatternTicker == 100)
{
    scr_arm_canon_shot(2, "left");
}
else if (self.canonPatternTicker == 200)
{
    scr_arm_canon_shot(2, "right");
}

if (self.canonPatternTicker > self.canonPatternLimit)
{
    self.canonPatternTicker = 0;
}

self.canonPatternTicker++;

// Balls
if (self.ballsPatternTicker == 100)
{
    scr_balls_shot(2);
}

if (self.ballsPatternTicker > self.ballsPatternLimit)
{
    self.ballsPatternTicker = 0;
}

self.ballsPatternTicker++;

// Front
if ((self.frontPatternTicker % 10) == 0)
{
    scr_front_shot(2, side);
}

if (self.frontPatternTicker > self.frontPatternLimit)
{
    self.frontPatternTicker = 0;
}

self.frontPatternTicker++;
