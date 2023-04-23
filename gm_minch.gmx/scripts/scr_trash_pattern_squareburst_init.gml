scr_trash_instance_init();

/*
 Creates Spawners in corners
 Spawners shoot straight lines to form a web
 Trash jumps and pushes bullets when landing
*/

self.MAX_HP = 1000;
self.hp = self.MAX_HP;

// Moves
self.MOVE_JUMP = "moveJump";
self.MOVE_LAND = "moveLand";

self.sourceX = self.x;
self.targetX = self.x;
self.sourceY = self.y;
self.targetY = self.y;

self.jumpDuration = 60;// Min duration
self.jumpDurationVar = 120;
self.landDuration = 90;// Min duration
self.landDurationVar = 90;
self.burstDuration = 60;

self.currentMove = self.MOVE_LAND;
self.tickerLimit = self.landDuration;
self.ticker = self.landDuration;

self.moveRangeLeft = self.originX + (obj_trash_conductor.LAYOUT_TILE_SIZE * 2.5);
self.moveRangeRight = self.originX + (obj_trash_conductor.LAYOUT_TILE_SIZE * 8.5);
self.moveRangeTop = self.originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 3.5);
self.moveRangeBottom = self.originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 7.5);

self.centerX = self.originX + (obj_trash_conductor.LAYOUT_TILE_SIZE * 5.5);
self.centerY = self.originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 5.5);

// Spawners
self.spawnerLeft = self.originX + (obj_trash_conductor.LAYOUT_TILE_SIZE * 1.5);
self.spawnerRight = self.originX + (obj_trash_conductor.LAYOUT_TILE_SIZE * 9.5);
self.spawnerTop = self.originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 2.5);
self.spawnerBottom = self.originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 8.5);

self.tlSpawner = instance_create(self.x, self.y, obj_trash_spawner);
self.trSpawner = instance_create(self.x, self.y, obj_trash_spawner);
self.blSpawner = instance_create(self.x, self.y, obj_trash_spawner);
self.brSpawner = instance_create(self.x, self.y, obj_trash_spawner);

var numStreamsPerSpawner = 2;
self.streamNumBullets = 10;
self.streamBulletsFrequency = 4;
self.streamDelay = 180;

self.tlTimers = ds_list_create();
self.tlAngles = ds_list_create();
for (var i = 0; i < numStreamsPerSpawner; i++) {
    var delay = (self.streamDelay + (self.streamNumBullets * self.streamBulletsFrequency)) * (i / numStreamsPerSpawner);
    ds_list_add(self.tlTimers, delay);
    ds_list_add(self.tlAngles, random_range(270, 360));
}
self.trTimers = ds_list_create();
self.trAngles = ds_list_create();
for (var i = 0; i < numStreamsPerSpawner; i++) {
    var delay = (self.streamDelay + (self.streamNumBullets * self.streamBulletsFrequency)) * (i / numStreamsPerSpawner);
    ds_list_add(self.trTimers, delay);
    ds_list_add(self.trAngles, random_range(180, 270));
}
self.blTimers = ds_list_create();
self.blAngles = ds_list_create();
for (var i = 0; i < numStreamsPerSpawner; i++) {
    var delay = (self.streamDelay + (self.streamNumBullets * self.streamBulletsFrequency)) * (i / numStreamsPerSpawner);
    ds_list_add(self.blTimers, delay);
    ds_list_add(self.blAngles, random_range(0, 90));
}
self.brTimers = ds_list_create();
self.brAngles = ds_list_create();
for (var i = 0; i < numStreamsPerSpawner; i++) {
    var delay = (self.streamDelay + (self.streamNumBullets * self.streamBulletsFrequency)) * (i / numStreamsPerSpawner);
    ds_list_add(self.brTimers, delay);
    ds_list_add(self.brAngles, random_range(90, 180));
}

// Pusher
//self.pusher = instance_create(self.x, self.y, obj_trash_pusher);
