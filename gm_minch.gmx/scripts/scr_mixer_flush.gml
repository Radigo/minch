// Calculates the final color mix & values and send them to the scoring manager

//show_debug_message("scr_mixer_flush================================");

var total_value = 0;
var mixed_color = 0;
var isMixSuccess = false;// If we mixed different colors successfully

var mixed_colors_list = ds_list_create();
var numPrimaries = 0;
var numSecondaries = 0;

var number_of_enemies = ds_stack_size(self.mixEntries);

if (number_of_enemies > 0)
{
    // iterate through self.mixEntries and mix colors (int)
    
    while (!ds_stack_empty(self.mixEntries))
    {
        var entry = ds_stack_pop(self.mixEntries);
        
        var entry_value = ds_list_find_value(entry, 0);
        var entry_color = ds_list_find_value(entry, 1);
        
        //show_debug_message("entry value = " + string(entry_value) + ", color = " + string(entry_color));
        
        total_value += entry_value;
        
        if (entry_color == global.BK) {
            // Black breaks the mix
            mixed_color = global.BK;
        } else if (ds_list_find_index(mixed_colors_list, entry_color) < 0) {
            // We mix colors
            ds_list_add(mixed_colors_list, entry_color);
            mixed_color += entry_color;
            if (ds_list_find_index(global.PRIMARY_COLORS, entry_color) >= 0) {
                numPrimaries++;
            } else if (ds_list_find_index(global.SECONDARY_COLORS, entry_color) >= 0) {
                numSecondaries++;
            }
        }
    }
    
    //show_debug_message("=>> mixed color = " + string(mixed_color) + ", value = " + string(total_value));
    
    /* Mixing rules:
    1 - We cannot mix over brown
        1.1 - We cannot mix two secondary colors
        1.2 - We cannot mix Brown with anything else
        1.3 - We cannot mix more than 3 different colors
    2 - We cannot mix secondary color with one of its primary base
        2.1 - Mix result of primary + secondary must be brown
    */
    
    if (ds_list_size(mixed_colors_list) > 1) {
        if (numSecondaries == 1) {// rule 2
            isMixSuccess = (mixed_color == global.BR);
            if (!isMixSuccess) {
                mixed_color = global.BK;
            }
        } else if (mixed_color < global.BK) {// rule 1
            isMixSuccess = true;
        }  
    }
    
    if (isMixSuccess) {
        // We earn a special multiplier if we mixed well
        total_value = total_value * number_of_enemies;
        // Increment enemy kill counter with mixed color
        ds_map_replace(global.ennemyKilled, mixed_color, ds_map_find_value(global.ennemyKilled, mixed_color) + 1);
        // Call event linked to enemy count mechanic
        with (obj_door) {
            event_user(0);
        }
        //show_debug_message("isMixSuccess color: " + string(ds_map_find_value(global.ennemyKilled, mixed_color)));
    }
    
    // Combo increment is the total number of enemies in the mix.
    // It could also be based on the level of mix (primary x 1, secondary x 2, tertiary x 4)
    scr_scoring_update(total_value, mixed_color, self, isMixSuccess, number_of_enemies);
}
