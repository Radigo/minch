// Level end report sequence init

// Sequence vars
self.completeTime = 40;// Time when the "complete" label appears
self.scoreTime = 100;// Time when the score appears
self.fadeTime = 160;// Time when the fade start
self.faderDuration = 300;// Fade to black

self.reportTicker = 0;// Global ticker

self.faderAlpha = 1;
self.depth = -100000;

// Gameplay
scr_all_bullet_cancel();

// MinCH
global.invincible = true;
global.minchControlIsActive = false;

global.legsStatus = global.LEGS_IDLE;
global.bodyStatus = global.BODY_IDLE;
