show_debug_message("scr_napalmdeath_init");

self.ticker = 0;

with (obj_katana_shield)
    instance_destroy();

// Creates (move) hole at death location
with (obj_ch1hole) {
    self.depth = 100;
    self.x = obj_groundlaser.x;
    self.y = obj_groundlaser.y;
}

scr_all_bullet_cancel();
