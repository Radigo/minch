// Change score depending on current combo, multipliers and stuffs...
// Called by defeated ennemy

var enemy_value = argument0;
var enemy_color = argument1;
var locationInstance = argument2;// Reference to sprite for notif location
var isMixing = argument3;
var comboIncrement = argument4;

//show_debug_message("Enemy value: " + string(enemy_value) + ", Enemy color: " + string(enemy_color));
if (enemy_color >= global.BK) {
    // Combo breaker
    global.comboValue = 1;
    global.comboColor = 0;
}

if (enemy_color == global.comboColor) {
    global.comboValue += comboIncrement;
} else {
    if (global.comboColorTimer == 0) {
        global.comboValue = 1;
    }
}

global.comboColor = enemy_color;

if (global.comboColor > 0) {
    global.comboColorTimer = global.comboColorDuration;
}

// Save score
global.levelScore += enemy_value * global.comboValue;

// Display score notification over destroyed ennemies
var notif = instance_create(locationInstance.x, locationInstance.y, obj_score_notif);
notif.value = enemy_value;
notif.comboValue = global.comboValue;
notif.color = global.comboColor;
notif.isMixing = isMixing;

//show_debug_message("Added " + string(enemy_value) + " points to score: " + string(global.levelScore) + ", with color: " + string(enemy_color));
