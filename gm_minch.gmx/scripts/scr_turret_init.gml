scr_ai_init();

self.targetLossDistance = 136;// Losing target after exiting the zone

// Config
self.PATTERN_MODE_FREE = "freeMode";
self.PATTERN_MODE_FIXED = "fixedMode";

if (random(100) < 50)
{
     self.patternMode = self.PATTERN_MODE_FREE;
     self.numArms = 6;
     self.shotDelay = 30;
} else {
     self.patternMode = self.PATTERN_MODE_FIXED;
     self.numArms = 4;
     self.shotDelay = 16;
     self.patternIndex = 0;
}

// RealTime vars
self.rotateSpeed = 0;
self.spreadAngle = 0;
self.prevAimAngle = 0;
self.aimAngle = 0;
