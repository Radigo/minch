/** English language file */
var key = argument0;

switch (key)
{
    // Title Screen
    case "title_start":
        return "Start";
    case "title_continue":
        return "Continue";
    case "title_scoreattack":
        return "Score attack...";
    case "title_options":
        return "Options...";
    case "title_joystick":
        return "Jostick connected: " +  gamepad_get_description(0);
    case "title_quit":
        return "Press 'esc' to quit game";
    // Score attack
    case "scoreattack_start":
        return "Start level";
    case "scoreattack_select":
        return "select level";
    // Options screen
    case "options_keys":
        return "Configure keys";
    case "options_keyup":
        return "Press UP key";
    case "options_keydown":
        return "Press DOWN key";
    case "options_keyleft":
        return "Press LEFT key";
    case "options_keyright":
        return "Press RIGHT key";
    case "options_keya":
        return "Press A key";
    case "options_keyb":
        return "Press B key";
    case "options_keystart":
        return "Press Start key";
    case "options_keysdefault":
        return "Reset key config";
    case "options_clearsave":
        return "Clear progress";
    case "options_back":
        return "back to title";
    // GUI
    case "level_complete":
        return "Level Complete";
    
    // LEVEL NAMES
    case "rm_lvl_11_name":
        return "Unboxing";
    case "rm_lvl_12_name":
        return "Escape";
    case "rm_lvl_13_name":
        return "Guardian";
    case "rm_lvl_21_name":
        return "Dispatcher";
    case "rm_lvl_22_name":
        return "Test Rooms";// Could be better (Glad, Aperture, Shower Curtain...)
    case "rm_lvl_23_name":
        return "Generator";
    case "rm_lvl_31_name":
        return "Exit";
    case "rm_lvl_32_name":
        return "Rooftops";
    case "rm_lvl_33_name":
        return "Honor";
    case "rm_lvl_41_name":
        return "Nest";
    case "rm_lvl_42_name":
        return "Ancestors";
    case "rm_lvl_43_name":
        return "Tower";
    case "rm_lvl_51_name":
        return "Humans";
}

return "no_text";
