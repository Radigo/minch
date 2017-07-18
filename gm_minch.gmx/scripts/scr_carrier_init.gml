scr_ai_init();

// Drones
self.dronesLeft = 8;// Overriden by creation code
self.droneSpawnTickerLimit = 40;

self.upperDroneObj = obj_carrierdrone_cy;
self.lowerDroneObj = obj_carrierdrone_ma;

// Movements
self.randomizerDuration = 60;
self.randomizerTicker = 0;

self.hooverSpeed = 0;
self.targetSpeed = 0.4;
self.hooverAngle = -90;
self.targetAngle = -90;

// Bullets
self.patternUpAngle = 0;
self.patternDownAngle = 0;
