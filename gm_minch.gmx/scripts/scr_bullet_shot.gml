var shot_x = argument[0];
var shot_y = argument[1];
var shot_direction = argument[2];
var shot_speed = argument[3];
var shot_type = argument[4];

var shot_object = noone;

if (argument_count > 5)
{
    shot_object = argument[5];
}

var rotate_instance = false;

if (argument_count > 6)
{
    rotate_instance = argument[6];
}

global.bulletDepth = -1000;

var safe_zone = 128;// Outbounds distance until bullets can be shot

// If we are during start of end level sequence, no bullet
if (instance_exists(obj_level_intro)
    || instance_exists(obj_level_report))
{
    return false;
}

// If emitter is off screen, don't shoot
if ((x < (view_xview - safe_zone))
    || (x > (view_xview + view_wview + safe_zone))
    || (y < (view_yview - safe_zone))
    || (y > (view_yview + view_hview + safe_zone)))
{
    return false;
}

// default speed
if (shot_speed == 0)
{
    shot_speed = 1;
}

switch (shot_type)
{
    case 1:
        var shot = instance_create(shot_x, shot_y, obj_bullet_01);
        object_set_depth(obj_bullet_01, global.bulletDepth);
        break;
    // case 2 is default...
    case 3:
        var shot = instance_create(shot_x, shot_y, obj_bullet_03);
        object_set_depth(obj_bullet_03, global.bulletDepth);
        break;
    case 4:
        var shot = instance_create(shot_x, shot_y, obj_bullet_04);
        object_set_depth(obj_bullet_04, global.bulletDepth);
        break;
    case 5:
        var shot = instance_create(shot_x, shot_y, obj_bigbullet);
        object_set_depth(obj_bigbullet, global.bulletDepth);
        break;
    case 0:
    default:
        if (argument_count > 5)
        {
            var shot = instance_create(shot_x, shot_y, shot_object);
            object_set_depth(shot_object, global.bulletDepth);
        }
        else
        {
            var shot = instance_create(shot_x, shot_y, obj_bullet_02);
            object_set_depth(obj_bullet_02, global.bulletDepth);
        }
        break;
}

shot.speed = shot_speed;//TODO: multiply by rank
shot.direction = shot_direction;

if (rotate_instance)
{
    shot.image_angle = shot_direction;
}

return shot;
