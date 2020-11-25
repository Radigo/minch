// Positions
self.scale = 1;// Consider scaling the whole thing

self.tileSize = 32;
self.numTilesHeight = 11;

self.leftColumnX = self.x;
self.middleColumnX = self.x + (self.tileSize * 2);
self.rightColumnX = self.x + (self.tileSize * 4);

self.downColumnStartY = self.y;
self.upColumnStartY = self.y + (self.tileSize * (self.numTilesHeight - 1));

// Timer
self.crateSpawnDelay = 22;
self.crateSpawnDelayVar = 18;
self.currentColumnIndex = 0;// 0: left, 1: middle, 2: right > repeat
self.crateSpawnTicker = 0;

// Init columns of conveyor belts
// Left: up
// Middle: down
// Right: up

var i, tileX, tileY = 0;

tileX = self.leftColumnX;
for (i = 0; i < self.numTilesHeight; i++) {
    tileY = self.upColumnStartY - (self.tileSize * i);
    var beltTile = instance_create(tileX, tileY, obj_fake_conveyor_up);
    beltTile.depth = -1000;
}

tileX = self.middleColumnX;
for (i = 0; i < self.numTilesHeight; i++) {
    tileY = self.downColumnStartY + (self.tileSize * i);
    var beltTile = instance_create(tileX, tileY, obj_fake_conveyor_down);
    beltTile.depth = -1000;
}

tileX = self.rightColumnX;
for (i = 0; i < self.numTilesHeight; i++) {
    tileY = self.upColumnStartY - (self.tileSize * i);
    var beltTile = instance_create(tileX, tileY, obj_fake_conveyor_up);
    beltTile.depth = -1000;
}
