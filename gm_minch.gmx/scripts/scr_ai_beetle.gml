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
var maxSpeed = 1;

if (self.isActive)
{
    self.direction = scr_aim_at_minch(self, 0, 0, 0);
    
    if (self.speed < maxSpeed)
    {
        self.speed += 0.01;
    }
    else
    {
        self.speed = maxSpeed;
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

if (self.speed > 0.2) {
    // Walking
    switch (self.color) {
        case global.CY:
            self.sprite_index = spr_beetle_walk_cy;
            break;
        case global.MA:
            self.sprite_index = spr_beetle_walk_ma;
            break;
        case global.YE:
            self.sprite_index = spr_beetle_walk_ye;
            break;
        case global.PU:
            self.sprite_index = spr_beetle_walk_pu;
            break;
        case global.GR:
            self.sprite_index = spr_beetle_walk_gr;
            break;
        case global.RG:
            self.sprite_index = spr_beetle_walk_or;
            break;
        case global.BR:
            self.sprite_index = spr_beetle_walk_br;
            break;
        case global.BK:
            self.sprite_index = spr_beetle_walk_bk;
            break;
    }
    self.image_speed = 0.5 * (1 / maxSpeed);// Fancy formula in case max speed is not 1
} else {
    switch (self.color) {
        case global.CY:
            self.sprite_index = beetle_cy;
            break;
        case global.MA:
            self.sprite_index = beetle_ma;
            break;
        case global.YE:
            self.sprite_index = beetle_ye;
            break;
        case global.PU:
            self.sprite_index = beetle_pu;
            break;
        case global.GR:
            self.sprite_index = beetle_gr;
            break;
        case global.RG:
            self.sprite_index = beetle_or;
            break;
        case global.BR:
            self.sprite_index = beetle_br;
            break;
        case global.BK:
            self.sprite_index = beetle_bk;
            break;
    }
}

// Angle
self.image_angle = self.direction + 90;
