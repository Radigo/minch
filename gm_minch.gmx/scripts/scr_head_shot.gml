origin_angle = 0;
origin_x = 0;
origin_y = 0;

for (i = 0; i < 12; i++)
{
    origin_angle = random(pi * 2);
    origin_x = cos(origin_angle) * random(16);
    origin_y = sin(origin_angle) * random(16);
    scr_bullet_shot((obj_boss_warehouse_head.x + origin_x), (obj_boss_warehouse_head.y + origin_y), scr_get_moreorless(-90, 2), (4 + random(2)), 5);
}
