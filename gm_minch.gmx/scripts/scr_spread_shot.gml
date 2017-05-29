angle_min = -70 - 90;
angle_max = 70 - 90;
range = angle_max - angle_min;

arc_num = 30;
delta = range / arc_num;// angle between 2 bullets

index = argument0 % arc_num;
phase = floor(argument0 / arc_num);

if ((phase % 2) == 0)
{
   angle = angle_min + (index * delta);
}
else
{
   angle = angle_max - (index * delta);
}


pos_x = cos(-angle * pi / 180) * 16;
pos_y = sin(-angle * pi / 180) * 16;

scr_bullet_shot((self.x + pos_x), (self.y + pos_y), angle, 2, 1);
