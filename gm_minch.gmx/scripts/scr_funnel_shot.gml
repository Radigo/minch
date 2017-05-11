ratio = argument0 / argument1;

shot_angle = 90 - (90 * ratio);// from 90 to 0
bullet_speed = 2 + (2 * ratio);


scr_bullet_shot((self.x - 46), (self.y - 12), scr_get_moreorless((-90 - shot_angle), 5), scr_get_moreorless(bullet_speed, 0.8), 3);
scr_bullet_shot((self.x + 46), (self.y - 12), scr_get_moreorless((-90 + shot_angle), 5), scr_get_moreorless(bullet_speed, 0.8), 3);
