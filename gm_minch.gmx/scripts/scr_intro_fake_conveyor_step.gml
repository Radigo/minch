
// Move crates, kills when off-belt
for (var crateIndex = 0; crateIndex < instance_number(obj_fake_crate); crateIndex++) {
    var crateInstance = instance_find(obj_fake_crate, crateIndex);
    if (crateInstance.x == self.leftColumnX) {
        // Up
        crateInstance.y -= self.scale;
    } else if (crateInstance.x ==self.middleColumnX) {
        // Down
        crateInstance.y += self.scale;
    } else if (crateInstance.x ==self.rightColumnX) {
        // Up
        crateInstance.y -= self.scale;
    }
    
    if ((crateInstance.y < (self.downColumnStartY * self.scale)) || (crateInstance.y > (self.upColumnStartY * self.scale))) {
        instance_destroy(crateInstance);
    }
}

if (self.crateSpawnTicker == 0) {
    // Spawns a crate at current belt index
    var crateX, crateY = 0;
    
    switch (self.currentColumnIndex) {
        case 0:
            // Up
            crateX = self.leftColumnX;
            crateY = self.upColumnStartY;
            break;
        case 1:
            // Down
            crateX = self.middleColumnX;
            crateY = self.downColumnStartY;
            break;
        case 2:
            // Up
            crateX = self.rightColumnX;
            crateY = self.upColumnStartY;
            break;
    }
    
    var newCrate = instance_create(crateX, crateY, obj_fake_crate);
    newCrate.depth = -1001;
    
    // Repeat
    self.crateSpawnTicker = ceil(scr_get_moreorless(self.crateSpawnDelay, self.crateSpawnDelayVar));
    self.currentColumnIndex++;
    if (self.currentColumnIndex > 2) {
        self.currentColumnIndex = 0;
    }
} else {
    self.crateSpawnTicker--;
}
