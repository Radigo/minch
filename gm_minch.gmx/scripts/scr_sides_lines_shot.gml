switch (argument0)
{
    case 0:
         shot_angle = random(60) - 90;
         break;
    case 1:
         shot_angle = random(60) - 60 - 90;
         break;
    case 2:
         shot_angle = -90;
         break;
    default:
            shot_angle = random(120) - 60 - 90;
            break;
}

for (i = 0; i < 6; i++)
{
    bullet_speed = 2 + (i * 0.4);
    scr_bullet_shot((self.x - 72), (self.y + 12), shot_angle, bullet_speed, 3);
    scr_bullet_shot((self.x + 72), (self.y + 12), shot_angle, bullet_speed, 3);
}
