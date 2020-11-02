if (!self.isActive && (distance_to_object(obj_minch) < 96))
{
    self.isActive = true;
    self.patternTicker = 0;
}

if (!self.isActive)
{
    return false;
}

// Movement
self.xprevious = self.x;
self.yprevious = self.y;

if (self.hooverSpeed < self.targetSpeed)
{
    self.hooverSpeed += (self.targetSpeed - self.hooverSpeed) * 0.2;
}

self.x += dcos(self.hooverAngle) * self.hooverSpeed;
self.y += dsin(self.hooverAngle) * self.hooverSpeed;

if (collision_rectangle(
   self.x - 55, self.y - 35,
   self.x + 55, self.y + 35,
   obj_wall, false, false))
{
    self.x = self.xprevious;
    self.y = self.yprevious;

    self.hooverAngle = scr_cycle(self.hooverAngle - 180, -180, 180);
    self.targetAngle = self.hooverAngle;
    
    num_attempts = 0;
    
    var test_x = self.x + dcos(self.hooverAngle) * self.hooverSpeed;
    var test_y = self.y + dsin(self.hooverAngle) * self.hooverSpeed;
    
    self.randomizerTicker = 0;
}
else
{
    self.hooverAngle = scr_angle_rotate(self.hooverAngle, self.targetAngle, 1);
}

if (self.randomizerTicker < self.randomizerDuration)
{
    self.randomizerTicker++;
}
else
{
    self.targetAngle = random(360);
    self.randomizerDuration = random(40) + 20;
    self.randomizerTicker = 0;
}

// Shoot
//show_debug_message(string(self.dronesLeft) + ", " + string(self.patternTicker) + ", " + string(self.ticker));

if (self.dronesLeft > 0)
{
    // Spawning drones
    if (self.patternTicker == self.droneSpawnTickerLimit)
    {
        // upper spawn
        up_drone = instance_create(self.x, self.y, self.upperDroneObj);
        up_drone.parentCarrier = self;
        up_drone.circleAngle = pi * 0.5;
        // lower spawn
        lo_drone = instance_create(self.x, self.y, self.lowerDroneObj);
        lo_drone.parentCarrier = self;
        lo_drone.circleAngle = pi * 1.5;
        
        self.dronesLeft--;
        self.patternTicker = 0;
        
        if (self.dronesLeft == 0)
        {
            self.droneSpawnTickerLimit = 100;
        }
    }
}
else if (self.dronesLeft == 0)
{
    // Drones go in kamikaze mode
    if (self.patternTicker == self.droneSpawnTickerLimit)
    {
        var i;
        
        for (i = 0; i < instance_number(self.upperDroneObj); i++)
        {
            drone = instance_find(self.upperDroneObj, i);
            drone.status = "kamikazeFormation";
        }
        
        for (i = 0; i < instance_number(self.lowerDroneObj); i++)
        {
            drone = instance_find(self.lowerDroneObj, i);
            drone.status = "kamikazeFormation";
        }
        self.dronesLeft--;
        self.patternTicker = 0;
    }
}
else
{
    // Shooting like crazy
    if (self.patternTicker < 80)
    {
        if ((self.patternTicker % 8) == 0)
        {
            self.patternUpAngle += 43;
            self.patternDownAngle -= 43;
            
            //scr_pattern_spread(self.x + 24, self.y - 25, self.patternUpAngle, 1.6, 2, 4, 130);
            scr_pattern_spread(self.x + 39, self.y - 18, self.patternDownAngle, 1.2, 2, 4, 120);
            
            //scr_pattern_spread(self.x + 24, self.y + 11, self.patternUpAngle, 1.6, 2, 4, 130);
            scr_pattern_spread(self.x + 39, self.y + 3, self.patternDownAngle, 1.2, 2, 4, 120);
        }
    }
    else if (self.patternTicker == 160)
    {
        self.patternTicker = 0;
    }
}
