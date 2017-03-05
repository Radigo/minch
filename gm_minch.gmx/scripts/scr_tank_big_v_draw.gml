// Caterpillars
var caterpillar_frame = (self.y - self.initY) % 3;
var caterpillars = draw_sprite(spr_tank_big_v_caterpillars, caterpillar_frame, self.x, self.y);

// Body
var str = object_get_name(self.id.object_index);
// Get the last 2 characters of the object name to set color
var str_color = string_char_at(str, (string_length(str) - 1)) + string_char_at(str, (string_length(str) - 0));

switch (str_color)
{
    case "cy":
    default:
        draw_sprite(spr_tank_big_v_cy, 0, self.x, self.y);
        break;
}

// Turret
var turret = draw_sprite(spr_tank_big_v_turret_E, 0, self.x, (self.y + self.turretY));
