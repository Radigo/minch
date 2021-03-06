scr_ai_init();

self.tickerLimit = (60 * 6);
self.hasFocus = false;

// If pattern has not started, decrease fader to 0 and set this to true
// If pattern has started, increase fader until patern starts for good
self.patternHasStarted = false;
self.patternFader = 0;

// Patterns
self.SHIELD_RANDOM = "random";// Boss moves randomly
self.SHIELD_FOCUS = "focus";// Boss focuses on player
self.HEAD_FOCUS = "headfocus";// Boss focuses on player
self.HEAD_RAM = "ram";// Head of boss detaches to ram player down
self.currentPatternPhase = self.SHIELD_RANDOM;

self.moveSpeed = 2;
self.targetSpeed = 10;
self.moveDirection = 1;

// Weapons
// Front weapon (index = sent patterns num, ticker = frame ticker)
self.sidesPatternLinesIndex = 0;
self.sidesPatternFireballsIndex = 0;
self.sidesPatternSpreadIndex = 0;

self.headPatternFunnelIndex = 0;
self.headPatternRamIndex = 0;

self.baseRaflesiaIndex = 0;
self.baseFrontIndex = 0;

// Init first pattern
self.patternTickerLimit = 50;

// Intro sequence
self.isIntroSequence = true;
// Death sequence
self.isDeathSequence = true;

// Parts
instance_create(self.x, self.y, obj_boss_warehouse_shield);
instance_create(self.x, self.y, obj_boss_warehouse_head);

for (i = 0; i < 12; i++)
{
    neck = instance_create(self.x, self.y, obj_boss_warehouse_neck);
    with (neck)
    {
        self.shield = true;
    }
}

instance_create(self.x, self.y, obj_boss_warehouse_base);

with (obj_boss_warehouse_base)
{
    self.shield = true;
}
