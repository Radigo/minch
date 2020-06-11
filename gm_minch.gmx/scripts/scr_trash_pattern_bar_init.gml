scr_trash_instance_init();

/*
 Creates 6 horizontal planes (3 on top, 3 on bottom) where bullets bounce
 Planes move vertically
 Spawns bullets from sides @45°
*/

// Trash
self.patternTickerLimit = 60;
self.MAX_HP = 1000;
self.hp = self.MAX_HP;
self.y = self.originY + 80;

// Moves
self.MOVE_STAY = "moveStay";
self.MOVE_JUMP = "moveJump";
self.MOVE_LAND = "moveLand";
self.currentMoveState = self.MOVE_STAY;

self.moveRangeLeft = self.originX + (obj_trash_conductor.LAYOUT_TILE_SIZE * 2);
self.moveRangeRight = self.originX + (obj_trash_conductor.LAYOUT_TILE_SIZE * 9);
self.moveTargetX = self.x;
self.lastMoveHp = self.hp;
self.nextMoveHp = self.lastMoveHp - ceil(self.lastMoveHp * 0.1);

// Deflectors
self.topRangeTop = self.originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 2);
self.topRangeBottom = self.originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 4);
self.topDeflectors = ds_list_create();

for (var i = 0; i < 3; i++) {
    var topDeflector = instance_create(self.x - 96 + (i * 96), (self.topRangeTop - 100), obj_bar_deflector);
    topDeflector.direction = -90;
    topDeflector.depth = self.depth - 1;
    ds_list_add(self.topDeflectors, topDeflector);
}

self.bottomRangeTop = self.originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 7);
self.bottomRangeBottom = self.originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 9);
self.bottomDeflectors = ds_list_create();

for (var i = 0; i < 3; i++) {
    var bottomDeflector = instance_create(self.x - 96 + (i * 96), (self.bottomRangeBottom + 100), obj_bar_deflector);
    bottomDeflector.direction = 90;
    topDeflector.depth = self.depth - 1;
    ds_list_add(self.bottomDeflectors, bottomDeflector);
}


// Spawners
self.SPAWNER_STATE_INIT = "spawnerInit";
self.SPAWNER_STATE_ACTIVE = "spawnerActive";
self.spawnerCurrentState = self.SPAWNER_STATE_INIT;

self.leftSpawner = instance_create(self.x, self.y, obj_trash_spawner);
self.rightSpawner = instance_create(self.x, self.y, obj_trash_spawner);

self.leftSpawnerX = self.originX + (obj_trash_conductor.LAYOUT_TILE_SIZE * 1);
self.rightSpawnerX = self.originX + (obj_trash_conductor.LAYOUT_TILE_SIZE * 10);

self.spawnerCenterY = self.originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 5.5);
self.spawnerTop = self.originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 4);
self.spawnerBottom = self.originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 7);

self.activeSpawner = 0;// shoot alernatively, 0 is left, 1 is right
