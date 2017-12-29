if (enemyCount == 0)
   return false;


var remainingEnemies = enemyCount - ds_map_find_value(global.ennemyKilled, self.color);

if (remainingEnemies <= 0)
   return false;

//show_debug_message(name + " needs " + string(enemyCount) + " of " + self.color);

// Display door ennemy count on door draw
draw_set_font(global.doorsFont);
draw_set_halign(fa_right);

/* get origin helper
draw_set_colour(c_yellow);
draw_rectangle(x, y, x+32, y+32, true);
*/

if (string_pos("_v_", name) > 0)
{
    // Vertical door
    draw_text(x+22, y-13, string_format(remainingEnemies, 2, 0));
}
else if (string_pos("_h_", name) > 0)
{
    // Horizontal door
    draw_text(x+15, y+3, string_format(remainingEnemies, 2, 0));
}
else
{
    return false;
}
