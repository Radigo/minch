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
    
    var fxPosX = 0;
    var fxPosY = 0;
    var fxScaleX = 1;
    // Add flash fx
    if (string_pos("_v_", self.name) > 0) {
        // Vertical door
        fxPosX = 10;
        fxPosY = -13;
        fxScaleX = 1;
    } else if (string_pos("_h_", self.name) > 0) {
        // Horizontal door
        fxPosX = 3;
        fxPosY = 3;
        fxScaleX = 0.8;
    }
    var flashFx = instance_create(self.x + fxPosX, self.y + fxPosY, obj_door_counter_fx);
    flashFx.image_xscale = fxScaleX;
    flashFx.image_speed = 0.5;
    flashFx.depth = self.depth - 1;
}

self.remainingEnemies = newRemainingEnemies;
