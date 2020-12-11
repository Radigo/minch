var blackVeilAlpha = 0;
var textAlpha = 1;

// Fade
if (instance_exists(obj_title_bg)) {
    // We are still in the transition room
    if (obj_title_bg.y < self.coreMoveYFadeStart) {
        // Fade out
        blackVeilAlpha = 1 - ((self.coreMoveYTarget - obj_title_bg.y) / (self.coreMoveYTarget - self.coreMoveYFadeStart));
    }
} else if (self.currentSequence == self.SEQUENCE_INTRO) {
    // We are in the intro
    if (self.ticker < self.introFadeDuration) {
        blackVeilAlpha = 1 - (self.ticker / self.introFadeDuration);
    }
    
    if (self.ticker > self.textFadeStarts) {
        textAlpha = 1 - ((self.ticker - self.textFadeStarts) / self.textFadeDuration);
    }
}

draw_set_alpha(blackVeilAlpha);
draw_set_colour(c_black);
draw_rectangle(view_xview[0], view_yview[0], view_xview[0] + view_wview[0], view_yview[0] + view_hview[0], false);

draw_set_alpha(textAlpha)
draw_set_colour(c_white);
draw_text(view_xview[0] + self.textX, view_yview[0] + self.textY, self.typed);

draw_set_alpha(1);
