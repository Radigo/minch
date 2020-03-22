scr_ai_init();

self.parentBoss = noone;

self.hp = 30;

self.STATUS_SPAWN = "spawn";
self.STATUS_TRAVEL = "travel";
self.STATUS_SPIRALDOWN = "spiraldown";
self.status = self.STATUS_SPAWN;

// Move variables
self.SPAWN_DURATION = 60;
self.TRAVEL_DURATION = 240;
self.CIRCLE_DURATION_BEFORE_SPIRALDOWN = 200;// Should let enough time for all pods to reach dest. origin

self.SPAWN_TARGET_RADIUS = 64;
self.travelRadius = 32;
self.travelAngle = 0;// Base angle on zero then offset by pi to start on CH1's back and use travelDirection to get direction
self.travelAngleSpeed = 0.016;

// Set by spawner
self.sourceX = 0;
self.travelTargetX = 0;
self.sourceY = 0;
self.spawnTimeOffset = 0;// Use to synchronize spiraldown pattern
self.travelDirection = 1;// or -1, multiplies travelAngleSpeed
