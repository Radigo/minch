var key = argument0;
var init = argument1;

var cursor_min_y = 132;
var cursor_max_y = 132 + (3 * 16);

if (init = "true")
{
    global.title_entry = 0;
    
    global.title_entries[0] = "start";
    global.title_entries[1] = "continue";
    global.title_entries[2] = "scoreattack";
    global.title_entries[3] = "options";
    
    y = cursor_min_y;
    x = 124;
}

show_debug_message("You pressed " + key);


switch (key)
{
    case "up":
        if (global.title_entry > 0)
        {
            global.title_entry -= 1;
        }
        break;
    case "down":
        if (global.title_entry < 3)
        {
            global.title_entry += 1;
        }
        break;
    case "enter":
        switch(global.title_entry)
        {
            case 0:
                room_goto(2);
                break;
            case 1:
                break;
            case 2:
                break;
            case 3:
                room_goto(1);
                break;
        }
        break;
    case "q":
        game_end();
        break;
}

y = cursor_min_y + (16 * global.title_entry);

show_debug_message("global.title_entry: " + string(global.title_entry));
