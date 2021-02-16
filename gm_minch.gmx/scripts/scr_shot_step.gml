var safe_zone = 64;// Outbounds distance until shots can live

if (collision_point(x, y, obj_wall, false, false))
{
    scr_shot_sparkles(true, self, false);
    scr_play_sound(snd_shot_shield, global.SFX_ENVIRONMENT, false);
    instance_destroy();
}

// If emitter is off screen, don't shoot
if ((x < (view_xview - safe_zone))
    || (x > (view_xview + view_wview + safe_zone))
    || (y < (view_yview - safe_zone))
    || (y > (view_yview + view_hview + safe_zone)))
{
    instance_destroy();
}
