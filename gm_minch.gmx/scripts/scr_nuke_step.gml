scr_ai_step();

if (room == rm_lvl_33) {
    scr_nuke_step_rage();
    return false;
}

show_debug_message("Nuke step");


if (instance_exists(obj_grenwave)) {
    //obj_grenwave position based on Nuke's direction * greenWaveDistance
}