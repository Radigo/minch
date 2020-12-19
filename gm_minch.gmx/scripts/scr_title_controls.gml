var inputKey = argument0;

// Applies to title screen cursor
var cursor_x = 26;
var cursor_min_y = 132;

// Cursor is Vertical
var v_cursor_index = 0;
var v_cursor_index_max = 0;

// Played sound
var played_sound_id = noone;

// Settings for each page
switch (global.titlepage) {
    case global.PAGE_TITLE:
        v_cursor_index = global.title_entry;
        v_cursor_index_max = 4;
        break;
    case global.PAGE_SCOREATTACK:
        v_cursor_index = global.page_scoreattack_entry;
        v_cursor_index_max = 1;
        break;
    case global.PAGE_LEADERBOARD:
        v_cursor_index = global.page_leaderboard_entry;
        v_cursor_index_max = 0;
        global.leaderboardPageMax = 1
        break;
    case global.PAGE_OPTIONS:
        v_cursor_index = global.options_entry;
        v_cursor_index_max = 4;
        break;
    case global.PAGE_KEYCONFIG:
        v_cursor_index = global.key_config_step;
        v_cursor_index_max = 0;
        break;
}

var cursor_max_y = 132 + (v_cursor_index_max * 16);

show_debug_message("scr_title_controls inputKey: " + string(inputKey));
if (global.titlepage == global.PAGE_KEYCONFIG) {
    show_debug_message("global.key_config_step: " + string(global.key_config_step));
    switch (global.key_config_step) {
        case 0:
            scr_controls_configure_key(global.UP, inputKey);
            break;
        case 1:
            scr_controls_configure_key(global.DOWN, inputKey);
            break;
        case 2:
            scr_controls_configure_key(global.LEFT, inputKey);
            break;
        case 3:
            scr_controls_configure_key(global.RIGHT, inputKey);
            break;
        case 4:
            scr_controls_configure_key(global.A, inputKey);
            break;
        case 5:
            scr_controls_configure_key(global.B, inputKey);
            break;
        case 6:
            scr_controls_configure_key(global.START, inputKey);
            //scr_settings("saveKeys");
            global.titlepage = global.PAGE_OPTIONS;
            break;
    }
    global.key_config_step += 1;
    return false;
} else {
    switch (inputKey) {
        case global.UP:
            if (v_cursor_index > 0) {
                played_sound_id = snd_ui_select;
                v_cursor_index -= 1;
            }
            break;
        case global.DOWN:
            if (v_cursor_index < v_cursor_index_max) {
                played_sound_id = snd_ui_select;
                v_cursor_index += 1;
            }
            break;
        case global.LEFT:
            switch (global.titlepage) {
                case global.PAGE_SCOREATTACK:
                    if ((v_cursor_index = 0)
                        && (room_previous(global.currentRoom) != -1)
                        && (scr_is_room_level(room_get_name(room_previous(global.currentRoom)), true))) {
                        played_sound_id = snd_ui_tick;
                        global.currentRoom = room_previous(global.currentRoom);
                    }
                    break;
                case global.PAGE_OPTIONS:
                    // switch control type
                    if (global.control_type > -1) {
                        played_sound_id = snd_ui_select;
                        global.control_type -= 1;
                    }
                    break;
                case global.PAGE_LEADERBOARD:
                    // switch page
                    if (global.leaderboardPage > 0) {
                        played_sound_id = snd_ui_select;
                        global.leaderboardPage -= 1;
                    }
                    break;
            }
            break;
        case global.RIGHT:
            switch (global.titlepage) {
                case global.PAGE_SCOREATTACK:
                    if ((v_cursor_index = 0)
                        && (room_next(global.currentRoom) != -1)
                        && scr_is_room_level(room_get_name(room_next(global.currentRoom)), true)) {
                        played_sound_id = snd_ui_tick;
                        global.currentRoom = room_next(global.currentRoom);
                    }
                    break;
                case global.PAGE_OPTIONS:
                    // switch control type
                    if (scr_controls_check(global.control_type + 1)) {
                        played_sound_id = snd_ui_select;
                        global.control_type += 1;
                    }
                    break;
                case global.PAGE_LEADERBOARD:
                    // switch page
                    if (global.leaderboardPage < global.leaderboardPageMax) {
                        played_sound_id = snd_ui_select;
                        global.leaderboardPage += 1;
                    }
                    break;
            }
            break;
        case global.A:
        case global.START:
            switch (global.titlepage) {
                case global.PAGE_TITLE:
                    global.title_entry = v_cursor_index;
                    switch(v_cursor_index) {
                        case 0:// Start
                            // played_sound_id = snd_ui_start;// TODO: add start game sound FX
                            global.gameMode = global.STORY_MODE;
                            global.normalGameScore = 0;
                            global.fromIntro = true;
                            global.currentRoom = rm_lvl_11;
                            room_goto(rm_title_start);
                            break;
                        case 1:// Continue
                            if (global.canContinue) {
                                // played_sound_id = snd_ui_start;// TODO: add start game sound FX
                                global.gameMode = global.STORY_MODE;
                                global.normalGameScore = 0;
                                global.fromIntro = false;
                                var level = ds_map_find_value(global.allLevels, global.lastMapName);
                                
                                if (room_exists(level)) {
                                    global.currentRoom = level;
                                    show_debug_message(global.currentRoom);
                                    room_goto(global.currentRoom);
                                }
                            }
                            break;
                        case 2:// Score Attack
                            if (global.canContinue) {
                                played_sound_id = snd_ui_confirm;
                                v_cursor_index = 0;
                                global.titlepage = global.PAGE_SCOREATTACK;
                            }
                            break;
                        case 3:// Leaderboards
                            played_sound_id = snd_ui_confirm;
                            v_cursor_index = 0;
                            global.leaderboardPage = 0;
                            global.titlepage = global.PAGE_LEADERBOARD;
                            obj_title.visible = false;
                            break;
                        case 4:// Options
                            played_sound_id = snd_ui_confirm;
                            v_cursor_index = 0;
                            global.titlepage = global.PAGE_OPTIONS;
                            break;
                    }
                    break;
                case global.PAGE_SCOREATTACK:
                    global.page_scoreattack_entry = v_cursor_index;
                    switch(v_cursor_index) {
                        case 0:
                            // played_sound_id = snd_ui_start;// TODO: add start game sound FX
                            global.gameMode = global.SCOREATTACK_MODE;
                            global.normalGameScore = 0;
                            global.fromIntro = false;
                            room_goto(global.currentRoom);
                            break;
                        case 1:
                            played_sound_id = snd_ui_cancel;
                            global.titlepage = global.PAGE_TITLE;
                            v_cursor_index = 2;// Score attack entry index
                            break;
                    }
                    break;
                case global.PAGE_LEADERBOARD:
                    played_sound_id = snd_ui_cancel;
                    global.titlepage = global.PAGE_TITLE;
                    v_cursor_index = 3;// Leaderboard entry index
                    obj_title.visible = true;
                    break;
                case global.PAGE_OPTIONS:
                    global.options_entry = v_cursor_index;
                    switch(v_cursor_index) {
                        case 1:
                            played_sound_id = snd_ui_select;
                            global.key_config_step = 0;
                            global.titlepage = global.PAGE_KEYCONFIG;
                            break;
                        case 2:
                            // played_sound_id = snd_ui_delete;
                            scr_settings("resetControls");
                            break;
                        case 3:
                            // played_sound_id = snd_ui_delete;
                            scr_settings("clearSavedData");
                            scr_settings("loadLeaderboards");
                            break;
                        case 4:
                            played_sound_id = snd_ui_cancel;
                            global.titlepage = global.PAGE_TITLE;
                            v_cursor_index = 4;// Option entry index
                            break;
                    }
                    break;
            }
            break;
    }
}

if (played_sound_id != noone) {
    audio_play_sound(played_sound_id, 0, false);
}

switch (global.titlepage) {
    case global.PAGE_TITLE:
        global.title_entry = v_cursor_index;
        break;
    case global.PAGE_SCOREATTACK:
        global.page_scoreattack_entry = v_cursor_index;
        break;
    case global.PAGE_OPTIONS:
        global.options_entry = v_cursor_index;
        break;
    case global.PAGE_LEADERBOARD:
        global.page_leaderboard_entry = v_cursor_index;
        cursor_min_y = 204;
        break;
    case global.PAGE_KEYCONFIG:
        break;
}

self.x = cursor_x;
self.y = cursor_min_y + (16 * v_cursor_index);
