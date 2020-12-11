// Console mechanics

// Execute input
show_debug_message("console_action: " + argument0 + ", param: " + argument1);

switch (argument0)
{
    case "help":
    case "?":
        show_message("Console commands: map [ID], stats [on-off], exit, end (e), fs, wscale [1-10], iddad, idclip, checkpoint (cp) [1-9], kill (k)");
        break;
    case "map":
        if (argument1 != "")
        {
            var map = ds_map_find_value(global.map_list, "rm_lvl_");
            
            if (room_exists(map))
            {
                show_debug_message("jump to map: " + room_get_name(map));
                global.currentRoom = map;
                room_goto(global.currentRoom);
            }
        }
        break;
    case "checkpoint":
    case "cp":
        scr_pass_checkpoint(real(argument1), global.currentBGM, global.bgmSequenceInstant);
        break;
    case "kill":
    case "k":
        scr_minch_death("deus_ex");
        break;
    case "end":
    case"e":
        instance_create(0, 0, obj_level_report);
        break;
    case "reset":
    case"r":
        room_goto(global.currentRoom);
        break;
    case "stats":
        if (argument1 = "off")
        {
            show_debug_overlay(false);
        }
        else
        {
            show_debug_overlay(true);
        }
        break;
    case "exit":
        game_end();
    case "fs":
        if window_get_fullscreen()
        {
            window_set_fullscreen(false);
            window_set_size(320 * global.wscale, 240 * global.wscale);
        }
        else
        {
            window_set_fullscreen(true);
        }
        break;
    case "wscale":
        var scale = real(argument1);
        
        if (scale < 1)
        {
            scale = 1;
        }
        else if (scale > 10)
        {
            scale = 10;
        }
        
        global.wscale = scale;
        
        window_set_size(320 * global.wscale, 240 * global.wscale);
        break;
    case "iddad":
        global.invincible = !global.invincible;
        break;
    case "idclip":
    case "idspispopd":
        global.clip = ! global.clip;
        break;
        
        
        // DEBUG
    case "t":
        break;
}

keyboard_string = "";
