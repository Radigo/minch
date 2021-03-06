if (self.enemyCount == 0) {
   return false;
}

var counterValue = self.remainingEnemies;

if (counterValue < 0) {
    counterValue = self.enemyCount;
}

// show_debug_message(name + " needs " + string(remainingEnemies) + " / " + string(enemyCount) + " of " + string(self.color));

// Display a flash if last kill is recent
var flashOpacity = 0;
if (self.flashTicker > 0) {
    // Flash during self.flashDuration
    flashOpacity = self.flashTicker / self.flashDuration;
    self.flashTicker--;
}

// Display door ennemy count on door draw
draw_set_font(global.doorsFont);
draw_set_halign(fa_right);

/* get origin helper
draw_set_colour(c_yellow);
draw_rectangle(x, y, x+32, y+32, true);
*/

if (string_pos("_v_", self.name) > 0) {
    // Vertical door
    if (flashOpacity > 0) {
        draw_set_colour(c_white);
        draw_set_alpha(flashOpacity);
        draw_rectangle(x+10, y-13, x+21, y-9, false);
    }
    draw_set_alpha(1);
    draw_text(x+22, y-13, string_format(counterValue, 2, 0));
} else if (string_pos("_h_", self.name) > 0) {
    // Horizontal door
    if (flashOpacity > 0) {
        draw_set_colour(c_white);
        draw_set_alpha(flashOpacity);
        draw_rectangle(x+3, y+3, x+14, y+8, false);
    }
    draw_set_alpha(1);
    draw_text(x+15, y+3, string_format(counterValue, 2, 0));
}
else
{
    return false;
}

