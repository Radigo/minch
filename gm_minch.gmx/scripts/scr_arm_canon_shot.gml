var attack_level = argument0;
var canon_side = argument1;

var i, num_main_shots, num_shots, shot_angle, shot_speed;
var canon_origin_x, canon_origin_y;


canon_origin_x = self.x + 42;
if (canon_side == "left")
{
    canon_origin_x = self.x - 42;
}
canon_origin_y = self.y + 20;

switch (argument0)
{
    case 1:
        num_main_shots = 3;
        num_shots = 0;
        break;
    case 2:
        if ((canon_side == "left") && !instance_exists(obj_boss_tanker_left))
        {
            num_main_shots = 8;
            num_shots = 8;
        }
        else if ((canon_side == "right") && !instance_exists(obj_boss_tanker_right))
        {
            num_main_shots = 8;
            num_shots = 8;
        }
        else
        {
            num_main_shots = 5;
            num_shots = 0;
        }
        break;
    case 3:
        num_main_shots = 6;
        num_shots = 12;
        break;
}


for (i = 0; i < num_main_shots; i++)
{
    shot_angle = scr_get_moreorless(-90, 3);
    shot_speed = scr_get_moreorless(3, 0.5);
    scr_bullet_shot(canon_origin_x, canon_origin_y, shot_angle, shot_speed, 4);
}

for (i = 0; i < num_shots; i++)
{
    shot_angle = scr_get_moreorless(-90, 3);
    shot_speed = scr_get_moreorless(2, 1.5);
    scr_bullet_shot(canon_origin_x, canon_origin_y, shot_angle, shot_speed, 2);
}
