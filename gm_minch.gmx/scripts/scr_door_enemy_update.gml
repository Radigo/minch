if (self.enemyCount == 0) {
   return true;
}

var newRemainingEnemies = self.enemyCount - ds_map_find_value(global.ennemyKilled, self.color);

//show_debug_message("scr_door_enemy_update " + object_get_name(self.object_index) + ", remainingEnemies:" + string(self.remainingEnemies));

if (newRemainingEnemies <= 0) {
    scr_change_door_triggered_instance(global.DOOR_OPEN, self.id);
    scr_add_door_anim_object(global.DOOR_OPEN, self.id);
} else if (newRemainingEnemies < self.remainingEnemies) {
    self.flashTicker = self.flashDuration;
}

self.remainingEnemies = newRemainingEnemies;
