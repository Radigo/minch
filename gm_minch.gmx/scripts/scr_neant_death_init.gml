scr_ai_init();

scr_switch_machine(2);
scr_register_dynamic_object(4, global.CAMERA_FOCUS_ENEMY_ON);
scr_register_dynamic_object(5, global.CAMERA_FOCUS_ENEMY_OFF);
scr_switch_machine(4);

// Audio
audio_sound_gain(global.currentBGM, 0, 500);

self.shield = true;

self.tickerLimit = 10000;// Overall counter
self.patternTickerLimit = 20;// For explosions
self.speed = 1.5;// init death travel speed
