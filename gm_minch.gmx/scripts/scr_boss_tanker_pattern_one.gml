/**
First pattern of Tanker

1. With 2 protections:
    A. Alternate shots
    B. Light aimed shots
    E. Hard rotary spread when MinCH goes behind boss

*/

var move_speed = (1 / self.tickerLimit) * (2 * pi);
var move_range_h = 52;
var move_range_v = 16;

self.tickerLimit = 600;
var patternFaderLimit = 120;

self.canonPatternLimit = 200;
self.ballsPatternLimit = 240;

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
if (self.patternFader > 0)
{
    self.x = self.initX + cos(self.ticker * move_speed) * (move_range_h * (self.patternFader / patternFaderLimit));
    self.y = self.initY + cos(self.ticker * move_speed * 2) * (move_range_v * (self.patternFader / patternFaderLimit));
}
else
{
    self.x = self.initX;
    self.y = self.initY;
}

// Attacks
// Canons
if (self.canonPatternTicker == 100)
{
    scr_arm_canon_shot(1, "left");
}
else if (self.canonPatternTicker == 200)
{
    scr_arm_canon_shot(1, "right");
}

if (self.canonPatternTicker > self.canonPatternLimit)
{
    self.canonPatternTicker = 0;
}

self.canonPatternTicker++;

// Balls
if (self.ballsPatternTicker == 120)
{
    scr_balls_shot(1);
}

if (self.ballsPatternTicker > self.ballsPatternLimit)
{
    self.ballsPatternTicker = 0;
}

self.ballsPatternTicker++;
