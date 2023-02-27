/* Plays bgm id depending on screen, or level/checkpoint
 * Played at screen display or level start or bgm loop end.
 * Warning: calling this script starts a loop!
*/

if (global.currentBGM != noone) {
    audio_sound_gain(global.currentBGM, global.BGM_GAIN, 0);
    scr_play_sound(global.currentBGM, global.SFX_BGM, false);
}
