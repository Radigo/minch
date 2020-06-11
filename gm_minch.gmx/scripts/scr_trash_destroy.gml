// Spawns trash death
scr_all_bullet_cancel();

//show_debug_message("scr_trash_destroy");

instance_create(self.x, self.y, obj_trash_death);
