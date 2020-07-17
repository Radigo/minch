// Toggle console

if (!global.allowConsole)
{
    exit;
}

var parse_step = "action";
var console_action = "";
var console_param = "";

for (i = 1; i < string_length(keyboard_string) + 1; i++)
{
    var char = string_char_at(keyboard_string, i);
    
    // Ignore controls keys (doesn't work, we try to compare chars and ascii codes)
    switch (char) {
        case global.key_up:
        case global.key_down:
        case global.key_left:
        case global.key_right:
        case global.key_a:
        case global.key_b:
        case global.key_start:
            show_debug_message("- ignoring");
            continue;
        case " ":
            show_debug_message("- validating");
            if (parse_step = "action") {
                parse_step = "param";
            } else if (parse_step = "param") {
                continue;
            }
            break;
        default:
            show_debug_message("- iterating");
            if (parse_step = "action") {
                console_action += char;
            } else if (parse_step = "param") {
                console_param += char;
            }
            break;
    }
}

scr_console(console_action, console_param);
