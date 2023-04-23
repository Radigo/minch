// Handle enemy and death
// Used inside enemy script, self refeers to enemy

var add_score = argument0;
var is_mixing_object = argument1;

if (add_score)
{
    if (is_mixing_object)
    {
        scr_mixer_update(other, self.value, self.color);
    }
    else
    {
        scr_scoring_update(self.value, self.color, self, false, 1);
    }
}

// FX
scr_boom(self.x, self.y, self.explosionLevel, self.explosionSize);

// Update ennemy kill counter
ds_map_replace(global.ennemyKilled, self.color, ds_map_find_value(global.ennemyKilled, self.color) + 1);
show_debug_message("scr_enemy_death " + string(ds_map_find_value(global.ennemyKilled, self.color)) + " of color: " + string(self.color) + " of value: " + string(self.value) + " @ " + string(self.x) + ", " + string(self.y));
// Call event linked to enemy count mechanic
with (obj_door) {
    event_user(0);
}

// Dispose
with (self) instance_destroy();
