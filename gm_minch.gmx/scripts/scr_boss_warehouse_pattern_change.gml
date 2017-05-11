with (obj_boss_warehouse)
{
    // Reset all self tickers
    self.isIntroSequence = false;
    self.ticker = 0;
}

// Base becomes vunerable when head and shield are gone

if (argument0 == "head")
{
    with (obj_boss_warehouse_neck)
    {
        //instance_destroy();
    }

    if (!instance_exists(obj_boss_warehouse_shield))
    {
        with (obj_boss_warehouse_base)
        {
            self.shield = false;
        }
    }
    
    self.ticker = 0;
}
else if (!instance_exists(obj_boss_warehouse_head) && (argument0 == "shield"))
{
    with (obj_boss_warehouse_base)
    {
        self.shield = false;
    }
}
