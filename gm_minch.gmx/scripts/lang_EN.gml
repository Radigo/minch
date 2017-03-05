/** English language file */
var key = argument0;

switch (key)
{
    // Title Screen
    case "title_start" :
        return "Start";
    case "title_continue" :
        return "Continue";
    case "title_scoreattack" :
        return "Score attack";
    case "title_options" :
        return "Options...";
    case "title_quit" :
        return "Press 'Q' to quit game";
    // Options screen
    case "options_keys" :
        return "Configure keys";
    case "options_keyup" :
        return "Press UP key";
    case "options_keydown" :
        return "Press DOWN key";
    case "options_keyleft" :
        return "Press LEFT key";
    case "options_keyright" :
        return "Press RIGHT key";
    case "options_keya" :
        return "Press A key";
    case "options_keyb" :
        return "Press B key";
    case "options_keysdefault" :
        return "Reset key config";
    case "options_clearsave" :
        return "Clear save data";
    case "options_back" :
        return "back to title";
}

return "no_text";
