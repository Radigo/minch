// Called in 'scr_hud_draw' at each frame

if (global.comboColorTimer > 0) {
    global.comboColorTimer--;
    if (global.comboColorTimer <= 0) {
        scr_play_sound(snd_combo_lost, global.SFX_SCORING, false);
    }
}
