scr_ai_init();

self.tickerLimit = 0;
self.hasFocus = false;

// If pattern has not started, decrease fader to 0 and set this to true
// If pattern has started, increase fader until patern starts for good
self.patternHasStarted = false;
self.patternFader = 0;

// Patterns
self.shieldPatternMoveSpeed = 2;
// Weapons

// Intro sequence
self.isIntroSequence = true;
// Death sequence
self.isDeathSequence = true;

// Parts
instance_create(self.x, self.y, obj_boss_warehouse_shield);
instance_create(self.x, self.y, obj_boss_warehouse_head);
instance_create(self.x, self.y, obj_boss_warehouse_base);

with (obj_boss_warehouse_base)
{
    self.shield = true;
}
