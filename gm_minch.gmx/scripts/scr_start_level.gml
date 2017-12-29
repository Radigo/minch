// Inits everything a level needs
show_debug_message("Starting Level");

// init actions and rules map for switchs, doors and dynamic stuff
global.actions_map = ds_map_create();
global.rules_map = ds_map_create();

// init event map for all kind of trigger events
global.events = ds_map_create();

// Init checkpoints
global.lastCheckpoint = 0;

scr_scoring_init();

// Prepare kill counter
global.ennemyKilled = ds_map_create();
ds_map_add(global.ennemyKilled, 0, 0);// Colorless enemies (debug)
ds_map_add(global.ennemyKilled, global.CY, 0);
ds_map_add(global.ennemyKilled, global.MA, 0);
ds_map_add(global.ennemyKilled, global.YE, 0);
ds_map_add(global.ennemyKilled, global.PU, 0);
ds_map_add(global.ennemyKilled, global.GR, 0);
ds_map_add(global.ennemyKilled, global.RG, 0);
ds_map_add(global.ennemyKilled, global.BR, 0);
ds_map_add(global.ennemyKilled, global.BK, 0);

// Particles
scr_particles_init();

// Create player
instance_create(x, y, obj_minch);

// Display HUD
instance_create(0, 0, obj_hud);
obj_hud.depth = -999999;

// Display level intro
instance_create(0, 0, obj_level_intro);

// Create jukebox to manage BGM
global.currentBGM = noone;
instance_create(0,0, obj_jukebox);

// Set default view
var main_view_index = 0;

view_wview[main_view_index] = 320;
view_hview[main_view_index] = 240;
view_wport[main_view_index] = 320;
view_hport[main_view_index] = 240;

view_hborder[main_view_index] = 160;
view_vborder[main_view_index] = 160;

view_object[main_view_index] = obj_minch_camera;

view_visible[main_view_index] = true;
view_enabled[main_view_index] = true;
