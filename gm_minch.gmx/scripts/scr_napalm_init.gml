scr_ai_init();

// Room coordinates
self.col0 = 176;
self.col1 = 320;// Don't add in list
self.col2 = 464;

self.xList = ds_list_create();
ds_list_add(self.xList, self.col0, self.col2);

self.row0 = 172;
self.row1 = 236;
self.row2 = 300;
self.row3 = 364;

self.yList = ds_list_create();
ds_list_add(self.yList, self.row0, self.row1, self.row2, self.row3);

// Init at random X and top Y
self.targetX = self.xList[| irandom(1)];
self.targetY = self.yList[| 0];

// Phases
self.ONE_KATANA = "phase1katana";
self.TWO_KATANAS = "phase2katanas";
self.FOUR_KATANAS = "phase4katanas";
self.DIYING = "phaseDiying";

// Ugly way of having a death state (hp = zero w/o instance destroy yet)
self.hp = 1200;
self.phaseTwoHp = 1100;
self.phaseFourHp = 1050;
self.phaseFinaleHp = 1000;

// Patterns
self.REACH_SIDE = "reachside";
self.SEARCH_MINCH_Y = "searchminchy";
self.RUSH_MINCH = "rushminch";
self.RUSH_SLASH = "rushslasha";
self.RUSH_SLASH_BIS = "rushslashb";
self.TRANSITION = "transition";

self.slashDirection = 0;// -0: left, +0: right (x scale)

// Init
self.isIntro = true;
self.currentPhase = self.ONE_KATANA;
self.currentPattern = self.REACH_SIDE;

