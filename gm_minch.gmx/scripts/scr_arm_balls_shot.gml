var attack_level = argument0;

var i, shot_angle, shot_speed;
var ball_origin_x_left, ball_origin_x_right, ball_origin_y_up, ball_origin_y_down;


ball_origin_x_left = self.x - 18;
ball_origin_x_right = self.x - 18;
ball_origin_y_up = self.y - 35;
ball_origin_y_down = self.y - 15;



switch (argument0)
{
    case 1:
        shot_angle = scr_aim_at_minch(self, 0, 0, 0);
        shot_speed = 1.7;
        scr_bullet_shot(ball_origin_x_left, ball_origin_y_up, shot_angle, shot_speed, 3);
        scr_bullet_shot(ball_origin_x_right, ball_origin_y_up, shot_angle, shot_speed, 3);
        scr_bullet_shot(ball_origin_x_left, ball_origin_y_down, shot_angle, shot_speed, 3);
        scr_bullet_shot(ball_origin_x_right, ball_origin_y_down, shot_angle, shot_speed, 3);
        break;
    case 2:
        break;
    case 3:
        break;
}

/*
for (i = 0; i < num_main_shots; i++)
{
    shot_angle = scr_get_moreorless(-90, 3);
    shot_speed = scr_get_moreorless(3, 0.5);
    scr_bullet_shot(canon_origin_x, canon_origin_y, shot_angle, shot_speed, 4);
}
*/
