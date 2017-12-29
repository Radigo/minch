var remainingEnemies = enemyCount - ds_map_find_value(global.ennemyKilled, self.color);

if (remainingEnemies <= 0)
{
    scr_add_door_anim_object(global.DOOR_OPEN, self.id);
    scr_change_door_triggered_instance(global.DOOR_OPEN, self.id);
}
