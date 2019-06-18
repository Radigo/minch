// Visuals
var blendMode = bm_normal;
if (self.lastHitTicker >= 0) {
    //show_debug_message(string(self.lastHitTicker));
    // Blink
    if ((self.ticker % 2) == 0) {
        //show_debug_message("blink");
        // Whitish
        blendMode = bm_add;
    }
}

// Normal
draw_set_blend_mode(blendMode);
draw_self();
