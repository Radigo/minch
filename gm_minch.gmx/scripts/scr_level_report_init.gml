// Level end report sequence init

// Sequence vars
self.completeTime = 40;// Time when the "complete" label appears
self.scoreTime = 100;// Time when the score appears
self.inviteTime = 140;// Time where player has a choice if any
self.fadeTime = 0;// Time when the fade start
self.faderDuration = 200;// Fade to black (exit report if no invite)

self.reportTicker = 0;// Global ticker
self.flashTicker = 0;
self.flashTickerLimit = 4;

self.faderAlpha = 0;
self.depth = -100000;

self.cursor = instance_create(0, 0, obj_cursor);
self.cursor.visible = false;
self.cursor.depth = -100001;

// Logic
self.hasScore = true;
self.isHighScore = false;
self.isGameOver = global.extends < 0;
self.playerInvite = false;// True to wait for player choice during end sequence
self.inviteSelectIndex = 0;
self.selectIndexMax = 2;

// Gameplay
scr_all_bullet_cancel();

// Audio
audio_sound_gain(global.currentBGM, 0, 2000);

// MinCH
global.minchControlIsActive = false;

global.legsStatus = global.LEGS_IDLE;
global.bodyStatus = global.BODY_IDLE;

if (global.gameMode == global.ARCADE_MODE) {
    // flashy notification on high score
    // Game over doesn"'t allow continue
    self.playerInvite = false;
    if (self.isGameOver && (global.normalGameScore > ds_list_find_value(global.normalGameScores, 0))) {
        self.isHighScore = true;    
    }
}

if (global.gameMode == global.STORY_MODE) {
    // continue or retry on game over
    self.playerInvite = self.isGameOver;
    self.hasScore = false;
}

if (global.gameMode == global.SCOREATTACK_MODE) {
    // flashy notification on high score
    // continue or retry on each lost life
    self.playerInvite = true;
    
    var levelHighScore = ds_map_find_value(global.scoreAttackScores, room_get_name(global.currentRoom));
    if (!self.isGameOver && (levelHighScore != undefined) && (global.normalGameScore > levelHighScore)) {
        self.isHighScore = true;    
    }
}
