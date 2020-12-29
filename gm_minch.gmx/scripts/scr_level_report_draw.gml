// Level end report sequence

self.flashTicker++;

if (self.flashTicker > self.flashTickerLimit) {
    self.flashTicker = 0;
}

var flashColor = c_dkgray;
if (self.flashTicker > (self.flashTickerLimit * 0.5)) {
    flashColor = c_ltgray;
}

// Fader
if (self.reportTicker > self.fadeTime) {
    var fade_ticker = self.reportTicker - self.fadeTime;
    self.faderAlpha = fade_ticker / self.faderDuration;
    
    draw_set_alpha(self.faderAlpha);
    draw_set_colour(c_black);
    draw_rectangle(view_xview[0], view_yview[0], view_xview[0] +320, view_yview[0] +240, false);
}

if (self.playerInvite && (self.reportTicker > self.inviteTime)) {
    // Display player choice
    var labelLeft = view_xview[0] + 140;
    var linePosY = view_yview[0] + 120;
    draw_set_alpha(1);
    draw_set_font(font_wide);
    draw_set_colour(c_ltgray);
    draw_set_halign(fa_left);
    draw_text(labelLeft, linePosY, scr_text("continue"));
    draw_text(labelLeft, linePosY + 16, scr_text("retry"));
    draw_text(labelLeft, linePosY + 32, scr_text("options_back"));
    
    self.cursor.visible = true;
    self.cursor.x = labelLeft;
    self.cursor.y = linePosY + (self.inviteSelectIndex * 16);
} else {
    self.cursor.visible = false;
}

if (self.reportTicker > self.completeTime) {
    draw_set_alpha(1);
    draw_set_font(font_wide);
    draw_set_colour(c_ltgray);
    draw_set_halign(fa_center);
    if (self.isGameOver) {
        draw_text(view_xview[0] + 160, view_yview[0] + 60, scr_text("game_over"));
    } else {
        draw_text(view_xview[0] + 160, view_yview[0] + 60, scr_text("level_complete"));
    }
}

if (self.hasScore && (self.reportTicker > self.scoreTime)) {
    draw_set_alpha(1);
    draw_set_font(font_wide);
    
    if (self.isHighScore) {
        draw_set_colour(flashColor);
    } else {
        draw_set_color(c_ltgray);
    }
    
    draw_set_halign(fa_center);
    draw_text(view_xview[0] + 160, view_yview[0] + 80, string(global.normalGameScore));
}

draw_set_alpha(1);

