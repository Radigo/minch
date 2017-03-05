/** fire a regular spread of bullets */
var shot_x = argument0;
var shot_y = argument1;
var shot_direction = argument2;
var shot_speed = argument3;
var shot_type = argument4;

var num_bullets = argument5;
var total_angle = argument6;

var bullet_angle = shot_direction - (total_angle * 0.5);
var bullet_step_angle = total_angle / (num_bullets - 1);

for (var i = 0; i < num_bullets; i++)
{
    if (!scr_bullet_shot(shot_x, shot_y, bullet_angle, shot_speed, shot_type))
    {
        return false;
    }
    bullet_angle += bullet_step_angle;
}

return true;
