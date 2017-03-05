/** Minch Movement and behavior */

var walk_speed = 0;

var prev_x = x;
var prev_y = y;

var marker_p_distance = 48;

global.legsStatus = global.LEGS_WALK;

// GET KEY PRESSED
if (keyboard_check(global.key_right) &&  keyboard_check(global.key_up))
{
    global.legsAngle = pi * 1.75;
    walk_speed = 2;
    sprite_index = spr_minch_NE;
}
else if (keyboard_check(global.key_left) &&  keyboard_check(global.key_up))
{
    global.legsAngle = pi * 1.25;
    walk_speed = 2;
    sprite_index = spr_minch_NW;
}
else if (keyboard_check(global.key_left) && keyboard_check(global.key_down))
{
    global.legsAngle = pi * 0.75;
    walk_speed = 2;
    sprite_index = spr_minch_SW;
}
else if (keyboard_check(global.key_down) && keyboard_check(global.key_right))
{
    global.legsAngle = pi * 0.25;
    walk_speed = 2;
    sprite_index = spr_minch_SE;
}
else if (keyboard_check(global.key_up))
{
    global.legsAngle = pi * 1.5;
    walk_speed = 2;
    sprite_index = spr_minch_N;
}
else if (keyboard_check(global.key_down))
{
    global.legsAngle = pi * 0.5;
    walk_speed = 2;
    sprite_index = spr_minch_S;
}
else if (keyboard_check(global.key_left))
{
    global.legsAngle = pi * 1;
    walk_speed = 2;
    sprite_index = spr_minch_W;
}
else if (keyboard_check(global.key_right))
{
    global.legsAngle = 0;
    walk_speed = 2;
    sprite_index = spr_minch_E;
}
else
{
    global.legsStatus = global.LEGS_IDLE;
}

if (keyboard_check(global.key_a))
{
    // show_debug_message("A");
    global.aReleaseTime = global.aReleaseDelay;
    global.aPressTime++;
    
    if (global.aPressTime < global.aPressDelay)
    {
        global.bodyStatus = global.BODY_SHOT;// << FREE SHOT
    }
    else
    {
        global.aPressTime = global.aPressDelay;
        global.bodyStatus = global.BODY_AIM;// << AIMED SHOT
    }
}
else
{
    global.aPressTime = 0;
    
    if (global.aReleaseTime > 0)
    {
        global.aReleaseTime--;
    }
    else
    {
        global.bodyStatus = global.BODY_IDLE;// NO MORE SHOOTING
    }
}

if (keyboard_check(global.key_b))
{
    show_debug_message("B");
}

// STATUS
switch (global.bodyStatus)
{
    case global.BODY_IDLE:
        global.bodyAngle = global.legsAngle;
        
        direction = 180 * (-global.bodyAngle) / pi;
        obj_marker.sprite_index = spr_marker_P;
        obj_marker.image_angle = 0;
        break;
    case global.BODY_SHOT:
        var angle_step = 0.1;// Rotates by step Radians at each frame
        
//        MARCHE PAS!!
        if ((global.bodyAngle - global.legsAngle) > pi)
        {
            global.bodyAngle += (2 * pi);
        }
        
        if (global.bodyAngle < (global.legsAngle - angle_step))
        {
            global.bodyAngle += angle_step;
        }
        else if (global.bodyAngle > (global.legsAngle + angle_step))
        {
            global.bodyAngle -= angle_step;
        }
        else
        {
            global.bodyAngle = global.legsAngle;
        }
        
//        MARCHE PAS NON PLUS!!
        if (global.bodyAngle > (2 * pi))
        {
            global.bodyAngle -= (2 * pi);
        }
        
        direction = 180 * (-global.bodyAngle) / pi;
        obj_marker.sprite_index = spr_marker_S;
        obj_marker.image_angle = direction;
        
        if (global.shotTime < global.shotDelay)
        {
            global.shotTime++;
        }
        else
        {
            global.shotTime = 0;
            var shot = instance_create(x, y, obj_shot);
            shot.speed = 8;
            shot.direction = obj_marker.image_angle;
            shot.image_angle = direction;
        }
        break;
    case global.BODY_AIM:
        // TODO, AIM FOR FIXED MARKER
        direction = 180 * (-global.bodyAngle) / pi;
        obj_marker.sprite_index = spr_marker_S;
        obj_marker.image_angle = 180 * (-global.bodyAngle) / pi;
        
        if (global.shotTime < global.aimDelay)
        {
            global.shotTime++;
        }
        else
        {
            global.shotTime = 0;
            var shot = instance_create(x, y, obj_shot);
            shot.speed = 8;
            shot.direction = direction;
            shot.image_angle = direction;
        }
        break;
}

// MOVES
if (global.legsStatus = global.LEGS_JUMP)
{
    // Count jump duration
}
else
{
    x += cos(global.legsAngle) * walk_speed;
    y += sin(global.legsAngle) * walk_speed;
}

obj_marker.x = x + cos(global.bodyAngle) * marker_p_distance;
obj_marker.y = y + sin(global.bodyAngle) * marker_p_distance;

// Collision
if (collision_circle(x, y, 8, obj_wall, false, false))
{
    if (!collision_circle(xprevious, y, 8, obj_wall, false, false))
    {
        x = xprevious;
    }
    else if (!collision_circle(x, yprevious, 8, obj_wall, false, false))
    {
        y = yprevious;
    }
    else if (!collision_circle(xprevious, yprevious, 8, obj_wall, false, false))
    {
        x = xprevious;
        y = yprevious;
    }
}
else
{

}
