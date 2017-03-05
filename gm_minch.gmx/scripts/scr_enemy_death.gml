// Handle enemy and death
// Used inside enemy script, self refeers to enemy

var add_score = argument0;
var is_mixing_object = argument1;

if (add_score)
{
    // Scoring
    var str = object_get_name(self.id.object_index);
    // Get the last 2 characters of the object name to set color
    var str_color = string_char_at(str, (string_length(str) - 1)) + string_char_at(str, (string_length(str) - 0));
    
    if (is_mixing_object)
    {
        scr_mixer_update(other, self.value, scr_colors_str_to_int(str_color));
    }
    else
    {
        scr_scoring_update(self.value, scr_colors_str_to_int(str_color));
    }
}

// FX
scr_boom(self.x, self.y, self.explosionLevel, self.explosionSize);

// Dispose
with (self) instance_destroy();
