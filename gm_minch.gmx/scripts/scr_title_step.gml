var inputKey = -1;
var escPressed = keyboard_check_pressed(vk_escape);

if (self.rawInputMode) {
    // Raw input mode is to map controls, we can't mix gamepad and keyboard there
    if (global.control_type < 0) {
        for (var key = 2; key < 200; key++) {
            if (keyboard_check_pressed(key)) {
                inputKey = key;
                //show_debug_message("scr_title_step rawInputKey: " + string(inputKey));
                break;
            }
        }
    } else if (scr_controls_gamepad_check(global.control_type)) {
        for (var inp = 0; inp < gamepad_button_count(global.control_type); inp++) {
            if (gamepad_button_check_pressed(global.control_type, inp)) {
                inputKey = inp;
                break;
            }
        }
    } else {
        // No valid input mode
        global.titlepage = global.PAGE_OPTIONS;
        self.rawInputMode = false;
        v_cursor_index = 1;
    }
} else {
    // Both input types work in menu
    // Keyboard
    if (keyboard_check_pressed(global.key_up)) {
        inputKey = global.UP;
    } else if (keyboard_check_pressed(global.key_down)) {
        inputKey = global.DOWN;
    } else if (keyboard_check_pressed(global.key_left)) {
        inputKey = global.LEFT;
    } else if (keyboard_check_pressed(global.key_right)) {
        inputKey = global.RIGHT;
    } else if (keyboard_check_pressed(global.key_a)) {
        inputKey = global.A;
    } else if (keyboard_check_pressed(global.key_b)) {
        inputKey = global.B;
    } else if (keyboard_check_pressed(vk_escape)) {
        inputKey = global.B;
    } else if (keyboard_check_pressed(global.key_start)) {
        inputKey = global.START;
    // Gamepad
    } else if (gamepad_button_check_pressed(global.control_type, global.pad_up)) {
        inputKey = global.UP;
    } else if (gamepad_button_check_pressed(global.control_type, global.pad_down)) {
        inputKey = global.DOWN;
    } else if (gamepad_button_check_pressed(global.control_type, global.pad_left)) {
        inputKey = global.LEFT;
    } else if (gamepad_button_check_pressed(global.control_type, global.pad_right)) {
        inputKey = global.RIGHT;
    } else if (gamepad_button_check_pressed(global.control_type, global.pad_a)) {
        inputKey = global.A;
    } else if (gamepad_button_check_pressed(global.control_type, global.pad_b)) {
        inputKey = global.B;
    } else if (gamepad_button_check_pressed(global.control_type, global.pad_start)) {
        inputKey = global.START;
    }
}

if (inputKey < 0) {
    return false;
    
}

//show_debug_message("scr_title_step inputKey: " + string(inputKey));
//show_debug_message("global.control_type: " + string(global.control_type));

// Applies to title screen cursor

var cursor_x = 26;
var cursor_min_y = 132;

// Cursor is Vertical
var v_cursor_index = 0;
var v_cursor_index_max = 0;

// Played sound
var played_sound_id = noone;

// Settings for each page
var goBack = false;

switch (global.titlepage) {
    case global.PAGE_TITLE:
        v_cursor_index = global.title_entry;
        v_cursor_index_max = 4;
        break;
    case global.PAGE_STORY:
        v_cursor_index = global.page_story_entry;
        if (global.canSelectStage) {
            v_cursor_index_max = 2;
        } else {
            v_cursor_index_max = 1;
        }
        break;
    case global.PAGE_SCOREATTACK:
        v_cursor_index = global.page_scoreattack_entry;
        v_cursor_index_max = 1;
        break;
    case global.PAGE_LEADERBOARD:
        v_cursor_index = global.page_leaderboard_entry;
        v_cursor_index_max = 0;
        global.leaderboardPageMax = 1;
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

if (global.titlepage == global.PAGE_KEYCONFIG) {
    //show_debug_message("global.key_config_step: " + string(global.key_config_step));
    if (escPressed) {
        // Abort remapping
        global.titlepage = global.PAGE_OPTIONS;
        self.rawInputMode = false;
        v_cursor_index = 1;
        scr_settings("loadKeys");
    } else {
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
                scr_controls_configure_key(global.C, inputKey);
                break;
            case 7:
                scr_controls_configure_key(global.START, inputKey);
                if (scr_controls_gamepad_check(global.control_type)) {
                    scr_settings("saveGPad");
                } else {
                    scr_settings("saveKeys");
                }
                global.titlepage = global.PAGE_OPTIONS;
                self.rawInputMode = false;
                v_cursor_index = 1;
                break;
        }
        global.key_config_step += 1;
        return false;
    }
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
                    if ((v_cursor_index == 0)
                        && (room_previous(global.currentRoom) != -1)
                        && (scr_is_room_level(room_get_name(room_previous(global.currentRoom)), true))) {
                        played_sound_id = snd_ui_tick;
                        global.currentRoom = room_previous(global.currentRoom);
                    }
                    break;
                case global.PAGE_OPTIONS:
                    // switch control type
                    if (v_cursor_index == 0) {
                        var controlType = global.control_type;
                        while (controlType > -1) {
                            // decrement until finding a valid controller
                            controlType--;
                            if (scr_controls_gamepad_check(controlType)) {
                                played_sound_id = snd_ui_tick;
                                global.control_type = controlType;
                                scr_settings("saveControlType");
                                break;
                            }
                        }
                        
                        if (controlType < 0) {
                            played_sound_id = snd_ui_tick;
                            global.control_type = controlType;
                            scr_settings("saveControlType");
                        }
                    }
                    break;
                case global.PAGE_LEADERBOARD:
                    // switch page
                    if (global.leaderboardPage > 0) {
                        played_sound_id = snd_ui_tick;
                        global.leaderboardPage -= 1;
                    }
                    break;
            }
            break;
        case global.RIGHT:
            switch (global.titlepage) {
                case global.PAGE_SCOREATTACK:
                    if ((v_cursor_index == 0)
                        && (room_next(global.currentRoom) != -1)
                        && scr_is_room_level(room_get_name(room_next(global.currentRoom)), true)) {
                        played_sound_id = snd_ui_tick;
                        global.currentRoom = room_next(global.currentRoom);
                    }
                    break;
                case global.PAGE_OPTIONS:
                    // switch control type
                    if (v_cursor_index == 0) {
                        var controlType = global.control_type;
                        while (controlType < 12) {
                            // increment until finding a valid controller
                            controlType++;
                            if (scr_controls_gamepad_check(controlType)) {
                                played_sound_id = snd_ui_tick;
                                global.control_type = controlType;
                                scr_settings("saveControlType");
                                break;
                            }
                        }
                    }
                    break;
                case global.PAGE_LEADERBOARD:
                    // switch page
                    if (global.leaderboardPage < global.leaderboardPageMax) {
                        played_sound_id = snd_ui_tick;
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
                        case 0:// Story mode
                            played_sound_id = snd_ui_confirm;
                            v_cursor_index = 0;
                            global.titlepage = global.PAGE_STORY;
                            break;
                        case 1:// Arcade mode
                            played_sound_id = snd_ui_start;
                            global.gameMode = global.ARCADE_MODE;
                            global.normalGameScore = 0;
                            global.lastCheckpoint = 0;
                            global.extends = global.initLives;
                            if (global.applicationMode == global.DEMO_MODE) {
                                global.currentRoom = global.init_room;
                            } else {
                                global.fromIntro = true;
                                global.currentRoom = rm_title_start;
                            }
                            room_goto(global.currentRoom);
                            break;
                        case 2:// Score Attack
                            if (global.canSelectStage) {
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
                            obj_title_logo.visible = false;
                            break;
                        case 4:// Options
                            played_sound_id = snd_ui_confirm;
                            v_cursor_index = 0;
                            global.titlepage = global.PAGE_OPTIONS;
                            break;
                    }
                    break;
                case global.PAGE_STORY:
                    played_sound_id = snd_ui_start;
                    global.gameMode = global.STORY_MODE;
                    global.normalGameScore = 0;
                    
                    if (global.canSelectStage) {
                        switch(v_cursor_index) {
                            case 0:// Continue
                                var level = ds_map_find_value(global.allLevels, global.lastMapName);
                                if (room_exists(level)) {
                                    global.fromIntro = false;
                                    global.currentRoom = level;
                                    global.lastCheckpoint = 0;
                                    global.extends = global.initLives;
                                    room_goto(global.currentRoom);
                                }
                                break;
                            case 1:// Start Over
                                global.lastCheckpoint = 0;
                                global.extends = global.initLives;
                                if (global.applicationMode == global.DEMO_MODE) {
                                    global.currentRoom = global.init_room;
                                } else {
                                    global.fromIntro = true;
                                    global.currentRoom = rm_title_start;
                                }
                                room_goto(global.currentRoom);
                                break;
                            case 2:// Back
                                goBack = true;
                                break;
                        }
                    } else {
                        switch(v_cursor_index) {
                            case 0:// Start Over
                                global.lastCheckpoint = 0;
                                global.extends = global.initLives;
                                if (global.applicationMode == global.DEMO_MODE) {
                                    global.currentRoom = global.init_room;
                                } else {
                                    global.fromIntro = true;
                                    global.currentRoom = rm_title_start;
                                }
                                room_goto(global.currentRoom);
                                break;
                            case 1:// Back
                                goBack = true;
                                break;
                        }
                    }
                    break;
                case global.PAGE_SCOREATTACK:
                    global.page_scoreattack_entry = v_cursor_index;
                    switch(v_cursor_index) {
                        case 0:
                            played_sound_id = snd_ui_start;
                            global.gameMode = global.SCOREATTACK_MODE;
                            global.lastCheckpoint = 0;
                            global.normalGameScore = 0;
                            global.extends = 0;
                            global.fromIntro = false;
                            room_goto(global.currentRoom);
                            break;
                        case 1:
                            goBack = true;
                            break;
                    }
                    break;
                case global.PAGE_LEADERBOARD:
                    goBack = true;
                    break;
                case global.PAGE_OPTIONS:
                    global.options_entry = v_cursor_index;
                    switch(v_cursor_index) {
                        case 1:
                            played_sound_id = snd_ui_select;
                            global.key_config_step = 0;
                            self.rawInputMode = true;
                            global.titlepage = global.PAGE_KEYCONFIG;
                            v_cursor_index = 0;
                            break;
                        case 2:
                            played_sound_id = snd_ui_delete;
                            scr_settings("resetControls");
                            break;
                        case 3:
                            played_sound_id = snd_ui_delete;
                            scr_settings("clearSavedData");
                            scr_settings("loadLeaderboards");
                            global.canSelectStage = false;
                            break;
                        case 4:
                            goBack = true;
                            break;
                    }
                    break;
            }
            break;
        case global.B:
            goBack = true;
            break;
    }
}

if (goBack) {
    // Back if in sub menu
    switch (global.titlepage) {
        case global.PAGE_TITLE:
            if (escPressed) {
                game_end();
            }
            break;
        case global.PAGE_STORY:
            played_sound_id = snd_ui_cancel;
            v_cursor_index = 0;// Story entry index
            break;
        case global.PAGE_SCOREATTACK:
            played_sound_id = snd_ui_cancel;
            v_cursor_index = 2;// Score attack entry index
            break;
        case global.PAGE_LEADERBOARD:
            played_sound_id = snd_ui_cancel;
            v_cursor_index = 3;// Leaderboard entry index
            obj_title_logo.visible = true;
            break;
        case global.PAGE_OPTIONS:
            played_sound_id = snd_ui_cancel;
            v_cursor_index = 4;// Option entry index
            break;
    }
    global.titlepage = global.PAGE_TITLE;
}

if (played_sound_id != noone) {
    scr_play_sound(played_sound_id, global.SFX_UI, false);
}

switch (global.titlepage) {
    case global.PAGE_TITLE:
        global.title_entry = v_cursor_index;
        break;
    case global.PAGE_STORY:
        global.page_story_entry = v_cursor_index;
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

obj_cursor.x = cursor_x;
obj_cursor.y = cursor_min_y + (16 * v_cursor_index);
