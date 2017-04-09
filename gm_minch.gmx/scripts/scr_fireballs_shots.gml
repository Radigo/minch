if (argument0 == 0)
{
    return 0;// Don't shoot first round
}

scr_bullet_shot((self.x - 46), (self.y - 12), -90, 5, 5);
scr_bullet_shot((self.x + 46), (self.y - 12), -90, 5, 5);
