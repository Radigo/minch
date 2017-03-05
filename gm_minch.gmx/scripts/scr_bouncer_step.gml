// Bounce baby bounce
self.xprevious = self.x;
self.yprevious = self.y;

self.x += cos(self.movingAngle) * self.movingSpeed;
self.y += sin(self.movingAngle) * self.movingSpeed;

if (collision_ellipse(
    self.x - self.collisionRadius, self.y - self.collisionRadius,
    self.x + self.collisionRadius, self.y + self.collisionRadius,
    obj_wall, false, false))
{
    // Bounce!
    // Test a random direction until it's free
    self.x = self.xprevious;
    self.y = self.yprevious;
    
    self.movingAngle = random(pi * 2);
    self.patternTickerLimit = random(20) + 12;
    self.movingSpeed = random(0.8) + 0.5;
    
    var test_x = self.x + cos(self.movingAngle) * self.movingSpeed;
    var test_y = self.y + sin(self.movingAngle) * self.movingSpeed;
    
    while (collision_ellipse(
        test_x - self.collisionRadius, test_y - self.collisionRadius,
        test_x + self.collisionRadius, test_y + self.collisionRadius,
        obj_wall, false, false))
    {
        self.movingAngle = random(pi * 2);
        test_x += cos(self.movingAngle) * self.movingSpeed;
        test_y += sin(self.movingAngle) * self.movingSpeed;
    }
}

// Shoot baby shoot!
if (self.patternTicker == 1)
{
    var bullet_angle = scr_aim_at_minch(self, 2, 0, 0);
    scr_bullet_shot(self.x, self.y, bullet_angle, 1.5, 1);
    
    // Change shot frequency depending on distance with MinCH
    self.patternTickerLimit = 15 + floor(distance_to_object(obj_minch) * 0.5);
}
