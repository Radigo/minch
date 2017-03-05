with (obj_boss_warehouse)
{
    // Reset all self tickers
    self.ticker = 0;
}

// Base becomes vunerable when head and shield are gone
if (!instance_exists(obj_boss_warehouse_shield)
    && !instance_exists(obj_boss_warehouse_head))
{
    with (obj_boss_warehouse_base)
    {
        self.shield = false;
    }
}
