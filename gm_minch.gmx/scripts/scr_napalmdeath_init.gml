show_debug_message("scr_napalmdeath_init");

self.ticker = 0;

with (obj_katana_shield)
    instance_destroy();

// Creates (move) hole at death location
with (obj_ch1hole) {
    self.depth = 100;
    if (instance_exists(obj_groundlaser)) {
        self.x = obj_groundlaser.x;
        self.y = obj_groundlaser.y;
    } else {
        self.x = obj_napalmdeath.x;
        self.y = obj_napalmdeath.y;
    }
}

scr_all_bullet_cancel();
