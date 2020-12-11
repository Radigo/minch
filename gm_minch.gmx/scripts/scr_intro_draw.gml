// Write skip message
draw_self();

draw_set_font(font_small);
draw_set_color(c_dkgray);
draw_set_alpha(self.skipMessageAlpha);

draw_set_halign(fa_right);
draw_text(view_xview[0] + 312, view_yview[0] + 224, scr_text("skip_intro"));
draw_set_halign(fa_left);

draw_set_alpha(1);
