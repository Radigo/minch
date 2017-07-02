scr_ai_init();

self.dronesLeft = 8;// Overriden by creation code

self.droneSpawnTickerLimit = 60;

self.upperDroneObj = obj_carrierdrone_cy;
self.lowerDroneObj = obj_carrierdrone_ma;

self.randomizerDuration = 60;
self.randomizerTicker = 0;

self.hooverSpeed = 0;
self.targetSpeed = 0.4;
self.hooverAngle = -90;
self.targetAngle = -90;
