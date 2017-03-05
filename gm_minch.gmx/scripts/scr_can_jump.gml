// Check if jump is allowed

var pos_x = argument0;// source x
var pos_y = argument1;// source y
var angle = argument2;// angle in radians

var num_steps = 6;// precision of check between source and target

if (collision_circle(obj_marker.x, obj_marker.y, 8, obj_wall, false, false))
{
    show_debug_message("Marker is in wall");
    return false;
}

for (var i = 0; i < num_steps; i++)
{
    var inbetween_x = pos_x + cos(angle) * (self.markerDistance * (i / num_steps));
    var inbetween_y = pos_y + sin(angle) * (self.markerDistance * (i / num_steps));
    
    if (collision_point(inbetween_x, inbetween_y, obj_wall, false, true))
    {
        show_debug_message("sub step is in wall, step id: " + string(i));
        return false;
    }
}

show_debug_message("Jump is OK");

return true;
