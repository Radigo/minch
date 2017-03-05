var area_id = 0;

if (self.startDelay == 0)
{
    if (self.switchTriggered)
    {
        //show_debug_message("triggered bike id: " + string(self.action_id));
        
        self.startDelay = random(1000);
    }
    else
    {
        self.startDelay = 0;
    }
}

if (self.startDelay > 0)
{
    if (!self.isActive
        && (self.ticker > self.startDelay))
    {
        self.direction = -90;
        self.speed = random(3) + 3;
        
        self.visible = true;
        self.y = self.initY;
        self.isActive = true;
    }
}

if (self.isActive)
{
    if ((self.patternTicker % 24) == 0)
    {
        scr_bullet_shot(self.x, (self.y - 16), (random(30) - 30), (random(1) + 1), 2);
    }
    else if ((self.patternTicker % 24) == 12)
    {
        scr_bullet_shot(self.x, (self.y - 16), (random(30) + 180), (random(1) + 1), 2);
    }
    
    if (self.y > room_height)
    {
        self.isActive = false;
        self.visible = false;
        self.startDelay = 0;
        self.speed = 0;
    }
}
