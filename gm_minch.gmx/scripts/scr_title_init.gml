/** Title pages can be:
"title"
"options"
"keyconfig" */
global.titlepage = PAGE_TITLE;

/** Index of chosen entry in title page, links to:
start
continue
score attack
options */
global.title_entry = 0;

/** Index of chosen entry in score attack page, links to:
level start
level select */
global.page_scoreattack_entry = 0;

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

// Reorder depths (objects depths seems automatically managed depending on their Y)
obj_title_bg.depth = 100;
obj_title_towers.depth = 90;
obj_title_fg.depth = 80;
obj_title.depth = 0;
obj_title_texts.depth = 10;
obj_cursor.depth = 20;
