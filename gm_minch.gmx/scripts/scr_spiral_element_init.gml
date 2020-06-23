scr_ai_init();

var isDeflector = argument0;

if (isDeflector) {
    self.shield = true;
} else {
    self.hp = 60;
}

self.centerX = 0;
self.centerY = 0;

self.radius = 0;// Out of screen start radius
self.minRadius = 0;// Explode if too close
self.maxRadius = 320;// Stops expanding
self.angle = 0;// Placement on the ring (radians)
self.rotationSpeed = 0;
self.radiusSpeed = 0;

self.isShooting = false;
self.streamFrequency = 10;
self.streamGap = 60;
self.patternTickerLimit = 100;
