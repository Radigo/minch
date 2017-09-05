// Display and animate caterpillars

//show_debug_message("big tank ai script x:" + string(self.x) + ", y:" + string(self.y));

self.isActive = (distance_to_object(obj_minch) < 140)

// TODO: change for a wake up mecanic

if (self.isActive)
{
    // Body movement
    
    if (self.ticker < 500)
    {
        // Moves down
        self.direction = 270;
    }
    else if (self.ticker < 1000)
    {
        // Moves up
        self.direction = 90;
    }
    else
    {
        self.ticker = 0;
        self.direction = 270;
    }
    
    // Movement collision
    if ((self.direction == 90)
        && collision_point(self.x, (self.y - 64), obj_wall, false, false))
    {
        self.speed = 0;
        self.ticker = 0;
    }
    else if ((self.direction == 270)
        && collision_point(self.x, (self.y + 64), obj_wall, false, false))
    {
        self.speed = 0;
        self.ticker = 500;
    }
    else
    {
        if (self.speed < 1)
        {
            self.speed += 0.005;
        }
        else
        {
            self.speed = 1;
        }
    }
    
    // Turret movements (back and forth)
    if (self.turretDirection > 0)
    {
        // Turret moves down
        if (self.turretY > 40)
        {
            self.turretDirection = -1;
        }
    }
    else if (self.turretDirection < 0)
    {
        //Turret moves up
        if (self.turretY < -40)
        {
            self.turretDirection = 1;
        }
    }
    
    if (self.patternTicker > 15)
    {
        self.turretY += (0.5 * self.turretDirection);
    }
    
    // Patterns
    if (self.patternTicker == 450)
    {
        self.patternTicker = 0;
    }
    
    // Sides machine guns
    if ((self.patternTicker % 5) == 0)
    {
        var machinegun_angle = scr_get_moreorless(0, 2);
        var machinegun_source_x = self.x + 11;
        
        // Search Minch Direction
        if (obj_minch_feets.x < self.x)
        {
            machinegun_angle = scr_get_moreorless(180, 2);
            machinegun_source_x = self.x - 11;
        }
        
        scr_bullet_shot(machinegun_source_x, (self.y - 48), machinegun_angle, 3, 2);
        scr_bullet_shot(machinegun_source_x, (self.y + 48), machinegun_angle, 3, 2);
    }
    
    // Rotary patterns
    if ((self.patternTicker < 300)
        && ((self.patternTicker % 7) == 0))
    {
        var spread_direction = self.patternTicker * 3;
        var spread_source_x = self.x - 11;
        
        // Search Minch Direction
        if (obj_minch_feets.x < self.x)
        {
            spread_source_x = self.x + 11;
        }
        
        scr_pattern_spread(spread_source_x, (self.y - 48), spread_direction, 2, 3, 3, 5);
        if (scr_pattern_spread(spread_source_x, (self.y + 48), -spread_direction, 2, 3, 3, 5))
        {
            audio_play_sound(snd_bullet_shot, 0, false);
        }
    }
    
    // Missiles
    if ((self.patternTicker % 90) == 0)
    {
        if ((self.turretFacing == "left") && (obj_minch_feets.x < self.x))
        {
            scr_bullet_shot((self.x - 24), (self.y + self.turretY), 180, 2.3, 0, obj_missile_darkred_E, true);
        }
        else if ((self.turretFacing == "right") && (obj_minch_feets.x > self.x))
        {
            scr_bullet_shot((self.x + 24), (self.y + self.turretY), 0, 2.3, 0, obj_missile_darkred_E);
        }
    }
}
else
{
    self.patternTicker = 0;
    self.ticker = 0;
    self.speed = 0;
}
