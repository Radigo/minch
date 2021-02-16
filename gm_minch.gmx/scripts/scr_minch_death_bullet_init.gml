// Receive taht from death script
self.shotAngle = 0;
self.shotSpeed = -1;

// General
var distanceMin = 16;
var distanceMax = 64;
var durationMin = 40;
var durationMax = 70;

self.parts = ds_list_create();
self.partsDirection = ds_list_create();
self.partsDistance = ds_list_create();
ds_list_add(self.partsDistance, random_range(distanceMin, distanceMax), random_range(distanceMin, distanceMax), random_range(distanceMin, distanceMax), random_range(distanceMin, distanceMax), random_range(distanceMin, distanceMax));
self.partsTicker = ds_list_create();
ds_list_add(self.partsTicker, 0, 0, 0, 0, 0);
self.partsDuration = ds_list_create();
ds_list_add(self.partsDuration, irandom_range(durationMin, durationMax), irandom_range(durationMin, durationMax), irandom_range(durationMin, durationMax), irandom_range(durationMin, durationMax), irandom_range(durationMin, durationMax));

// Display
self.image_speed = 0.25;

scr_play_sound(snd_death, global.SFX_MINCH_CONTROLS, false);
