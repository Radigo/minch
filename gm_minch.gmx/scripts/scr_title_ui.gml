// Applies to title screen cursor
var cursor_min_y = 132;

var cursor_index = 0;
var cursor_index_max = 0;

// Exits game anywhere from the title screen
if (keyboard_lastkey = vk_escape)
{
    game_end();
}

// Settings for each page
switch (global.titlepage)
{
    case PAGE_TITLE:
        cursor_index = global.title_entry;
        cursor_index_max = 3;
        break;
    case PAGE_OPTIONS:
        cursor_index = global.options_entry;
        cursor_index_max = 3;
        break;
    case PAGE_KEYCONFIG:
        cursor_index = global.key_config_step;
        cursor_index_max = 0;
        break;
}

var cursor_max_y = 132 + (cursor_index_max * 16);

// show_debug_message("You pressed " + string(keyboard_lastkey));

if (global.titlepage = PAGE_KEYCONFIG)
{
    switch (global.key_config_step)
    {
        case 0:
            global.key_up = keyboard_lastkey;
            break;
        case 1:
            global.key_down = keyboard_lastkey;
            break;
        case 2:
            global.key_left = keyboard_lastkey;
            break;
        case 3:
            global.key_right = keyboard_lastkey;
            break;
        case 4:
            global.key_a = keyboard_lastkey;
            break;
        case 5:
            global.key_b = keyboard_lastkey;
            scr_settings("saveKeys");
            global.titlepage = PAGE_OPTIONS;
            break;
    }
    global.key_config_step += 1;
    exit;
}
else
{
    switch (keyboard_lastkey)
    {
        case vk_up:
            if (cursor_index > 0)
            {
                cursor_index -= 1;
            }
            break;
        case vk_down:
            if (cursor_index < cursor_index_max)
            {
                cursor_index += 1;
            }
            break;
        case vk_enter:
            switch (global.titlepage)
            {
                case PAGE_TITLE:
                    global.title_entry = cursor_index;
                    switch(cursor_index)
                    {
                        case 0:
                            room_goto(1);
                            break;
                        case 1:
                            break;
                        case 2:
                            break;
                        case 3:
                            cursor_index = 0;
                            global.titlepage = PAGE_OPTIONS;
                            break;
                    }
                    break;
                case PAGE_OPTIONS:
                    global.options_entry = cursor_index;
                    switch(cursor_index)
                    {
                        case 0:
                            global.key_config_step = 0;
                            global.titlepage = PAGE_KEYCONFIG;
                            break;
                        case 1:
                            scr_settings("resetKeys");
                            break;
                        case 2:
                            scr_settings("clearSavedData");
                            break;
                        case 3:
                            global.titlepage = PAGE_TITLE;
                            break;
                    }
                    break;
            }
            break;
    }
}

y = cursor_min_y + (16 * cursor_index);

switch (global.titlepage)
{
    case PAGE_TITLE:
        global.title_entry = cursor_index;
        break;
    case PAGE_OPTIONS:
        global.options_entry = cursor_index;
        break;
    case PAGE_KEYCONFIG:
        break;
}
