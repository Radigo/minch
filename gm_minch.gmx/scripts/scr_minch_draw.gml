if (global.invincible) {
    // Draws FX
    fxColor = make_colour_rgb(64, 255, 200);
    draw_set_colour(fxColor);
    
    var pulseDuration = 10;
    var phase = (obj_minch.invincibilityTicker % pulseDuration) / pulseDuration;
    var radius = 10 + (phase * 6);
    var alpha = 0.7 - (phase * 0.5);
    
    draw_set_alpha(alpha);    
    draw_set_blend_mode(bm_add);
    draw_circle(self.x, self.y, radius, false);
    draw_set_blend_mode(bm_normal);
}

draw_set_alpha(1);
draw_self();
