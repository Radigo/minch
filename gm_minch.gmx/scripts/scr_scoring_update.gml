// Change score depending on current combo, multipliers and stuffs...
// Called by defeated ennemy

var enemy_value = argument0;
var enemy_color = argument1;

//show_debug_message("Enemy value: " + string(enemy_value) + ", Enemy color: " + string(enemy_color));

if (enemy_color == global.comboColor)
{
    global.comboValue ++;
}
else
{
    if (global.comboColorTimer == 0)
    {
        global.comboValue = 1;
    }
}

global.comboColor = enemy_color;

if (global.comboColor > 0)
{
    global.comboColorTimer = global.comboColorDuration;
}

global.levelScore += enemy_value * global.comboValue;

//show_debug_message("Added " + string(enemy_value) + " points to score: " + string(global.levelScore) + ", with color: " + string(enemy_color));
