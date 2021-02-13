//show_debug_message("ennemy: " + string(self.id) + ", shield: " + string(self.shield));
//show_debug_message("Other: " + string(other.id) + ", " + string(object_get_name(other.object_index)) + ", " + string(other.object_index));

// Handle enemy life and death
var is_piercing_shot = false;
var is_mixing_object = false;
var damage = 10;

switch (string(object_get_name(other.object_index))) {
    case "obj_minch_feets":
        if (global.controlStatus != global.ALIVE) {
            exit;
        }
        if (global.legsStatus == global.LEGS_JUMP) {
            exit;
        }
        is_piercing_shot = true;
        damage = 20;
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
        damage = 10000;
        self.shield = false;
        break;
    
    case "obj_sunray":
        is_piercing_shot = false;
        is_mixing_object = false;
        damage = 0.2;
        break;
    
    case "obj_neant_rock":
        is_piercing_shot = false;
        is_mixing_object = false;
        damage = 60;
        break;
        
    case "obj_shot":
    default:
        is_piercing_shot = false;
        damage = 10;
        break;
}

// If emitter is off screen, don't hit
if ((x < (view_xview - self.safeZone))
    || (x > (view_xview + view_wview + self.safeZone))
    || (y < (view_yview - self.safeZone))
    || (y > (view_yview + view_hview + self.safeZone)))
{
    return false;
}

//show_debug_message(string(object_get_name(self.object_index)) + " > hit by: " + string(object_get_name(other.object_index)) + ", dmg: " + string(damage) + " > hp: " + string(self.hp) + " (safe zone: " + string(self.safeZone) + ")");

scr_shot_sparkles(self.shield, other, is_piercing_shot);

if (!is_piercing_shot) {
    with (other) {
        instance_destroy();
    }
}

if (!self.shield) {
    self.hp -= damage;
    audio_play_sound(snd_shot_hit, global.SFX_ENVIRONMENT, false);
    self.lastHitTicker = 0;
} else {
    audio_play_sound(snd_shot_shield, global.SFX_ENVIRONMENT, false);
}

if (self.hp <= 0) {
    scr_enemy_death(true, is_mixing_object);
}
