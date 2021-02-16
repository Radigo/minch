var attack_level = argument0;
var weapon_side = argument1;

var i, shot_angle, shot_speed, num_shots;
var origin_x, origin_y;

// Side is last remaining side of boss
// Front pattern should spread from destroyed side (the opposite)
switch (weapon_side)
{
    case "left":
        origin_x = self.x + 23;
        shot_angle = scr_aim_at_minch(self, 0, (origin_x - self.x), 5) + (360 * (self.frontPatternTicker / self.frontPatternLimit));
        break;
    case "right":
        origin_x = self.x - 23;
        shot_angle = scr_aim_at_minch(self, 0, (origin_x - self.x), 5) - (360 * (self.frontPatternTicker / self.frontPatternLimit));
        break;
}

origin_y = self.y - 5;

switch (attack_level)
{
    case 1:
        return false;
    case 2:
        scr_pattern_spread(origin_x, origin_y, shot_angle, 0.8, 2, 7, 8);
        if (scr_pattern_spread(origin_x, origin_y, (shot_angle + 180), 0.8, 2, 7, 8)) {
            scr_play_sound(snd_bullet_shot, global.SFX_LOW_PRIORITY, false);
        }
        break;
    case 3:
        scr_pattern_spread(origin_x, origin_y, (shot_angle * 10), 1.2, 2, 3, 6);
        scr_pattern_spread(origin_x, origin_y, ((shot_angle * 10) + 90), 1.2, 2, 3, 6);
        scr_pattern_spread(origin_x, origin_y, ((shot_angle * 10) + 180), 1.2, 2, 3, 6);
        if (scr_pattern_spread(origin_x, origin_y, ((shot_angle * 10) + 270), 1.2, 2, 3, 6)) {
            scr_play_sound(snd_bullet_shot, global.SFX_LOW_PRIORITY, false);
        }
        break;
}
