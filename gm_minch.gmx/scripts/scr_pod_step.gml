/*

Pods are created by one of CH1's attack
They spawn on CH1's back O (origin) and move to its front at O' (dest. origin)
Once at O' hey spiral down to trap MinCH in O' center and throw bullets outside the trap
When they collapse together they blow up

*/

scr_ai_step();

var originX = self.sourceX;

//Movement
if (self.status == self.STATUS_SPAWN) {
    // Quickly reach max radius and vertical(ish) angle
    if (self.ticker < self.SPAWN_DURATION) {
        var spawnProgress = (self.ticker / self.SPAWN_DURATION);
        self.travelRadius = self.SPAWN_TARGET_RADIUS * spawnProgress;
        self.travelAngle = (pi * 0.4) * spawnProgress;
    } else {
        self.status = self.STATUS_TRAVEL;
        self.ticker = 0;
    }
} else if (self.status == self.STATUS_TRAVEL) {
    // Move origin to the right
    if (self.ticker < self.TRAVEL_DURATION) {
        var travelProgress = (self.ticker / self.TRAVEL_DURATION);
        self.travelRadius += 0.2;
        self.travelAngle = (pi * 0.4) + ((pi * 0.2) * travelProgress);
        originX = self.sourceX + ((self.travelTargetX - self.sourceX) * travelProgress);
    } else {
        self.status = self.STATUS_SPIRALDOWN;
        self.ticker = 0;
        self.patternTicker = 0;
    }
}
else if (self.status == self.STATUS_SPIRALDOWN)
{
    originX = self.travelTargetX;
    
    // Circle at travelAngleSpeed and reduce radius after a while
    if (self.ticker < (self.CIRCLE_DURATION_BEFORE_SPIRALDOWN - self.spawnTimeOffset)) {
        self.travelAngle += travelAngleSpeed;
    } else if (self.travelRadius > 16) {
        self.travelRadius -= 0.1;
        self.travelAngle += travelAngleSpeed;
    } else {
        // Self destruct no points
        with (self) scr_enemy_death(false, false);
    }
    
    // Shot dens spreads with gaps
    if (self.patternTicker < 60) {
        if ((self.patternTicker % 8) == 0) {
            var shotAngle = ((self.travelDirection * (self.travelAngle + pi + 0.1)) * 180 / pi);
            var shotSpeed = 1.5 + (self.patternTicker / 60);
            scr_bullet_shot(self.x, self.y, shotAngle, shotSpeed, 2);
        }
    } else if (self.patternTicker < 70) {
    
    } else {
        self.patternTicker = 0;
    }
}

// Apply move
self.x = originX + cos((self.travelDirection * self.travelAngle) + pi) * self.travelRadius;
self.y = self.sourceY - sin((self.travelDirection * self.travelAngle) + pi) * self.travelRadius;
