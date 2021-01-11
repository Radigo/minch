var shot_x = argument[0];
var shot_y = argument[1];
var shot_direction = argument[2];
var shot_speed = argument[3];
var shot_type = argument[4];

var shot_object = noone;

if (argument_count > 5) {
    shot_object = argument[5];
}

var rotate_instance = false;

if (argument_count > 6) {
    rotate_instance = argument[6];
}

global.bulletDepth = -1000;

var safe_zone = 128;// Outbounds distance until bullets can be shot
// If we are during start of end level sequence, no bullet
if (instance_exists(obj_level_intro)
    || instance_exists(obj_level_report)) {
    return false;
}

if ((x < (view_xview - safe_zone))
    || (x > (view_xview + view_wview + safe_zone))
    || (y < (view_yview - safe_zone))
    || (y > (view_yview + view_hview + safe_zone))) {
    // If emitter is off screen, don't shoot
    return false;
//} else if (point_distance(x, y, obj_minch_feets.x, obj_minch_feets.y) < 16) {
} else if ((abs(x - obj_minch_feets.x) < 20) && (abs(y - obj_minch_feets.y) < 20)) {
    // If emitter is too close to MinCH, don't shoot
    return false;
}
// default speed
if (shot_speed == 0) {
    shot_speed = 1;
}

switch (shot_type) {
    case 1:
        var shot = instance_create(shot_x, shot_y, obj_bullet_01);
        shot.image_speed = 0.3;
        shot.depth = global.bulletDepth;
        break;
    // case 2 is default...
    case 3:
        var shot = instance_create(shot_x, shot_y, obj_bullet_03);
        shot.image_speed = 0.3;
        shot.depth = global.bulletDepth;
        break;
    case 4:
        var shot = instance_create(shot_x, shot_y, obj_bullet_04);
        shot.image_speed = 0.3;
        shot.depth = global.bulletDepth;
        break;
    case 5:
        var shot = instance_create(shot_x, shot_y, obj_bigbullet);
        object_set_depth(obj_bigbullet, global.bulletDepth);
        break;
    case 0:
    default:
        if (argument_count > 5) {
            var shot = instance_create(shot_x, shot_y, shot_object);
            shot.image_speed = 1;
            shot.depth = global.bulletDepth;
        } else {
            var shot = instance_create(shot_x, shot_y, obj_bullet_02);
            shot.image_speed = 0.3;
            shot.depth = global.bulletDepth;
        }
        break;
}

shot.speed = shot_speed;
shot.direction = shot_direction;

if (rotate_instance) {
    shot.image_angle = shot_direction;
}

return shot;
