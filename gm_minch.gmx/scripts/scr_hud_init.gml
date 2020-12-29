self.hasScore = true;
self.highScore = 0;
self.levelName = scr_get_room_id(global.currentRoom);

if (global.gameMode == global.ARCADE_MODE) {
    if (ds_list_size(global.normalGameScores) > 0) {
        self.highScore = ds_list_find_value(global.normalGameScores, 0);
    }
} else if (global.gameMode == global.SCOREATTACK_MODE) {
    if (ds_map_find_value(global.scoreAttackScores, room_get_name(global.currentRoom)) != undefined) {
        self.highScore = ds_map_find_value(global.scoreAttackScores, room_get_name(global.currentRoom));
    }
} else if (global.gameMode == global.STORY_MODE) {
    self.hasScore = false;
}
