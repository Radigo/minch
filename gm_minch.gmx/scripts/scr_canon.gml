// Shoot big bullets!
var canon_name;
var canon_direction;
var emitter_distance_x;
var emitter_distance_y;

if (self.patternTicker == (self.shotDelay + self.tickerShift))
{
    canon_name = object_get_name(object_index);
    
    if (string_count("down", canon_name) > 0)
    {
        canon_direction = -90;
        emitter_distance_x = 0;
        emitter_distance_y = 24;
        
        var fx = instance_create(self.x, self.y + 18, obj_canondown_fx);
    }
    else if (string_count("left", canon_name) > 0)
    {
        canon_direction = 180;
        emitter_distance_x = -24;
        emitter_distance_y = 0;
        
        var fx = instance_create(self.x - 26, self.y, obj_canonleft_fx);
    }
    else if (string_count("right", canon_name) > 0)
    {
        canon_direction = 0;
        emitter_distance_x = 24;
        emitter_distance_y = 0;
        
        var fx = instance_create(self.x + 26, self.y, obj_canonleft_fx);
        fx.image_xscale = -1;
    }
    
    scr_bullet_shot((self.x + emitter_distance_x), (self.y + emitter_distance_y), canon_direction, 1, 5);
    
    fx.image_speed = 0.4;
    fx.depth = -1100;// over bullets
    
    self.patternTicker = self.tickerShift;
}
