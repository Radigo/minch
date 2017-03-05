var shot_x = argument0;
var shot_y = argument1;
var shot_direction = argument2;
var shot_speed = argument3;
var shot_obj = argument4;

var safe_zone = 64;// Outbounds distance until bullets can be shot

// If emitter is off screen, don't shoot
if ((x < (view_xview - safe_zone))
    || (x > (view_xview + view_wview + safe_zone))
    || (y < (view_yview - safe_zone))
    || (y > (view_yview + view_hview + safe_zone)))
{
    exit;
}

// default speed
if (shot_speed = 0)
{
    shot_speed = 1;
}

switch (shot_type)
{
    case 1:
        var shot = instance_create(shot_x, shot_y, obj_bullet_01);
        if !instance_exists(obj_bullet_01) object_set_depth(obj_bullet_01, -1000);
        break;
    case 2:
    default:
        var shot = instance_create(shot_x, shot_y, obj_bullet_02);
        if !instance_exists(obj_bullet_01) object_set_depth(obj_bullet_02, -1000);
        break;
    case 3:
        var shot = instance_create(shot_x, shot_y, obj_bullet_03);
        if !instance_exists(obj_bullet_01) object_set_depth(obj_bullet_03, -1000);
        break;
    case 4:
        var shot = instance_create(shot_x, shot_y, obj_bullet_04);
        if !instance_exists(obj_bullet_01) object_set_depth(obj_bullet_04, -1000);
        break;
}

shot.speed = shot_speed;//TODO: multiply by rank
shot.direction = shot_direction;
