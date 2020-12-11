// Level intro sequence draw

// Fader
if (self.hasFader && (self.introTicker < self.faderDuration)) {
    self.faderAlpha = 1 - (self.introTicker / self.faderDuration);
} else {
    self.faderAlpha = 0;
}

// Name
if ((self.introTicker > self.levelNameDuration)
    && (self.introTicker < (self.levelNameDuration + self.levelNameFadeDuration))) {
    var name_ticker = self.introTicker - self.levelNameDuration;
    self.nameAlpha = 1 - (name_ticker / self.levelNameFadeDuration);
}

// Fader
draw_set_alpha(self.faderAlpha);
draw_set_colour(c_black);
draw_rectangle(view_xview[0], view_yview[0], view_xview[0] +320, view_yview[0] +240, false);

draw_set_alpha(self.nameAlpha);
draw_set_font(font_wide);
draw_set_colour(c_ltgray);
draw_set_halign(fa_center);
draw_text(view_xview[0] + 160, view_yview[0] + 70, self.levelName);

draw_set_alpha(1);


if (self.introTicker > self.introDuration) {
    instance_destroy();
}

self.introTicker ++;
