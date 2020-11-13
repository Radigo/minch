// Applies to title screen cursor
var cursor_x = 28;
var cursor_min_y = 132;

// Cursor is Vertical
var v_cursor_index = 0;
var v_cursor_index_max = 0;

// Played sound
var played_sound_id = noone;

// Exits game anywhere from the title screen
if (keyboard_lastkey = vk_escape)
{
    // TODO: change this for an exit invite popup (eventually pause game)
    game_end();
}

// Console
if (keyboard_check_released(global.key_start))
{
    scr_console_controls();
}

// Settings for each page
switch (global.titlepage)
{
    case PAGE_TITLE:
        v_cursor_index = global.title_entry;
        v_cursor_index_max = 3;
        break;
    case PAGE_SCOREATTACK:
        v_cursor_index = global.page_scoreattack_entry;
        v_cursor_index_max = 1;
        break;
    case PAGE_OPTIONS:
        v_cursor_index = global.options_entry;
        v_cursor_index_max = 3;
        break;
    case PAGE_KEYCONFIG:
        v_cursor_index = global.key_config_step;
        v_cursor_index_max = 0;
        break;
}

var cursor_max_y = 132 + (v_cursor_index_max * 16);

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
            break;
        case 6:
            global.key_start = keyboard_lastkey;
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
        case global.key_up:
            if (v_cursor_index > 0)
            {
                played_sound_id = snd_ui_select;
                v_cursor_index -= 1;
            }
            break;
        case global.key_down:
            if (v_cursor_index < v_cursor_index_max)
            {
                played_sound_id = snd_ui_select;
                v_cursor_index += 1;
            }
            break;
        case global.key_left:
            switch (global.titlepage)
            {
                case PAGE_SCOREATTACK:
                    if ((v_cursor_index = 0)
                        && (room_previous(global.currentRoom) != -1)
                        && (scr_is_room_level(room_get_name(room_previous(global.currentRoom)))))
                    {
                        played_sound_id = snd_ui_tick;
                        global.currentRoom = room_previous(global.currentRoom);
                    }
                    break;
            }
            break;
        case global.key_right:
            switch (global.titlepage)
            {
                case PAGE_SCOREATTACK:
                    if ((v_cursor_index = 0)
                        && (room_next(global.currentRoom) != -1)
                        && scr_is_room_ok_for_scoreattack(room_get_name(room_next(global.currentRoom))))
                    {
                        played_sound_id = snd_ui_tick;
                        global.currentRoom = room_next(global.currentRoom);
                    }
                    break;
            }
            break;
        case global.key_a:
        case global.key_start:
            switch (global.titlepage)
            {
                case PAGE_TITLE:
                    global.title_entry = v_cursor_index;
                    switch(v_cursor_index)
                    {
                        case 0:// Start
                            // played_sound_id = snd_ui_start;// TODO: add start game sound FX
                            global.gameMode = global.STORY_MODE;
                            global.currentRoom = global.init_room;
                            room_goto(global.currentRoom);
                            break;
                        case 1:// Continue
                            // played_sound_id = snd_ui_start;// TODO: add start game sound FX
                            if (global.applicationMode != global.DEMO_MODE)
                            {
                                global.gameMode = global.STORY_MODE;
                                
                                var level = ds_map_find_value(global.map_list, scr_get_room_id(global.lastMap));
                                
                                if (room_exists(level))
                                {
                                    global.currentRoom = level;
                                    show_debug_message(global.currentRoom);
                                    room_goto(global.currentRoom);
                                }
                            }
                            break;
                        case 2:// Score Attack
                            played_sound_id = snd_ui_confirm;
                            if (global.applicationMode != global.DEMO_MODE)
                            {
                                v_cursor_index = 0;
                                global.titlepage = PAGE_SCOREATTACK;
                            }
                            break;
                        case 3:// Options
                            played_sound_id = snd_ui_confirm;
                            v_cursor_index = 0;
                            global.titlepage = PAGE_OPTIONS;
                            break;
                    }
                    break;
                case PAGE_SCOREATTACK:
                    global.page_scoreattack_entry = v_cursor_index;
                    switch(v_cursor_index)
                    {
                        case 0:
                            // played_sound_id = snd_ui_start;// TODO: add start game sound FX
                            global.gameMode = global.SCOREATTACK_MODE;
                            room_goto(global.currentRoom);
                            break;
                        case 1:
                            played_sound_id = snd_ui_cancel;
                            global.titlepage = PAGE_TITLE;
                            v_cursor_index = 2;// Score attack entry index
                            break;
                    }
                    break;
                case PAGE_OPTIONS:
                    global.options_entry = v_cursor_index;
                    switch(v_cursor_index)
                    {
                        case 0:
                            played_sound_id = snd_ui_select;
                            global.key_config_step = 0;
                            global.titlepage = PAGE_KEYCONFIG;
                            break;
                        case 1:
                            // played_sound_id = snd_ui_delete;
                            scr_settings("resetKeys");
                            break;
                        case 2:
                            // played_sound_id = snd_ui_delete;
                            scr_settings("clearSavedData");
                            break;
                        case 3:
                            played_sound_id = snd_ui_cancel;
                            global.titlepage = PAGE_TITLE;
                            v_cursor_index = 3;// Option entry index
                            break;
                    }
                    break;
            }
            break;
    }
}

if (played_sound_id != noone)
{
    audio_play_sound(played_sound_id, 0, false);
}

self.x = cursor_x;
self.y = cursor_min_y + (16 * v_cursor_index);

switch (global.titlepage)
{
    case PAGE_TITLE:
        global.title_entry = v_cursor_index;
        break;
    case PAGE_SCOREATTACK:
        global.page_scoreattack_entry = v_cursor_index;
        break;
    case PAGE_OPTIONS:
        global.options_entry = v_cursor_index;
        break;
    case PAGE_KEYCONFIG:
        break;
}
