/** Brrtle is supposed to crawl towards player and explode when killed over a given distance (code is in object destroy event)

Also, probably make a beetle that resist collisions for a while */

self.isActive = (distance_to_object(obj_minch) < 140)

 // Movement collision
if (collision_circle(self.x, self.y, 8, obj_wall, false, false))
{
    self.speed = 0;
    self.isActive = false;
    scr_enemy_death(false, false);
}

if (self.isActive)
{
    self.direction = scr_aim_at_minch(self, 0, 0, 0);
    
    if (self.speed < 1)
    {
        self.speed += 0.01;
    }
    else
    {
        self.speed = 1;
    }
}
else
{
    if (self.speed < 0.1)
    {
        self.speed = 0;
    }
    else
    {
        self.speed -= 0.02;
    }
}
