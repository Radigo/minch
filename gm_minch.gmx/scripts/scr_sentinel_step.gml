scr_ai_step();

if (!self.isActive && (distance_to_object(obj_minch) < self.targetLossDistance))
{
    self.isActive = true;
}

if (!self.isActive)
{
    return false;
}

switch (self.status)
{
    case self.STATUS_IDLE:
        self.radiusClosingSpeed = 0.1;// Returning to starting point (after losing MinCH)
        self.radiusEnlargeSpeed = 0.2;// Moving away from starting point (init or lost MinCH next to start)
        
        var sentinelInitX, sentinelInitY;// Because self refers to target here
        sentinelInitX = self.initX;
        sentinelInitY = self.initY;
        
        with (self.target)
        {
            move_towards_point(sentinelInitX, sentinelInitY, 0.3);
        }
        
        
        if (distance_to_object(obj_minch) < self.targetAlertDistance)
        {
            self.status = self.STATUS_ALERT;
        }
        break;
    case self.STATUS_ALERT:
        self.radiusClosingSpeed = 0.8;// Going to Minch
        self.radiusEnlargeSpeed = 1.2;// Too close from Minch
                
        with (self.target)
        {
            move_towards_point(obj_minch.x, obj_minch.y, 0.1);
        }
        
        if (distance_to_object(obj_minch) > self.targetLossDistance)
        {
            self.status = self.STATUS_IDLE;
        }
        break;
        
    case self.STATUS_COLLISION:
        if (self.ticker > 70)
        {
            self.status = self.STATUS_IDLE;
        }
        else
        {
            self.x += (self.target.x - self.x) * 0.3;
            self.y += (self.target.y - self.y) * 0.3;
            
            if (self.canon != noone)
            {
                self.canon.x = self.x;
                self.canon.y = self.y - 8;
            }
        }
        return false;
        
    case self.STATUS_DAMAGED:
        self.radiusClosingSpeed = 1.4;// Rushing for MinCH
        self.radiusEnlargeSpeed = 1.7;// Ooops too close
        break;
}

if (distance_to_object(self.target) < (self.targetAverageDistance - 4))
{
    self.moveRadius += self.radiusEnlargeSpeed;
}
else if (distance_to_object(self.target) > (self.targetAverageDistance + 2))
{
    self.moveRadius -= self.radiusClosingSpeed;
}

// Move sentinel in sine curves around target point (MinCH or origin)
// Rotation ratio (angle) = direction (+/- 1) x basic speed / distance, to avoid high speed when radius is too high
self.rotationRatio += self.rotationDirection * (pi / 120) / (self.moveRadius * 0.05);

self.x = self.target.x + (cos(self.rotationRatio) * self.moveRadius);
self.y = self.target.y + (sin(self.rotationRatio) * self.moveRadius);

// CANON
if (self.hp < 200)
{
    if (self.canon != noone)
    {
        scr_boom(self.x, self.y, 2, 12);
        with (self.canon) instance_destroy();
        self.canon = noone;
        self.patternTickerLimit = 60;
    }
    
    // Throw desperate pattern
    if (self.patternTicker == 1)
    {
        var init_angle = random(360);
        
        for (var i = 0; i < 8; i++)
        {
            scr_pattern_spread(self.x, self.y, (init_angle + (i * 2)), (0.8 + (i * 0.06)), 1, 8, 360);
        }
    }
    else if (self.patternTicker == 31)
    {
        var init_angle = random(360);
        
        for (var i = 0; i < 6; i++)
        {
            scr_pattern_spread(self.x, self.y, (init_angle + (i * 2)), (1 + (i * -0.03)), 1, 8, 360);
        }
    }
    
    return false;
}

// Aim canon to MinCH with delay
self.aimingAngle = scr_aim_at_minch(self, 0, 0, -8);
self.canon.image_angle = self.aimingAngle + 90;

// Move canon with sentinel
self.canon.x = self.x;
self.canon.y = self.y - 8;

// Canon shoot
if (self.patternTicker == 1)
{
    var canon_source_x = self.canon.x + cos(-self.aimingAngle * (pi / 180)) * 16;
    var canon_source_y = self.canon.y + sin(-self.aimingAngle * (pi / 180)) * 16;
    var canon_speed = 1;
    
    for (var i = 0; i < 6; i++)
    {
        canon_speed = 1.3 + (i * 0.15);
        scr_bullet_shot(canon_source_x, canon_source_y, self.aimingAngle, canon_speed, 3);
    }
}
