// Wait for ground impact in room to fire a laser

if (!instance_exists(obj_napalm))
    return false;// Active only when Napalm lives

if (self.status == self.STATUS_SEARCH) {
    var napalm = instance_find(obj_napalm, 0);
    if (napalm.currentPhase == "phaseDiying") {
        self.targetX = obj_napalm.x;
        self.targetY = obj_napalm.y;
        self.status = self.STATUS_FIRE;
        self.ticker = 0;
    } else if (global.legsStatus == global.LEGS_JUMP) {
        self.targetX = obj_marker.x;
        self.targetY = obj_marker.y;
        self.status = self.STATUS_FIRE;
        self.ticker = 0;
    }
} else if (self.status == self.STATUS_FIRE) {
    if (self.ticker == 60) {
        var laser = instance_create(self.targetX, self.targetY, obj_groundlaser);
        laser.image_speed = 0.5;
        var rocks = instance_create(self.targetX, self.targetY, obj_fx_boom_big);
        rocks.image_speed = 0.2;
    } else if (self.ticker == 61) {
        if (instance_exists(obj_napalmdeath)) {
            // Create hole in the ground
            var hole = instance_create(self.targetX, self.targetY, obj_ch1hole);
        }
    } else if (self.ticker == 120) {
        if (instance_exists(obj_napalmdeath)) {
            with (self) instance_destroy();
        }
        self.status = self.STATUS_SEARCH;
        self.ticker = 0;
    }
    self.ticker++;
}
