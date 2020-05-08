var MAX_BULLETS = 30;
var boomStrength = 1 - (max(self.hp, 1) / self.MAX_HP);

show_debug_message("ROCK destroy with " + string(self.MAX_HP) + " / " + string(self.hp) + " hp = " + string(boomStrength));

scr_pattern_spread(self.x, self.y, 0, 1, 3, MAX_BULLETS * boomStrength, 360);

for (var i = 0; i < (MAX_BULLETS * boomStrength); i++) {
    scr_bullet_shot(scr_get_moreorless(self.x, 16), scr_get_moreorless(self.y, 16), random(360), scr_get_moreorless(1, 0.6), 2);
}

if (self.core != noone) instance_destroy(self.core);
