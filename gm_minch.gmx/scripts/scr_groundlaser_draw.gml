//show_debug_message("draw groundlaser " + string(self.targetX) + ", " + string(self.targetY));

if (self.status == self.STATUS_FIRE) {
    if (self.ticker < 60) {
        draw_set_colour(c_aqua);
        draw_circle(self.targetX, self.targetY, ((1 - (self.ticker / 60)) * 32), true);
    }
}
