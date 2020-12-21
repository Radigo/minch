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
    case "title_leaderboards":
        return "Leaderboards...";
    case "title_options":
        return "Options...";
    case "title_quit":
        return "ESC >> Quit game";
    case "title_back":
        return "ESC >> Back";
    case "title_inputmodekeyboard":
        return "Input mode: keyboard";
    case "title_inputmodectrl":
        return "Input mode: controller";
    // Score attack
    case "scoreattack_start":
        return "Start level";
    case "scoreattack_select":
        return "< level";
    case "scoreattack_select_end":
        return ">";
    // Leaderboard screen
    case "leaderboard_title":
        return "Hall of Fame";
    case "leaderboard_normalgame":
        return "< Normal Game >";
    case "leaderboard_scoreattack":
        return "< Score Attack >";
    // Options screen
    case "keyboard":
        return "Keyboard";
    case "options_keys":
        return "Configure keys";
    case "options_gpad":
        return "Configure controller";
    case "options_keyup":
        return "Press UP";
    case "options_keydown":
        return "Press DOWN";
    case "options_keyleft":
        return "Press LEFT";
    case "options_keyright":
        return "Press RIGHT";
    case "options_keya":
        return "Press A";
    case "options_keyb":
        return "Press B";
    case "options_keystart":
        return "Press Start";
    case "options_keysdefault":
        return "Reset controls";
    case "options_clearsave":
        return "Clear progress";
    case "options_back":
        return "back to title";
    // GUI
    case "level_complete":
        return "Level Complete";
    case "skip_intro":
        return "Start >>";
    
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
        return "Cave";
    case "rm_lvl_23_name":
        return "Generator";
    case "rm_lvl_31_name":
        return "Tower";
    case "rm_lvl_32_name":
        return "Rooftops";
    case "rm_lvl_33_name":
        return "Rage";
    case "rm_lvl_41_name":
        return "Nest";
    case "rm_lvl_42_name":
        return "Ancestors";
    case "rm_lvl_43_name":
        return "Trash";
    case "rm_lvl_51_name":
        return "Humans";
    
    // Lore
    case "intro_message":
        return "> Loc. node:#City Core Tower LV.min26#DC dept.#supply command room#
> Override delivery instr. operator:#- DC officer rank4#
> Special delivery ID:#- MNC#
> Destination:#- City border, Hangar Pink49###
> Command:#- > Deliver <";
}

return "no_text";
