scr_ai_init();

self.parentCarrier = noone;

self.STATUS_CIRCLE = "circleFormation";
self.STATUS_KAMIKAZE = "kamikazeFormation";
// Inits in circle formation, moving around carrier
self.status = self.STATUS_CIRCLE;

self.circleCurrentDistance = 16;
self.circleDistance = 64;
self.distanceFriction = 0.1;
self.circleAngle = 0;
self.circleSpeed = 0.012;

// Shuffle movements
self.randomizerTicker = 0;
self.randomizerDuration = 60;
self.distanceRandomizerAmount = 10;
self.circleSpeedRandomizerAmount = 0.002;

// Kamikaze mode
self.xSpeed = 0;
self.ySpeed = 0;
self.kamikazeSpeed = 0;
self.kamikazeAngle = 0;
