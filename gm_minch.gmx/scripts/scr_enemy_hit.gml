// Handle enemy life and death
var is_piercing_shot = false;
var is_mixing_object = false;
var damage = 10;

switch (string(object_get_name(other.object_index)))
{
    case "obj_minch_feets":
        if (global.legsStatus == global.LEGS_JUMP)
        {
            exit;
        }
        is_piercing_shot = true;
        damage = 100;
        break;
        
    case "obj_claw_hitbox":
        is_piercing_shot = true;
        is_mixing_object = true;
        damage = 20;
        break;
    
    case "obj_wave_attack":
        is_piercing_shot = true;
        is_mixing_object = true;
        damage = 2;
        break;
        
    case "obj_groundlaser":
        is_piercing_shot = true;
        is_mixing_object = false;
        damage = 200;
        break;
        
    case "obj_shot":
    default:
        is_piercing_shot = false;
        damage = 10;
        break;
}

var safe_zone = 8;// Outbounds distance until bullets can be shot

// If emitter is off screen, don't shoot
if ((x < (view_xview - safe_zone))
    || (x > (view_xview + view_wview + safe_zone))
    || (y < (view_yview - safe_zone))
    || (y > (view_yview + view_hview + safe_zone)))
{
    damage = 0;
}

//show_debug_message("ennemy: " + string(self.id) + ", shield: " + string(self.shield) + ", hit by: " + string(damage) + ", hp: " + string(self.hp) + ", scale:" + string(self.image_xscale));
//show_debug_message("Other: " + string(other.id) + ", " + string(object_get_name(other.object_index)) + ", " + string(other.object_index));

scr_shot_sparkles(self.shield, other, is_piercing_shot);

if (!is_piercing_shot)
{
    with (other)
    {
        instance_destroy();
    }
}

if (!self.shield)
{
    self.hp -= damage;
    audio_play_sound(snd_shot_hit, 0, false);
    self.lastHitTicker = 0;
}
else
{
    audio_play_sound(snd_shot_shield, 0, false);
}

if (self.hp <= 0)
{
    scr_enemy_death(true, is_mixing_object);
}
