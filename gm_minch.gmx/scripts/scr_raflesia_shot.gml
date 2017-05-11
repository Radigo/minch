ratio = (argument0 / 120);

angle = scr_aim_at_minch(self, (30 * (1 - ratio)), 0, -14);
bullet_speed = random(1.5) + 1 + (1 * ratio);
scr_bullet_shot(self.x, (self.y - 14), angle, bullet_speed, 3);

if ((argument0 % 3) == 0)
{
    angle = random(360);
    bullet_speed = random(2) + 1;
    scr_bullet_shot(self.x, (self.y - 14), angle, bullet_speed, 1);
}
