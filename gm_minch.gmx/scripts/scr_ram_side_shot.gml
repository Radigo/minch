if (argument0 == 3)
{
    // Big spread as the head arrives down
    scr_pattern_spread(obj_boss_warehouse_head.x, obj_boss_warehouse_head.y, 0, 3, 3, 24, 180);
}

// Side shots along the neck elements
for (var i = 0; i < instance_number(obj_boss_warehouse_neck); i++)
{
    with (instance_find(obj_boss_warehouse_neck, i))
    {
        scr_bullet_shot(self.x, self.y, scr_get_moreorless(0, 6), 2, 2);
        scr_bullet_shot(self.x, self.y, scr_get_moreorless(180, 6), 2, 2);
    }
}
