// Change score depending on current combo, multipliers and stuffs...
// Called by defeated ennemy

var enemy_value = argument0;
var enemy_color = argument1;
var locationInstance = argument2;// Reference to sprite for notif location
var isMixing = argument3;
var comboIncrement = argument4;

//show_debug_message("scr_scoring_update enemy value: " + string(enemy_value) + ", Enemy color: " + string(enemy_color));
if (enemy_color >= global.BK) {
    // Combo breaker
    global.comboValue = 1;
    global.comboColor = 0;
}

if (enemy_color == global.comboColor) {
    global.comboValue += comboIncrement;
    
    switch (global.comboColor) {
        case global.CY:
        case global.MA:
        case global.YE:
            scr_play_sound(snd_combo_first, global.SFX_SCORING, false);
            break;
        case global.PU:
        case global.GR:
        case global.RG:
            scr_play_sound(snd_combo_second, global.SFX_SCORING, false);
            break;
        case global.BR:
            scr_play_sound(snd_combo_third, global.SFX_SCORING, false);
            break;
    }
} else {
    if (global.comboColorTimer == 0) {
        global.comboValue = 1;
    }
    scr_play_sound(snd_combo_error, global.SFX_SCORING, false);
}

global.comboColor = enemy_color;

if (global.comboColor > 0) {
    global.comboColorTimer = global.comboColorDuration;
}

// No score in story mode
if (global.gameMode == global.STORY_MODE) {
    return false;
}

// Save score
global.normalGameScore += enemy_value * global.comboValue;

// Display score notification over destroyed ennemies
var notif = instance_create(locationInstance.x, locationInstance.y, obj_score_notif);
notif.value = enemy_value;
notif.comboValue = global.comboValue;
notif.color = global.comboColor;
notif.isMixing = isMixing;

//show_debug_message("Added " + string(enemy_value) + " points to score: " + string(global.normalGameScore) + ", with color: " + string(enemy_color));
