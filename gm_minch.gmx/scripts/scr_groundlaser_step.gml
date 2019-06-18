// Wait for ground impact in room to fire a laser

if (self.status == self.STATUS_SEARCH) {
    if (global.legsStatus == global.LEGS_JUMP) {
        self.targetX = obj_marker.x;
        self.targetY = obj_marker.y;
        self.status = self.STATUS_FIRE;
        self.ticker = 0;
    }
} else if (self.status == self.STATUS_FIRE) {
    if (self.ticker == 60) {
        var laser = instance_create(self.targetX, self.targetY, obj_groundlaser);
        laser.image_speed = 0.5;
        var rocks = instance_create(self.targetX, self.targetY, obj_rocks_geyser);
        rocks.image_speed = 0.2;
    } else if (self.ticker == 120) {
        self.status = self.STATUS_SEARCH;
        self.ticker = 0;
    }
    self.ticker++;
}
