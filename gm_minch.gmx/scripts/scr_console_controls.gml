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
    if (string_char_at(keyboard_string, i) = " ")
    {
        if (parse_step = "action")
        {
            parse_step = "param";
        }
        else if (parse_step = "param")
        {
            break;
        }
    }
    else
    {
        if (parse_step = "action")
        {
            console_action += string_char_at(keyboard_string, i);
        }
        else if (parse_step = "param")
        {
            console_param += string_char_at(keyboard_string, i);
        }
    }
}

scr_console(console_action, console_param);
