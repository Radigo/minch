scr_trash_instance_init();

/*
 Creates pairs of spawners that slides vertically on room sides
 Spawner goes back and forth shooting horizontally
 Trash moves by small leaps, every N leap he punches down
 Punch pushes bullets down
*/

self.MAX_HP = 1000;
self.hp = self.MAX_HP;

// Moves
self.MOVE_JUMP = "moveJump";
self.MOVE_LAND = "moveLand";
self.MOVE_PUNCH = "movePunch";

self.sourceX = self.x;
self.targetX = self.x;
self.sourceY = self.y;
self.targetY = self.y;

self.jumpDuration = 16;
self.jumpDurationVar = 40;
self.landDuration = 8;
self.numJumpsBeforePunch = 3;
self.punchDuration = 30;
self.punchDurationVar = 20;

self.currentMove = self.MOVE_JUMP;
self.tickerLimit = self.jumpDuration;

self.moveRangeLeft = self.originX + (obj_trash_conductor.LAYOUT_TILE_SIZE * 1.5);
self.moveRangeRight = self.originX + (obj_trash_conductor.LAYOUT_TILE_SIZE * 9.5);
self.moveRangeTop = self.originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 2.5);
self.moveRangeBottom = self.originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 5);

// Spawners
self.spawnerLeft = self.originX + (obj_trash_conductor.LAYOUT_TILE_SIZE * 1);
self.spawnerRight = self.originX + (obj_trash_conductor.LAYOUT_TILE_SIZE * 10);
self.spawnerTop = self.originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 2);
self.spawnerBottom = self.originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 9);

self.spawnerList = ds_list_create();
self.spawnerTickers = ds_list_create();
self.spawnerShotStreamDuration = ds_list_create();
self.spawnerShotAngle = ds_list_create();

self.numSpawnerPerSide = 3;
var vSpacing = abs(self.spawnerBottom - self.spawnerTop) / self.numSpawnerPerSide;

for (var i = 0; i < (self.numSpawnerPerSide * 2); i++) {
    var spawner = instance_create(self.x, self.y, obj_trash_spawner);
    spawner.direction = 90;
    if (random(1) > 0.5) {
        spawner.direction = -90;
    }
    var shotAngle = 0;
    if (spawner.x > self.x) {
        shotAngle = 180;
    }
    
    ds_list_add(self.spawnerList, spawner);
    ds_list_add(self.spawnerTickers, 200);
    ds_list_add(self.spawnerShotStreamDuration, 0);
    ds_list_add(self.spawnerShotAngle, shotAngle);
}
