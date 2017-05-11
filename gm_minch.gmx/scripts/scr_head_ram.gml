obj_boss_warehouse_head.x = self.x;

// Movements
if (self.headPatternRamIndex < 1)
{
    // Prepare to ram
   obj_boss_warehouse_head.y -= 0.2;
   
   if (obj_boss_warehouse_head.y < (self.y - 10))
   {
        self.headPatternRamIndex++;
   }
}
else if (self.headPatternRamIndex < 2)
{
    // Move down
    obj_boss_warehouse_head.y += 4;
   
   if (obj_boss_warehouse_head.y > (self.y + 200))
   {
        scr_head_shot();
        self.headPatternRamIndex++;
   }
}
else if (self.headPatternRamIndex < 3)
{
    // Stay down
    obj_boss_warehouse_head.y -= 0.1;
   
   if (obj_boss_warehouse_head.y < (self.y + 195))
   {
        self.headPatternRamIndex++;
   }
}
else
{
    self.headPatternRamIndex++;
}

// Patterns
