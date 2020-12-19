// Level end report sequence

// Fader
if (self.reportTicker > self.fadeTime)
{
    var fade_ticker = self.reportTicker - self.fadeTime;
    self.faderAlpha = fade_ticker / self.faderDuration;
    
    draw_set_alpha(self.faderAlpha);
    draw_set_colour(c_black);
    draw_rectangle(view_xview[0], view_yview[0], view_xview[0] +320, view_yview[0] +240, false);
}
else
{
    self.faderAlpha = 0;
}

if (self.reportTicker > self.completeTime)
{
    draw_set_alpha(1 - self.faderAlpha);
    
    draw_set_font(font_wide);
    draw_set_colour(c_ltgray);
    draw_set_halign(fa_center);
    draw_text(view_xview[0] + 160, view_yview[0] + 70, scr_text("level_complete"));
}

if (self.reportTicker > self.scoreTime)
{
    draw_set_alpha(1 - self.faderAlpha);
    
    draw_set_font(font_wide);
    draw_set_colour(c_ltgray);
    draw_set_halign(fa_center);
    draw_text(view_xview[0] + 160, view_yview[0] + 140, string(global.normalGameScore));
}

draw_set_alpha(1);

if (self.reportTicker > (self.fadeTime + self.faderDuration))
{
    instance_destroy();
}

self.reportTicker ++;
