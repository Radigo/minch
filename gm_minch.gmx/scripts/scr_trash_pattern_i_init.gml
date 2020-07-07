scr_trash_instance_init();

/*
 Creates spawner on room sides
 Spawners shoot alternatively
 Trash flies on top of room.
*/

// Trash
self.MAX_HP = 1000;
self.hp = self.MAX_HP;

// Moves
self.MOVE_IDLE = "moveIdle";
self.MOVE_SPAWN = "moveSpawn";
self.MOVE_FLY = "moveFly";
self.currentMove = self.MOVE_IDLE;

self.spawnDuration = 60;

self.centerX = self.originX + (obj_trash_conductor.LAYOUT_TILE_SIZE * 5.5);
self.centerY = self.originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 2.5);

self.ellipseRadiusH = (obj_trash_conductor.LAYOUT_TILE_SIZE * 3);
self.ellipseRadiusV = (obj_trash_conductor.LAYOUT_TILE_SIZE * 0.5);

self.angleH = pi * 1.5;// Starts centered horizontally
self.angleV = 0;// Starts centered vertically
self.rotationHSpeed = 0;
self.rotationHSpeedTarget = 0.012;
self.rotationVSpeed = 0;
self.rotationVSpeedTarget = 0.02;

// Spawners
self.spawnerTargetXMax = (obj_trash_conductor.LAYOUT_TILE_SIZE * 4.5);
self.spawnerTargetXMin = (obj_trash_conductor.LAYOUT_TILE_SIZE * 2.5);
self.spawnerTargetYTop = self.originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 1.5);
self.spawnerTargetYBottom = self.originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 9.5);

self.spawnerLeft = ds_list_create();
self.spawnerRight = ds_list_create();
self.numSpawnersBySide = 8;
for (var i = 0; i < self.numSpawnersBySide; i++) {
    var spawnerLeft = instance_create(self.x, self.y, obj_trash_spawner);
    ds_list_add(self.spawnerLeft, spawnerLeft);
    var spawnerRight = instance_create(self.x, self.y, obj_trash_spawner);
    ds_list_add(self.spawnerRight, spawnerRight);
}

// Patterns
self.spawnerSide = "right";// "right" or "left"
self.patternTickerLimit = 30;
self.streamNumBullets = 12;

self.angleSwayMax = 0;
self.angleSwaySpeed = 0;
self.angleSwayDirection = 1;// Multiplies
self.patternAngle = 0;
