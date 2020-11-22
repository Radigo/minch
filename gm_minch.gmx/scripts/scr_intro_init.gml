// Inits
scr_ai_init();

self.crateNum = 0;
self.crateId = 999;

// Intro settings
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
timeline_index = tl_intro;
timeline_speed = 1;
timeline_running = 1;
