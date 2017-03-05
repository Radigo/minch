scr_ai_init();

// Regular vars
self.hp = 800;
self.value = 800;

self.explosionSize = 48;
self.explosionLevel = 3;
self.patternTickerLimit = 130;

// Init vars
self.STATUS_IDLE = "idle";// When not in attack range of MinCH
self.STATUS_ALERT = "alert";// When in attack range of MinCH
self.STATUS_COLLISION = "collision";// After hitting a wall, spend some time going away from the wall
self.STATUS_DAMAGED = "damaged";// When canon lost (berserk)
self.status = STATUS_IDLE;

self.targetAlertDistance = 96;// Triggers the alert when entering the zone
self.targetLossDistance = 128;// Losing target after exiting the zone

// rotation
self.moveRadius = 0;
self.rotationRatio = 0;// Angle of rotation curve in radian
self.radiusClosingSpeed = 1;
self.radiusEnlargeSpeed = 1;
self.rotationDirection = 1;// Set -1 to inverse rotation

// target
self.targetAverageDistance = 64;
self.target = instance_create(self.x, self.y, obj_dummy);
self.target.image_xscale = 3;
self.target.image_yscale = 3;
self.target.visible = false;

// Instanciate canon over sentinel
self.canon = instance_create(self.x, self.y, obj_sentinel_canon);
self.canon.depth = self.depth - 1;
self.aimingAngle = 0;
