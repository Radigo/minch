/** Try to put here all config stuff */

// SETTINGS

scr_settings("loadLang");
scr_settings("loadKeys");
scr_settings("loadProgress");

//show_debug_message("language: " + global.language);
global.wscale = 2;

// Fonts
global.comboFont = font_add_sprite_ext(spr_combofont, "0123456789", false, 1);
global.scoreFont = font_add_sprite_ext(spr_scorefont, "0123456789", false, 1);

// Scoring Mechanics
global.CY = 1;
global.MA = 2;
global.YE = 4;

global.PU = 3;
global.GR = 5;
global.RG = 6;// Can't be "or" because it's reserved)

global.BR = 7;

global.BK = 8;

global.PRIMARY_COLORS = ds_list_create();
ds_list_add(global.PRIMARY_COLORS, global.CY, global.MA, global.YE);

global.SECONDARY_COLORS = ds_list_create();
ds_list_add(global.SECONDARY_COLORS, global.PU, global.GR, global.RG);

// Switches & events
global.ENEMY_TRIGGER_ON = "enemyTriggerOn";// Switch turns enemy ON
global.ENEMY_TRIGGER_OFF = "enemyTriggerOff";// Switch turns enemy OFF
global.START_CINEMATIC = "startCinematic";// Launch a predifined cinematic on dynamic object
global.CAMERA_FOCUS_BOSS_ON = "cameraFocusBossOn";// Start focuses on boss (or triggered ON enemy)
global.CAMERA_FOCUS_ENEMY_ON = "cameraFocusEnemyOn";// Start focuses on enemy
global.CAMERA_FOCUS_ENEMY_OFF = "cameraFocusEnemyOff";// Stop focuses on enemy
global.DOOR_OPEN = "doorOpen";// Opens a closed door
global.DOOR_CLOSE = "doorClose";// Closes an opened door
global.CREATE_PLATFORM = "createPlatform";// Replaces targeted dynamic obect with platform

// Game engine
global.STORY_MODE = "storyMode";// Continuous play through all levels
global.SCOREATTACK_MODE = "scoreAttackMode";// Single level
global.gameMode = global.STORY_MODE;

global.NUM_LEVELS = 15;
global.EXTENDED_NUM_LEVELS = 25;

// Application release
global.DEBUG_MODE = "debugMode";// Using during development
global.DEMO_MODE = "demoMode";// Used for pre-release and demos
global.RELEASE_MODE = "releaseMode";// Used for real!

global.applicationMode = global.DEBUG_MODE;

switch (global.applicationMode)
{
    case global.DEBUG_MODE:
        global.map_list = ds_map_create();
        scr_map_rooms(global.map_list);
        global.init_room = rm_lvl_11;
        global.allowConsole = true;
        global.initLives = 3;
        break;
    case global.DEMO_MODE:
        global.init_room = rm_lvl_21;
        global.allowConsole = true;
        global.initLives = 3;
        break;
    case global.RELEASE_MODE:
        global.map_list = ds_map_create();
        scr_map_rooms(global.map_list);
        global.init_room = rm_lvl_11;
        global.allowConsole = false;
        global.initLives = 3;
        break;
}

global.currentRoom = global.init_room;

// BGM
global.bgmSequenceLoop = "bgmSequenceLoop";// Wait the end of bgm loop to change bgm
global.bgmSequenceMeasure = "bgmSequenceMeasure";// Change bgm at current bgm measure end
global.bgmSequenceInstant = "bgmSequenceInstant";// Instantly change bgm

global.bgmSequencing = global.bgmSequenceMeasure;
global.currentBGM = noone;
global.nextBGM = noone;

// Let's go gringo!
room_goto(rm_title);
