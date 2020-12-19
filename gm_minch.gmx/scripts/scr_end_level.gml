show_debug_message("scr_end_level");

var has_won = argument0;

// Kill events/actions maps
ds_map_destroy(global.actions_map);
ds_map_destroy(global.rules_map);
ds_map_destroy(global.events);

// Particles
scr_particles_dispose();

var nextRoom = room_next(room);

switch (global.gameMode) {
    case global.STORY_MODE:
        if (has_won && (global.applicationMode != global.DEMO_MODE)) {
            //TODO: check if next room is null (last level) to avoid crash
            if (scr_is_room_level(nextRoom, false)) {
                global.currentRoom = nextRoom;
                scr_settings("saveProgress");
            }
        } else {
            scr_leaderboard_add_normalgame_score(global.normalGameScore, true);
            scr_settings("saveLeaderboards");
            nextRoom = rm_title;
        }
        break;
    case global.SCOREATTACK_MODE:
        scr_leaderboard_add_scoreattack_score(global.normalGameScore, room_get_name(global.currentRoom), true);
        scr_settings("saveLeaderboards");
        nextRoom = rm_title;
        break;
}


// Stop BGM
global.currentBGM = noone;
global.nextBGM = noone;
audio_stop_all();

room_goto(nextRoom);
