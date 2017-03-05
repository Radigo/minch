/** This object draw the texts on the screen */
var pos_y = 132;

draw_set_font(font_wide);
draw_set_halign(fa_left);
draw_set_color(c_gray);

switch (global.titlepage)
{
    case PAGE_TITLE:
        // Title texts
        draw_text(128, pos_y, scr_text("title_start"));
        if (global.applicationMode == global.DEMO_MODE)
        {
            draw_set_color(c_dkgray);
        }
        draw_text(128, (pos_y + 16), scr_text("title_continue"));
        draw_text(128, (pos_y + 32), scr_text("title_scoreattack"));
        
        draw_set_color(c_gray);
        draw_text(128, (pos_y + 48), scr_text("title_options"));
        break;
    case PAGE_SCOREATTACK:
        // Level Select
        draw_text(128, pos_y, scr_text("scoreattack_select"));
        draw_text(256, pos_y, string(scr_get_room_id(global.currentRoom)));
        draw_text(128, (pos_y + 16), scr_text("options_back"));
        break;
    case PAGE_OPTIONS:
        // Option texts
        draw_text(128, pos_y, scr_text("options_keys"));
        draw_text(128, (pos_y + 16), scr_text("options_keysdefault"));
        draw_text(128, (pos_y + 32), scr_text("options_clearsave"));
        draw_text(128, (pos_y + 48), scr_text("options_back"));
        break;
    case PAGE_KEYCONFIG:
        // Option key config
        switch (global.key_config_step)
        {
            case 0:
                draw_text(128, pos_y, scr_text("options_keyup"));
                break;
            case 1:
                draw_text(128, pos_y, scr_text("options_keydown"));
                break;
            case 2:
                draw_text(128, pos_y, scr_text("options_keyleft"));
                break;
            case 3:
                draw_text(128, pos_y, scr_text("options_keyright"));
                break;
            case 4:
                draw_text(128, pos_y, scr_text("options_keya"));
                break;
            case 5:
                draw_text(128, pos_y, scr_text("options_keyb"));
                break;
            case 6:
                draw_text(128, pos_y, scr_text("options_keystart"));
                break;
        }
        
        break;
}

draw_set_font(font_small);
draw_set_color(c_dkgray);

draw_text(8, 224, scr_text("title_quit"));
draw_set_halign(fa_right);
draw_text(312, 224, game_display_name);
draw_set_halign(fa_left);

if (global.GP)
{
    draw_text(8, 200, scr_text("title_joystick"));
}
