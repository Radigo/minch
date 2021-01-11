/** Try to put here all config stuff */

// List all valid levels in the game
scr_map_rooms();
scr_init_leaderboards();

// SETTINGS
scr_settings("loadLang");
scr_settings("loadKeys");
scr_settings("loadGPad");
scr_settings("loadControlType");
scr_settings("loadProgress");
scr_settings("loadLeaderboards");

// CONTROLS
global.UP = "ctrlUp";
global.DOWN = "ctrlDown";
global.LEFT = "ctrlLeft";
global.RIGHT = "ctrlRight";
global.A = "ctrlA";
global.B = "ctrlB";
global.C = "ctrlC";
global.START = "ctrlStart";

global.axisThreshold = 0.5;

global.CONTROLS = ds_list_create();
ds_list_add(global.CONTROLS, global.UP, global.DOWN, global.LEFT, global.RIGHT,global.A, global.B, global.C, global.START);

// UI
global.PAGE_TITLE = "pageTitle";
global.PAGE_STORY = "pageStory";
global.PAGE_SCOREATTACK = "pageScoreAttack";
global.PAGE_LEADERBOARD = "pageLeaderboard";
global.PAGE_OPTIONS = "pageOptions";
global.PAGE_KEYCONFIG = "pageKeyconfig";

//show_debug_message("language: " + global.language);
global.wscale = 3;

// Fonts
global.comboFont = font_add_sprite_ext(spr_combofont, "0123456789", false, 1);
global.scoreFont = font_add_sprite_ext(spr_scorefont, "0123456789", false, 1);
global.doorsFont = font_add_sprite_ext(spr_doorsfont, "0123456789", false, 1);

// Scoring Mechanics
global.CY = 1;
global.MA = 2;
global.YE = 4;

global.PU = 3;
global.GR = 5;
global.RG = 6;// (Can't be "OR" for orange because it's reserved)

global.BR = 7;

global.BK = 8;

global.PRIMARY_COLORS = ds_list_create();
ds_list_add(global.PRIMARY_COLORS, global.CY, global.MA, global.YE);

global.SECONDARY_COLORS = ds_list_create();
ds_list_add(global.SECONDARY_COLORS, global.PU, global.GR, global.RG);

global.defaultLeaderboardName = "MNC";

// Switches & events
global.ENEMY_TRIGGER_ON = "enemyTriggerOn";// Switch turns enemy ON
global.ENEMY_TRIGGER_OFF = "enemyTriggerOff";// Switch turns enemy OFF
global.START_CINEMATIC = "startCinematic";// Launch a predifined cinematic on dynamic object
global.CAMERA_FOCUS_ENEMY_ON = "cameraFocusEnemyOn";// Start focuses on enemy
global.CAMERA_FOCUS_ENEMY_ON_PERSISTENT = "cameraFocusEnemyOnPersistent";// Start persistent focuses on enemy (keep after death)
global.CAMERA_FOCUS_ENEMY_OFF = "cameraFocusEnemyOff";// Stop focuses on enemy
global.DOOR_OPEN = "doorOpen";// Opens a closed door
global.DOOR_CLOSE = "doorClose";// Closes an opened door
global.CREATE_PLATFORM = "createPlatform";// Replaces targeted dynamic obect with platform
global.CHANGE_STATUS_ACTIVE = "changeStatusActive";// Changes status for active
global.CHANGE_STATUS_INACTIVE = "changeStatusInactive";// Changes status for inactive
global.TELEPORT_PLAYER_TO = "teleportPlayerTo";// Send MinCH to destination

// Game engine
global.ARCADE_MODE = "arcadeMode";// Continuous play through all levels
global.STORY_MODE = "storyMode";// Continuous play through all levels with infinite lives and no score
global.SCOREATTACK_MODE = "scoreAttackMode";// Single level
global.gameMode = global.ARCADE_MODE;

// Application release
global.DEBUG_MODE = "debugMode";// Using during development
global.DEMO_MODE = "demoMode";// Used for pre-release and demos
global.RELEASE_MODE = "releaseMode";// Used for real!

global.applicationMode = global.DEBUG_MODE;

switch (global.applicationMode) {
    case global.DEBUG_MODE:
        global.init_room = rm_lvl_11;
        global.allowConsole = true;
        global.initLives = 2;
        break;
    case global.DEMO_MODE:
        global.init_room = rm_lvl_12;
        global.allowConsole = true;
        global.initLives = 2;
        break;
    case global.RELEASE_MODE:
        global.init_room = rm_lvl_11;
        global.allowConsole = false;
        global.initLives = 2;
        break;
}

global.currentRoom = undefined;

// BGM
global.bgmSequenceLoop = "bgmSequenceLoop";// Wait the end of bgm loop to change bgm
global.bgmSequenceMeasure = "bgmSequenceMeasure";// Change bgm at current bgm measure end
global.bgmSequenceInstant = "bgmSequenceInstant";// Instantly change bgm

global.bgmSequencing = global.bgmSequenceMeasure;
global.currentBGM = noone;
global.nextBGM = noone;

// Let's go gringo!
room_goto(rm_title);
