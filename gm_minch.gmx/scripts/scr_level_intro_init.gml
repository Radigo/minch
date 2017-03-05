// Level intro sequence init

self.faderDuration = 120;
self.levelNameDuration = 180;
self.levelNameFadeDuration = 60;

self.introDuration = self.levelNameDuration + self.levelNameFadeDuration;
self.introTicker = 0;// Global ticker

self.faderAlpha = 1;
self.nameAlpha = 1;
self.levelName = scr_text(string(room_get_name(global.currentRoom)) + "_name");
