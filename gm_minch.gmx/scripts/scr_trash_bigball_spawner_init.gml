// Logic
self.ticker = 0;
self.growthDuration = 50;// Growth duration

self.travelSpeed = 0.5;

// Visual
self.BALL_RADIUS = 16;
self.targetScale = 1;
self.image_xscale = 0;
self.image_yscale = 0;

// Only one at a time to avoid overlaps
audio_stop_sound(snd_trash_charge);
scr_play_sound(snd_trash_charge, global.SFX_ENVIRONMENT, false);
