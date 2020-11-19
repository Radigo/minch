// Inits
self.crateSourceX = 9840;
self.crateSourceY = 176;

self.crateSpawnControlRoomX = 9888;
self.crateSpawnControlRoomY = 272;

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
