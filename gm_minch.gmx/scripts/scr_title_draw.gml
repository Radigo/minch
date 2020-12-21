self.flashTicker++;

if (self.flashTicker > self.flashTickerLimit) {
    self.flashTicker = 0;
}

var flashColor = c_dkgray;
if (self.flashTicker > (self.flashTickerLimit * 0.5)) {
    flashColor = c_ltgray;
}

/** This object draw the texts on the screen */
var pos_x = 30;
var pos_y = 132;

draw_set_font(font_wide);
draw_set_halign(fa_left);
draw_set_color(c_gray);

switch (global.titlepage)
{
    case global.PAGE_TITLE:
        // Title texts
        draw_text(pos_x, pos_y, scr_text("title_start"));
        if (!global.canContinue) {
            draw_set_color(c_dkgray);
        }
        draw_text(pos_x, (pos_y + 16), scr_text("title_continue"));
        draw_text(pos_x, (pos_y + 32), scr_text("title_scoreattack"));
        
        draw_set_color(c_gray);
        draw_text(pos_x, (pos_y + 48), scr_text("title_leaderboards"));
        draw_text(pos_x, (pos_y + 64), scr_text("title_options"));
        break;
    case global.PAGE_SCOREATTACK:
        // Level Select
        draw_text(pos_x, pos_y, scr_text("scoreattack_select"));
        draw_text(pos_x + 56, pos_y, string(scr_get_room_id(global.currentRoom)));
        draw_text(pos_x + 76, pos_y, scr_text("scoreattack_select_end"));
        draw_text(pos_x, (pos_y + 16), scr_text("options_back"));
        break;
    case global.PAGE_LEADERBOARD:
        // Leaderboards
        draw_set_font(font_wide);
        draw_set_halign(fa_center);
        draw_text(70, 27, scr_text("leaderboard_title"));
        draw_set_font(font_small);
        pos_y = 46;
        
        switch (global.leaderboardPage) {
            case 0:
                draw_text(70, pos_y, scr_text("leaderboard_normalgame"));
                pos_y += 16;
                
                for (var i = 0; i < ds_list_size(global.normalGameScores); i++) {
                    if (i == global.newNormalGameHighScoreIndex) {
                        draw_set_colour(flashColor);
                    } else {
                        draw_set_color(c_gray);
                    }
                    
                    draw_set_halign(fa_left);
                    draw_text(pos_x, pos_y + (i * 12), string(i + 1));
                    draw_set_halign(fa_right);
                    draw_text(104, pos_y + (i * 12), string(ds_list_find_value(global.normalGameScores, i)));
                }
                
                draw_set_color(c_gray);
                break;
            case 1:
                draw_text(70, pos_y, scr_text("leaderboard_scoreattack"));
                pos_y += 16;
                
                for (var i = 0; i < ds_list_size(global.orderedLevelNames); i++) {
                    var levelName = ds_list_find_value(global.orderedLevelNames, i);
                    
                    if (ds_map_find_value(global.scoreAttackScores, levelName) != undefined) {
                        var world_id = string_char_at(levelName, string_length(levelName) - 1);
                        var level_id = string_char_at(levelName, string_length(levelName));
                        
                        if (ds_list_find_index(global.newScoreAttackHighScoreLevels, levelName) >= 0) {
                            draw_set_color(flashColor);
                        } else {
                            draw_set_color(c_gray);
                        }
                        
                        draw_set_halign(fa_left);
                        draw_text(pos_x, pos_y + (i * 10), world_id + "-" + level_id);
                        draw_set_halign(fa_right);
                        draw_text(104, pos_y + (i * 10), string(ds_map_find_value(global.scoreAttackScores, levelName)));
                    }
                    
                    draw_set_color(c_gray);
                }
                break;
        }
        draw_set_halign(fa_left);
        draw_set_font(font_wide);
        draw_text(pos_x, 204, scr_text("options_back"));
        break;
    case global.PAGE_OPTIONS:
        // Option texts
        draw_text(pos_x, pos_y, "<" + scr_controls_get_description() + ">");
        if (global.control_type < 0) {
            draw_text(pos_x, (pos_y + 16), scr_text("options_keys"));
        } else {
            draw_text(pos_x, (pos_y + 16), scr_text("options_gpad"));
        }
        draw_text(pos_x, (pos_y + 32), scr_text("options_keysdefault"));
        draw_text(pos_x, (pos_y + 48), scr_text("options_clearsave"));
        draw_text(pos_x, (pos_y + 64), scr_text("options_back"));
        break;
    case global.PAGE_KEYCONFIG:
        // Option key config
        switch (global.key_config_step) {
            case 0:
                draw_text(pos_x, pos_y, scr_text("options_keyup"));
                break;
            case 1:
                draw_text(pos_x, pos_y, scr_text("options_keydown"));
                break;
            case 2:
                draw_text(pos_x, pos_y, scr_text("options_keyleft"));
                break;
            case 3:
                draw_text(pos_x, pos_y, scr_text("options_keyright"));
                break;
            case 4:
                draw_text(pos_x, pos_y, scr_text("options_keya"));
                break;
            case 5:
                draw_text(pos_x, pos_y, scr_text("options_keyb"));
                break;
            case 6:
                draw_text(pos_x, pos_y, scr_text("options_keystart"));
                break;
        }
        break;
}

draw_set_font(font_small);
draw_set_color(c_dkgray);

draw_text(8, 224, scr_text("title_quit"));

if (global.control_type < 0) {
    draw_text(96, 224, scr_text("title_inputmodekeyboard"));
} else {
    draw_text(96, 224, scr_text("title_inputmodectrl"));
}

draw_set_halign(fa_right);
draw_text(312, 224, game_display_name);
draw_set_halign(fa_left);
