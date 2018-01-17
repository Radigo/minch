scr_ai_init();

self.targetLossDistance = 136;// Losing target after exiting the zone

// Config
self.PATTERN_MODE_FREE = "freeMode";
self.PATTERN_MODE_FIXED = "fixedMode";

switch (irandom(1))
{
    default:
         self.patternMode = self.PATTERN_MODE_FREE;
         self.numArms = 6;
self.shotDelay = 30;
         break;
    case 1:
         self.patternMode = self.PATTERN_MODE_FIXED;
         self.numArms = 4;
         self.shotDelay = 16;
         self.patternIndex = 0;
         break;
}

// RealTime vars
self.rotateSpeed = 0;
self.spreadAngle = 0;
self.prevAimAngle = 0;
self.aimAngle = 0;
