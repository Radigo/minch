var action = argument0;

global.GP = false;

/* Dig further when you have the motivation...
show_debug_message("-----------------------------------------------------------------------------");
show_debug_message("gamepad_is_supported(): " + string(gamepad_is_supported()));
show_debug_message("gamepad_is_connected(0): " + string(gamepad_is_connected(0)));
show_debug_message("There gamepad_get_description(0): " + string(gamepad_get_description(0)));

var gp_num = gamepad_get_device_count();
for (var i = 0; i < gp_num; i++;)
{
    if gamepad_is_connected(i)
   {
   show_debug_message(string(i) + ": " + gamepad_get_description(i));
   }
    else
   {
   show_debug_message(string(i) + ": No Gamepad Connected");
   }
}

show_debug_message("-----------------------------------------------------------------------------");
   
if (gamepad_is_supported() && gamepad_is_connected(0))
{
    global.GP = true;
}
*/

   
ini_open("m_save.ini");

switch (action)
{
    // KEYS
    case "loadKeys":
        global.key_up = ini_read_real("keys", "up", vk_up);
        global.key_down = ini_read_real("keys", "down", vk_down);
        global.key_left = ini_read_real("keys", "left", vk_left);
        global.key_right = ini_read_real("keys", "right", vk_right);
        global.key_a = ini_read_real("keys", "a", vk_control);
        global.key_b = ini_read_real("keys", "b", vk_alt);
        global.key_start = ini_read_real("keys", "start", vk_enter);
        break;
    case "saveKeys":
        ini_write_real("keys", "up", global.key_up);
        ini_write_real("keys", "down", global.key_down);
        ini_write_real("keys", "left", global.key_left);
        ini_write_real("keys", "right", global.key_right);
        ini_write_real("keys", "a", global.key_a);
        ini_write_real("keys", "b", global.key_b);
        ini_write_real("keys", "start", global.key_start);
        break;
    case "resetKeys":
        global.key_up = vk_up;
        global.key_down = vk_down;
        global.key_left = vk_left;
        global.key_right = vk_right;
        global.key_a = vk_control;
        global.key_b = vk_alt;
        global.key_start = vk_enter;
        scr_settings("saveKeys");
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
        global.lastMap = ini_read_string("progress", "map", "rm_lvl_11");
        show_debug_message("Loading last map");
        show_debug_message(global.lastMap);
        break;
    case "saveProgress":
        global.lastMap = room_get_name(global.currentRoom);
        ini_write_string("progress", "map", global.lastMap);
        show_debug_message("Saving last map");
        show_debug_message(global.lastMap);
        break;
    case "clearSavedData":
        ini_write_string("progress", "map", "rm_lvl_11");
        global.lastMap = "rm_lvl_11";
        break;
}

ini_close();
