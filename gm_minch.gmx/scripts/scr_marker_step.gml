var target_hit = collision_circle(x, y, 8, obj_wall, false, false);

show_debug_message("Markef angle: " + string(self.angle));

var inbetween_x = cos(self.angle) * 12;
var inbetween_y = sin(self.angle) * 12;

var inbetween_hit = collision_point(x, y, obj, prec, t);

if (target_hit || inbetween_hit)
{
    self.isBlocked = true;
}
else
{
    self.isBlocked = false;
}
