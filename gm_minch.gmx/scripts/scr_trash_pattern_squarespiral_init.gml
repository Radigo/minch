scr_trash_instance_init();

/*
 Hover at room center
 Spawns garbage and spawners in circles that spiral down to the center
*/

self.MAX_HP = 1000;
self.hp = self.MAX_HP;

// Moves
self.centerX = self.originX + (obj_trash_conductor.LAYOUT_TILE_SIZE * 5.5);
self.centerY = self.originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 5.5);
self.isMoving = true;

// Patterns
self.deflectors = ds_list_create();

self.patternTickerLimit = 240;// Delay betwen 2 rings
self.numRingElements = 8;
self.lastRingRotationSpeed = 0;
