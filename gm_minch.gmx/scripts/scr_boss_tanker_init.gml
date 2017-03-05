scr_ai_init();

self.hasFocus = false;

// If pattern has not started, decrease fader to 0 and set this to true
// If pattern has started, increase fader until patern starts for good
self.patternHasStarted = false;
self.patternFader = 0;

// Canons
self.canonPatternLimit = 200;
self.canonPatternTicker = 0;
// 4 Balls
self.ballsPatternLimit = 240;
self.ballsPatternTicker = 0;
// Front weapon
self.frontPatternLimit = 100;
self.frontPatternTicker = 0;

// Intro sequence
self.isIntroSequence = true;

// Pattern 3 movements
self.targetX = self.initX;
self.targetY = self.initY;

// Death sequence
self.isDeathSequence = true;

// Parts
instance_create(self.x, self.y, obj_boss_tanker_left);
instance_create(self.x, self.y, obj_boss_tanker_right);
instance_create(self.x, self.y, obj_boss_tanker_base);

// Start invincible
obj_boss_tanker_base.shield = true;
obj_boss_tanker_left.shield = true;
obj_boss_tanker_right.shield = true;
