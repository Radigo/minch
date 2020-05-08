var self_x, self_y, distance_x, distance_y;

self_x = self.x;
self_y = self.y;

if (instance_exists(self.focus) == 0)
{
    self.focus = obj_minch;
}

//show_debug_message("scr_camera_step @ " + string(self.x) + "," + string(self.y) + " > focus: " + string(self.focus) + ", " + object_get_name(self.focus) + " @ " + string(self.focus.x) + "," + string(self.focus.y));

if (self.transitionStep > 0)
{
    //show_debug_message("transition: " + string(self.transitionStep) + ", " + string(self.transitionDuration));
    self.transitionStep--;
    
    if (object_get_name(obj_minch) == object_get_name(self.focus))
    {
        // The focus is going back to minch
        if (point_distance(self.x, self.y, obj_minch.x, obj_minch.y) < 3)
        {
            // We are already too close > skip transition
            self_x = self.focus.x;
            self_y = self.focus.y;
            self.transitionStep = 0;
        }
        
        self_x = obj_minch.x + ((self.x - obj_minch.x) * (self.transitionStep / self.transitionDuration));
        self_y = obj_minch.y + ((self.y - obj_minch.y) * (self.transitionStep / self.transitionDuration));
        //show_debug_message("selfcoords to MinCH " + string(self_x) + "," + string(self_y));
    }
    else
    {
        var distance_x = min((self.focus.x - self.x), self.hDistanceMax);
        var distance_y = min((self.focus.y - self.y), self.vDistanceMax);

        
        self_x = self.x + (distance_x / self.transitionStep);
        self_y = self.y + (distance_y / self.transitionStep);
        //show_debug_message("selfcoords to obj " + string(self_x) + "," + string(self_y));
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

//show_debug_message("applying coords " + string(self_x) + "," + string(self_y));
self.x = self_x;
self.y = self_y;
