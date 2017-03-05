/* is_shield:
    - true if sparkles are against shields or walls
    - false if sparkles are hit sparkles
    shot_object:
    - the object to get the sparkles direction
    is_piercing_shot:
    - since shot object can be claw or wave attack, we need to throw sparkles differently
*/
var is_shield = argument0;
var shot_object = argument1;
var is_piercing_shot = argument2;

var num_sparkles, pt_sparkle, direction_min, direction_max;

if (is_shield)
{
    num_sparkles = random(2) + 1;
    pt_sparkles = global.pt_shot_sparkles;
    direction_min = shot_object.direction + 170;
    direction_max = shot_object.direction + 200;
}
else if (is_piercing_shot)
{
    num_sparkles = random(2) + 1;
    pt_sparkles = global.pt_hit_sparkles;
    direction_min = 0;
    direction_max = 360;
}
else
{
    num_sparkles = random(4) + 2;
    pt_sparkles = global.pt_hit_sparkles;
    direction_min = shot_object.direction -10;
    direction_max = shot_object.direction + 10;
}

part_type_direction(pt_sparkles, direction_min, direction_max, 0, 0);
part_emitter_region(global.ps_light, global.em_shots_sparkles, (shot_object.x - 4), (shot_object.x + 4), (shot_object.y - 4), (shot_object.y + 4), ps_shape_ellipse, ps_distr_invgaussian);
part_emitter_burst(global.ps_light, global.em_shots_sparkles, pt_sparkles, num_sparkles);
