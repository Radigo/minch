/*
Drones are spawn by a carrier.

Drones move in a given direction (up or down depnding on spawn location on carrier)
they circle around carrier until all of them are spawned (eventually shooting bullets)
then they move towards MinCH for collision.

*/

scr_ai_step();

// Movement
if (self.status == self.STATUS_CIRCLE)
{
    if (!instance_exists(self.parentCarrier))
    {
        show_debug_message(string(self) + " drone has no parent");
        self.status = self.STATUS_KAMIKAZE;
        return false;
    }
    
    if (self.randomizerTicker < self.randomizerDuration)
    {
        self.randomizerTicker++;
    }
    else
    {
        self.distanceFriction = 0.01;
        self.randomizerDuration = random(30) + 30;
        self.distanceRandomizerAmount = random(30);
        self.circleSpeedRandomizerAmount = random(0.008);
        self.randomizerTicker = 0;
    }

    self.circleCurrentDistance += ((self.circleDistance + self.distanceRandomizerAmount) - self.circleCurrentDistance) * self.distanceFriction;

    self.x = self.parentCarrier.x + cos(self.circleAngle) * self.circleCurrentDistance;
    self.y = self.parentCarrier.y + sin(self.circleAngle) * self.circleCurrentDistance;
    self.circleAngle += self.circleSpeed + self.circleSpeedRandomizerAmount;
    
    self.xSpeed = self.x - self.xprevious;
    self.ySpeed = self.y - self.yprevious;
}
else if (self.status == self.STATUS_KAMIKAZE)
{
    if (self.kamikazeSpeed == 0)
    {
        // init kamikaze        
        self.kamikazeSpeed = sqrt(power(self.xSpeed, 2) + power(self.ySpeed, 2));
        self.kamikazeAngle = darctan2(-self.ySpeed, self.xSpeed);
    }
    
    var aiming = scr_aim_at_minch(self, 5, 0, 0);
    self.kamikazeAngle = scr_angle_rotate(self.kamikazeAngle, aiming, 1);
    
    self.speed = self.kamikazeSpeed * (1 - (abs(angle_difference(aiming, self.kamikazeAngle)) / 180));
    self.direction = self.kamikazeAngle;
}

//show_debug_message(string(self.x) + " / " + string(self.xprevious) + " : " + string(self.y) + " / " + string(self.yprevious) + "; " + string(self.kamikazeAngle));

// Shoot
