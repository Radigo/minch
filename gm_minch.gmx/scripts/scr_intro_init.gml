// Inits
scr_ai_init();

self.crateNum = 0;
self.crateId = 999;

// Intro settings
self.fadeInDuration = 90;

self.crateSourceX = 4064;
self.crateSourceY = 560;

self.crateSpawnControlRoomX = 3984;
self.crateSpawnControlRoomY = 464;

self.crateSpawnSectionOneX = 3504;
self.crateSpawnSectionOneY = 912;

self.crateSpawnSectionTwoX = 3152;
self.crateSpawnSectionTwoY = 464;

self.crateSpawnUpperLoopX = 2992;
self.crateSpawnUpperLoopY = 464;

self.crateSpawnLowerLoopX = 3184;
self.crateSpawnLowerLoopY = 912;

self.skipStart = 250;
self.skipFadeDuration = 80;
self.skipMessageAlpha = 0;

// Set default view
var main_view_index = 0;

view_wview[main_view_index] = 320;
view_hview[main_view_index] = 240;
view_wport[main_view_index] = 320;
view_hport[main_view_index] = 240;

view_hborder[main_view_index] = 160;
view_vborder[main_view_index] = 160;

view_object[main_view_index] = obj_dummy;

view_visible[main_view_index] = true;
view_enabled[main_view_index] = true;

// Launch cinematic
self.timeline_index = tl_intro;
self.timeline_speed = 1;
self.timeline_running = 1;
