name =  object_get_name(object_index);
//parent = object_get_parent(object_index);
//sprite = object_get_sprite(object_index);

var enemyColorStr = string_char_at(name, string_length(name) - 1) + string_char_at(name, string_length(name));
self.color = scr_colors_str_to_int(enemyColorStr);

self.remainingEnemies = -1;
self.flashTicker = -1;
self.flashDuration = 40;// Duration of flash when enemy is killed
