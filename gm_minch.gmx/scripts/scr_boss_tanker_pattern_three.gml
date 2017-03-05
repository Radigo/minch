/**
Last pattern of tanker (can be skipped)

3. With no protections left:
    A. Simultaneous shots
    B. Hard aimed shots
    C. Medium spread
    D. Medium aimed spread
    E. Hard rotary spread when MinCH goes behind boss & Hard rotary pattern

*/

self.tickerLimit = 100;
var patternFaderLimit = 180;

self.canonPatternLimit = 120;
self.ballsPatternLimit = 400;
self.frontPatternLimit = 400;

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

if (self.ticker = 10)
{
    self.targetX = self.initX + random(72) - 32;
    self.targetY = self.initY - random(86);
}

if (self.patternHasStarted
    && (self.patternFader > 0))
{
    self.x = self.targetX + ((self.x - self.targetX) * 0.95);
    self.y = self.targetY + ((self.y - self.targetY) * 0.95);
}

// Attacks
// Canons
if (self.canonPatternTicker == 100)
{
    scr_arm_canon_shot(3, "left");
    scr_arm_canon_shot(3, "right");
}

if (self.canonPatternTicker > self.canonPatternLimit)
{
    self.canonPatternTicker = 0;
}

self.canonPatternTicker++;

// Balls
if ((self.ballsPatternTicker > 200)
    && (self.ballsPatternTicker < 240)
    && (self.ballsPatternTicker % 10) == 0)
{
    scr_balls_shot(3);
}

if (self.ballsPatternTicker > self.ballsPatternLimit)
{
    self.ballsPatternTicker = 0;
}

self.ballsPatternTicker++;

// Front
if ((self.frontPatternTicker < 30)
    && (self.frontPatternTicker % 3) == 0)
{
    scr_front_shot(3, "left");
    scr_front_shot(3, "right");
}

if (self.frontPatternTicker > self.frontPatternLimit)
{
    self.frontPatternTicker = 0;
}

self.frontPatternTicker++;
