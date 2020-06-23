scr_ai_step();

// Travel
self.radius += self.radiusSpeed;
self.radiusSpeed *= 0.998;

if (self.radius < self.minRadius) {
    scr_boom(self.x, self.y, 2, 16);
    with (self) instance_destroy();
} else if (self.radius > self.maxRadius) {
    self.radiusSpeed = 0;
}

// Rotation
self.angle += self.rotationSpeed;
self.image_angle = (self.angle / pi * 180) + 90;

// Placement
self.x = self.centerX + cos(self.angle) * self.radius;
self.y = self.centerY - sin(self.angle) * self.radius;

// Pattern
if (self.isShooting) {
    if ((self.patternTicker > self.streamGap) && ((self.patternTicker % self.streamFrequency) == 0)) {
        var shotX = self.x + cos(self.angle) * 6;
        var shotY = self.y - sin(self.angle) * 6;
        var shotAngle = (self.angle / pi * 180);
        scr_bullet_shot(shotX, shotY, shotAngle, 1, 2);
    }
}
