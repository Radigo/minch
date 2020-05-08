var targetX = 1056;
var targetY = 160;

self.direction = point_direction(self.x, self.y, targetX, targetY);
var distance = point_distance(self.x, self.y, targetX, targetY);

if (distance > 64) {
    self.speed = 1.5;
} else if (distance > 4) {
    self.speed = max(self.speed * 0.99, 0.1);
} else {
    // make a hole in the wall
    instance_create(1024, 160, obj_ancestors_gate);
    // Update logic
    var wall = instance_position(1024, 160, obj_player_wall);
    with (wall)
        instance_change(obj_area_end_level, false);
    
    scr_switch_machine(2);// Focus OFF
    scr_boom(self.x, self.y, 4, 32);
    with (self) instance_destroy();
    return false;
}

//show_debug_message("neant death: " + string(self.x) + ", " + string(self.y) + ", direction: " + string(self.direction) + ", speed: " + string(self.speed));

if (self.patternTicker == self.patternTickerLimit) {
    scr_boom(scr_get_moreorless(self.x, 24), scr_get_moreorless(self.y, 32), 1, 8);
}
