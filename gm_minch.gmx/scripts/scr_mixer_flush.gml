// Calculates the final color mix & values and send them to the scoring manager

var total_value = 0;
var mixed_color = 0;
var isMixDifferentFromEntry = false;

var mixed_colors_list = ds_list_create();

var number_of_enemies = ds_stack_size(self.mixEntries);

if (number_of_enemies > 0)
{
    // iterate through self.mixEntries and mix colors (int)
    
    while (!ds_stack_empty(self.mixEntries))
    {
        var entry = ds_stack_pop(self.mixEntries);
        
        var entry_value = ds_list_find_value(entry, 0);
        var entry_color = ds_list_find_value(entry, 1);
        
        //show_debug_message("entry value = " + string(entry_value));
        //show_debug_message("entry color = " + string(entry_color));
        
        total_value += entry_value;
        
        if (entry_color == global.BK)
        {
            // Black breaks the mix
            mixed_color = global.BK;
        }
        if (mixed_color == global.BK)
        {
            // Universal color, any color will fit
        }
        else if (ds_list_find_index(global.SECONDARY_COLORS, mixed_color) >= 0)
        {
            // We are in the secondary circle, only opposed color can improve mix
            if ((mixed_color + entry_color) >= global.BR)
            {
                mixed_color = global.BR;
            }
        }
        else if (ds_list_find_index(mixed_colors_list, entry_color) < 0)
        {
            // We mix primary colors
            ds_list_add(mixed_colors_list, entry_color);
            mixed_color += entry_color;
        }
        
        if ((isMixDifferentFromEntry == false)
           && ((number_of_enemies - ds_stack_size(self.mixEntries)) > 1)
           && (entry_color != mixed_color))
        {
            // We mixed more than 1 entry
            isMixDifferentFromEntry = true;
        }
    }
    
    if (mixed_color < global.BK)
    {
        // We earn a special multiplier if we mixed well
        total_value = total_value * number_of_enemies;
    }
    
    //show_debug_message("=>> mixed color = " + string(mixed_color));
    //show_debug_message("=>> total value = " + string(total_value));
    
    // Increment enemy kill counter with mixed color if different fromany entry color
    if (isMixDifferentFromEntry)
    {
        ds_map_replace(global.ennemyKilled, mixed_color, ds_map_find_value(global.ennemyKilled, mixed_color) + 1);
        show_debug_message("scr_mixer_flush color" + string(ds_map_find_value(global.ennemyKilled, mixed_color)));
        scr_scoring_update(total_value, mixed_color);
        
        // Call event linked to enemy count mechanic
        with (obj_door)
        {
            event_user(0);
        }
    }
}
