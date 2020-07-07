scr_trash_instance_init();
/*
Trash fly in circle around the room, shooting towards MinCH
Large bullets (path width) will spawn and travel slowly alongth paths
*/


self.MAX_HP = 1000;
self.hp = self.MAX_HP;

// Moves
self.MOVE_JUMP = "moveJump";
self.MOVE_FLY = "moveFly";
self.currentMove = self.MOVE_JUMP;

self.centerX = self.originX + (obj_trash_conductor.LAYOUT_TILE_SIZE * 5.5);
self.centerY = self.originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 5.5);

self.ellipseRadiusH = (obj_trash_conductor.LAYOUT_TILE_SIZE * 4.5);
self.ellipseRadiusV = (obj_trash_conductor.LAYOUT_TILE_SIZE * 3.5);

self.angle = pi * 1.5;// Starts north
self.rotationSpeed = 0;
self.rotationSpeedTarget = 0.005;

// Shots

