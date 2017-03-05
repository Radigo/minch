var shot_x = argument0;
var shot_y = argument1;
var shot_direction = argument2;
var shot_type = argument3;

var bullet_speed = 1;// TODO: ADD RANK

switch (shot_type)
{
    case 1:
        var shot = instance_create(shot_x, shot_y, obj_bullet_01);
        break;
    case 2:
    default:
        var shot = instance_create(shot_x, shot_y, obj_bullet_02);
        break;
    case 3:
        var shot = instance_create(shot_x, shot_y, obj_bullet_03);
        break;
    case 4:
        var shot = instance_create(shot_x, shot_y, obj_bullet_04);
        break;
}

shot.speed = bullet_speed;
shot.direction = shot_direction;
