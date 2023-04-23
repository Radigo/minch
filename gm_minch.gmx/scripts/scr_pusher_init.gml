self.sourceY = self.y;
self.distance = 64;
self.targetY = self.y + distance;
self.direction = -90;
self.speed = 4;

show_debug_message("scr_pusher_init");
scr_play_sound(snd_trash_impact, global.SFX_ENVIRONMENT, false);
