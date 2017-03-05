/** Returns the aiming angle between an enemy
and Minch with an optionnal error amount */

var enemy = argument0;// real enemy
var error_amount = argument1;// error amount in degrees
var canon_offset_x = argument2;// an offset to allow aiming not to come from center
var canon_offset_y = argument3;// an offset to allow aiming not to come from center

var aim_angle = point_direction((enemy.x + canon_offset_x), (enemy.y + canon_offset_y), obj_minch.x, obj_minch.y);

return scr_get_moreorless(aim_angle, error_amount);
