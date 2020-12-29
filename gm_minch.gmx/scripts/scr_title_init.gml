self.flashTicker = 0;
self.flashTickerLimit = 4;

// Lock continue and score attack if no score have been done yet
global.canSelectStage = (global.lastMapName != "rm_lvl_11") && (global.applicationMode != global.DEMO_MODE);

/** Title pages can be:
"title"
"score attack"
"leaderboards"
"options"
"keyconfig" */

/** Index of chosen entry in title page, links to:
story
arcade
score attack
options */
global.title_entry = 0;

/** Index of chosen entry in story page, links to:
continue
start 
continue becomes default when we have a progress (canSelectStage)
*/
global.page_story_entry = 0;

/** Index of chosen entry in score attack page, links to:
level start
level select */
global.page_scoreattack_entry = 0;

/** Index of chosen entry in leaderboard page, links to:
Normal game ranking
Score Attack ranking */
global.page_leaderboard_entry = 0;

/** Index of chosen entry in options page, links to:
key config
key default
clear save data
back to title */
global.options_entry = 0;

/** Key config step index:
up
down
left
right
a
b */
global.key_config_step = 0;
self.rawInputMode = false;

// Reorder depths (objects depths seems automatically managed depending on their Y)
obj_title_bg.depth = 100;
obj_title_towers.depth = 90;
obj_title_fg.depth = 80;
obj_title_logo.depth = 0;
obj_title_content.depth = 10;
obj_cursor.depth = 20;

if (global.currentRoom == undefined) {
    // First display of title
    global.titlepage = global.PAGE_TITLE;
} else if (global.gameMode == global.SCOREATTACK_MODE) {
    // Coming after a score attack attempt
    global.titlepage = global.PAGE_SCOREATTACK;
} else if (global.gameMode == global.ARCADE_MODE) {
    // Coming after a game with scoring, display leaderboard
    // We have to fake page change because step script expects an input
    global.leaderboardPage = 0;
    global.titlepage = global.PAGE_LEADERBOARD;
    obj_title_logo.visible = false;
    
    obj_cursor.x = 26;
    obj_cursor.y = 204;
} else if (global.gameMode == global.STORY_MODE) {
    global.titlepage = global.PAGE_TITLE;
}

global.currentRoom = global.init_room;
