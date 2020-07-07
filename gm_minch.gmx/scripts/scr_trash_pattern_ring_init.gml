scr_trash_instance_init();
/*
Trash sits on a pile of crates, spreading circularpatterns
Big balls travel in the alleys in circle
*/


self.MAX_HP = 2000;
self.hp = self.MAX_HP;

self.centerX = self.originX + (obj_trash_conductor.LAYOUT_TILE_SIZE * 5.5);
self.centerY = self.originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 5.5);

// Patterns
self.numStreams = 4;
self.rotationAngle = 45;
self.rotationSpeed = 0;
self.targetRotationSpeed = 0;
self.patternTickerLimit = 300;

// Big balls
self.balls = ds_list_create();
self.numBalls = 0;
self.ballHRadius = (obj_trash_conductor.LAYOUT_TILE_SIZE * 3.75);
self.ballVRadius = (obj_trash_conductor.LAYOUT_TILE_SIZE * 2.75);
