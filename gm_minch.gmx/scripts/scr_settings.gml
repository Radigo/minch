var action = argument0;

ini_open("m_save.ini");

switch (action) {
    // CONTROLS
    case "loadKeys":
        global.key_up = ini_read_real("keys", "up", vk_up);
        global.key_down = ini_read_real("keys", "down", vk_down);
        global.key_left = ini_read_real("keys", "left", vk_left);
        global.key_right = ini_read_real("keys", "right", vk_right);
        global.key_a = ini_read_real("keys", "a", vk_control);
        global.key_b = ini_read_real("keys", "b", vk_alt);
        global.key_c = ini_read_real("keys", "c", vk_space);
        global.key_start = ini_read_real("keys", "start", vk_enter);
        break;
    case "saveKeys":
        ini_write_real("keys", "up", global.key_up);
        ini_write_real("keys", "down", global.key_down);
        ini_write_real("keys", "left", global.key_left);
        ini_write_real("keys", "right", global.key_right);
        ini_write_real("keys", "a", global.key_a);
        ini_write_real("keys", "b", global.key_b);
        ini_write_real("keys", "c", global.key_c);
        ini_write_real("keys", "start", global.key_start);
        break;
    case "loadGPad":
        global.pad_up = ini_read_real("gpad", "up", gp_padu);
        global.pad_down = ini_read_real("gpad", "down", gp_padd);
        global.pad_left = ini_read_real("gpad", "left", gp_padl);
        global.pad_right = ini_read_real("gpad", "right", gp_padr);
        global.pad_a = ini_read_real("gpad", "a", gp_face1);
        global.pad_b = ini_read_real("gpad", "b", gp_face2);
        global.pad_c = ini_read_real("gpad", "c", gp_face3);
        global.pad_start = ini_read_real("gpad", "start", gp_start);
        break;
    case "saveGPad":
        ini_write_real("gpad", "up", global.pad_up);
        ini_write_real("gpad", "down", global.pad_down);
        ini_write_real("gpad", "left", global.pad_left);
        ini_write_real("gpad", "right", global.pad_right);
        ini_write_real("gpad", "a", global.pad_a);
        ini_write_real("gpad", "b", global.pad_b);
        ini_write_real("gpad", "c", global.pad_c);
        ini_write_real("gpad", "start", global.pad_start);
        break;
    case "loadControlType":
        global.control_type = ini_read_real("controltype", "index", -1);
        break;
    case "saveControlType":
        ini_write_real("controltype", "index", global.control_type);
        break;
    case "resetControls":
        global.key_up = vk_up;
        global.key_down = vk_down;
        global.key_left = vk_left;
        global.key_right = vk_right;
        global.key_a = vk_control;
        global.key_b = vk_alt;
        global.key_b = vk_space;
        global.key_start = vk_enter;
        scr_settings("saveKeys");
        
        global.pad_up = gp_padu;
        global.pad_down = gp_padd;
        global.pad_left = gp_padl;
        global.pad_right = gp_padr;
        global.pad_a = gp_face1;
        global.pad_b = gp_face2;
        global.pad_c = gp_face3;
        global.pad_start = gp_start;
        scr_settings("saveGPad");
        
        global.control_type = -1;
        scr_settings("saveControlType");
        break;
    
    // LANGUAGE
    case "loadLang":
        global.language = ini_read_string("global", "lang", "EN");
        break;
    case "saveLang":
        ini_write_string("global", "lang", global.language);
        break;
    
    // PROGRESS
    case "loadProgress":
        global.lastMapName = ini_read_string("progress", "map", "rm_lvl_11");
        show_debug_message("Loading last map " + global.lastMapName);
        break;
    case "saveProgress":
        global.lastMapName = room_get_name(global.currentRoom);
        ini_write_string("progress", "map", global.lastMapName);
        show_debug_message("Saving last map " + global.lastMapName);
        break;
    case "clearSavedData":
        ini_write_string("progress", "map", "rm_lvl_11");
        global.lastMapName = "rm_lvl_11";
        
        ini_section_delete("leaderboard");
        ini_section_delete("scoreattack");
        scr_init_leaderboards();
        break;
        
    // HI SCORES
    case "loadLeaderboards":
        // 10 scores for nomal game
        for (var i = 0; i < 10; i++) {
            var normalGameScore = ini_read_string("leaderboard", string(i), "");
            if (normalGameScore != "") {
                scr_leaderboard_add_normalgame_score(real(normalGameScore), false);
            }
        }
        // All levels for score attack
        for (var i = 0; i < ds_list_size(global.orderedLevelNames); i++) {
            var levelName = ds_list_find_value(global.orderedLevelNames, i);
            var scoreAttackSave = ini_read_string("scoreattack", levelName, "");
            if (scoreAttackSave != "") {
                scr_leaderboard_add_scoreattack_score(real(scoreAttackSave), levelName, false);
            }
        }
        break;

    case "saveLeaderboards":
        // 10 scores for nomal game
        for (var i = 0; i < ds_list_size(global.normalGameScores); i++) {
            ini_write_string("leaderboard", string(i), string(ds_list_find_value(global.normalGameScores, i)));
        }
        // All levels for Score Attack
        for (var i = 0; i < ds_list_size(global.orderedLevelNames); i++) {
            var levelName = ds_list_find_value(global.orderedLevelNames, i);
            var levelScore = ds_map_find_value(global.scoreAttackScores, levelName);
            if (levelScore != undefined) {
                ini_write_string("scoreattack", levelName, string(levelScore));
            }
        }
        break;
}

ini_close();
