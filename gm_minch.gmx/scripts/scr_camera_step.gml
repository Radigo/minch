var self_x, self_y, distance_x, distance_y;

self_x = self.x;
self_y = self.y;

if (instance_exists(self.focus) == 0)
{
    self.focus = obj_minch;
}

if (self.transitionStep > 0)
{
    self.transitionStep--;
    
    if (object_get_name(obj_minch) == object_get_name(self.focus))
    {
        // The focus is going back to minch
        if ((abs(self.x - obj_minch.x) < 3)
            && (abs(self.y - obj_minch.y) < 3))
        {
            // We are already too close > skip transition
            self_x = self.focus.x;
            self_y = self.focus.y;
            self.transitionStep = 0;
        }
        
        self_x = obj_minch.x + ((self.x - obj_minch.x) * (self.transitionStep / self.transitionDuration));
        self_y = obj_minch.y + ((self.y - obj_minch.y) * (self.transitionStep / self.transitionDuration));
    }
    else
    {
        // The focus is going to an object
        distance_x = self.focus.x - obj_minch.x;
        distance_y = self.focus.y - obj_minch.y;
        
        if (distance_x > self.hDistanceMax)
        {
            distance_x = self.hDistanceMax;
        }
        else if (distance_x < -self.hDistanceMax)
        {
            distance_x = -self.hDistanceMax;
        }
        
        if (distance_y > self.vDistanceMax)
        {
            distance_y = self.vDistanceMax;
        }
        else if (distance_y < -self.vDistanceMax)
        {
            distance_y = -self.vDistanceMax;
        }
        
        self_x = obj_minch.x + (distance_x * (1 - (self.transitionStep / self.transitionDuration)));
        self_y = obj_minch.y + (distance_y * (1 - (self.transitionStep / self.transitionDuration)));
    }
}
else
{
    self_x = self.focus.x;
    self_y = self.focus.y;
}

if ((self_x - obj_minch.x) > self.hDistanceMax)
{
    self_x = obj_minch.x + self.hDistanceMax;
}
else if ((self_x - obj_minch.x) < -self.hDistanceMax)
{
    self_x = obj_minch.x - self.hDistanceMax;
}

if ((self_y - obj_minch.y) > self.vDistanceMax)
{
    self_y = obj_minch.y + self.vDistanceMax;
}
else if ((self_y - obj_minch.y) < -self.vDistanceMax)
{
    self_y = obj_minch.y - self.vDistanceMax;
}

self.x = self_x;
self.y = self_y;
