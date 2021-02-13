var attack_level = argument0;

var i, shot_angle, shot_speed, num_shots;
var ball_origin_x_left, ball_origin_x_right, ball_origin_y_up, ball_origin_y_down;


ball_origin_x_left = self.x - 18;
ball_origin_x_right = self.x + 18;
ball_origin_y_up = self.y - 35;
ball_origin_y_down = self.y - 15;

switch (argument0)
{
    case 1:
        num_shots = 4;
        shot_speed = 1.7;
        break;
    case 2:
        num_shots = 8;
        shot_speed = 1.5;
        break;
    case 3:
        num_shots = 10;
        shot_speed = 1.1;
        break;
}

for (i = 0; i < num_shots; i++)
{
    shot_angle = scr_aim_at_minch(self, 0, 0, 0) + (360 * (i / num_shots));

    scr_bullet_shot(ball_origin_x_left, ball_origin_y_up, shot_angle, scr_get_moreorless(shot_speed, 0.4), 3);
    scr_bullet_shot(ball_origin_x_right, ball_origin_y_up, shot_angle, scr_get_moreorless(shot_speed, 0.4), 3);
    scr_bullet_shot(ball_origin_x_left, ball_origin_y_down, shot_angle, scr_get_moreorless(shot_speed, 0.4), 3);
    if (scr_bullet_shot(ball_origin_x_right, ball_origin_y_down, shot_angle, scr_get_moreorless(shot_speed, 0.4), 3))
    {
        audio_play_sound(snd_bullet_shot, global.SFX_LOW_PRIORITY, false);
    }
}
