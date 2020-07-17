// Draw text
var travelRatio = self.ticker / self.duration;
var notifY = -(travelRatio * self.travelDistance);

draw_set_halign(fa_center);
draw_set_font(font_small);

if (isMixing) {
    if (ds_list_find_index(global.SECONDARY_COLORS, self.color) >= 0) {
        draw_set_font(font_medium);
    } else {
        draw_set_font(font_large);
    }
}

if ((floor(self.ticker * 0.5) % 2) == 0) {
    draw_set_color(scr_rgb_color_from_index(self.color));
} else {
    draw_set_colour(c_white);
}
draw_text(self.x, self.y + notifY, string(self.value * self.comboValue));

//self.comboValue
//self.color
