scr_ai_init();

self.shield = true;
self.tickerLimit = 60;

//List management
self.enemyNumIndex = 0;
self.listIndex = 0;

// Default required values
self.enemySpeed = 1;
self.generatorAngleMin = 0;
self.generatorAngleMax = 0;
self.enemyList = ds_list_create();
self.enemiesAreRandom = true;// False to throw fixed patterns of colors
self.numEnemies = 10;

self.depth = -100;
self.image_index = 0;
self.image_speed = 0;
