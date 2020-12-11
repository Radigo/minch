var shot_x = argument0;
var shot_y = argument1;
var shot_direction = argument2;

var shot_position_angle = (shot_direction + 20);

shot_x += cos(pi * (-shot_position_angle) / 180) * 8;
shot_y += sin(pi * (-shot_position_angle) / 180) * 8;

var shot = instance_create(shot_x, shot_y, obj_shot);

shot.speed = 8;
shot.direction = shot_direction;
shot.image_angle = shot_direction;
shot.depth = -3;
