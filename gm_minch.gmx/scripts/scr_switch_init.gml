// Floor switch init
// Basic that turns ON once and for all

// ID determine what it will activate (-1 means useless)
// ID must be set in creation code once instanciated on the map
self.action_id = -1;
self.actionList = ds_list_create();

// Can be used mutiple times
self.multipleUses = false;

// Init deactivated
self.active = false;
image_index = 2;
image_speed = 0;

self.sfx = argument0;
