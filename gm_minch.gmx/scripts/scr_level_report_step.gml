var played_sound_id = noone;

if (self.playerInvite && (self.reportTicker > self.inviteTime)) {
    // Player selects choice
    
    var inputKey = -1;
    // Both input types work in menu
    // Keyboard
    if (keyboard_check_pressed(global.key_up)) {
        inputKey = global.UP;
    } else if (keyboard_check_pressed(global.key_down)) {
        inputKey = global.DOWN;
    } else if (keyboard_check_pressed(global.key_left)) {
        //inputKey = global.LEFT;
    } else if (keyboard_check_pressed(global.key_right)) {
        //inputKey = global.RIGHT;
    } else if (keyboard_check_pressed(global.key_a)) {
        inputKey = global.A;
    } else if (keyboard_check_pressed(global.key_b)) {
        //inputKey = global.B;
    } else if (keyboard_check_pressed(global.key_start)) {
        inputKey = global.START;
    // Gamepad
    } else if (gamepad_button_check_pressed(global.control_type, global.pad_up)) {
        inputKey = global.UP;
    } else if (gamepad_button_check_pressed(global.control_type, global.pad_down)) {
        inputKey = global.DOWN;
    } else if (gamepad_button_check_pressed(global.control_type, global.pad_left)) {
        //inputKey = global.LEFT;
    } else if (gamepad_button_check_pressed(global.control_type, global.pad_right)) {
        //inputKey = global.RIGHT;
    } else if (gamepad_button_check_pressed(global.control_type, global.pad_a)) {
        inputKey = global.A;
    } else if (gamepad_button_check_pressed(global.control_type, global.pad_b)) {
        //inputKey = global.B;
    } else if (gamepad_button_check_pressed(global.control_type, global.pad_start)) {
        inputKey = global.START;
    }
    
    switch (inputKey) {
        case global.UP:
            if (self.inviteSelectIndex > 0) {
                played_sound_id = snd_ui_select;
                self.inviteSelectIndex--;
            }
            break;
            
        case global.DOWN:
            if (self.inviteSelectIndex < self.selectIndexMax) {
                played_sound_id = snd_ui_select;
                self.inviteSelectIndex++;
            }
            break;
            
        case global.A:
        case global.START:
            played_sound_id = snd_ui_confirm;
            // Any choice after an invite menu leads to score reinit
            switch (self.inviteSelectIndex) {
                case 0:
                    // Continue
                    if (global.gameMode == global.SCOREATTACK_MODE) {
                        if (self.isGameOver) {
                            global.normalGameScore = 0;
                            global.extends = 0;
                        } else {
                            scr_end_level(true);
                        }
                    } else {
                        global.extends = global.initLives;
                    }
                    with (self.cursor) instance_destroy();
                    instance_destroy();
                    global.minchControlIsActive = true;
                    break;
                case 1:
                    // Retry
                    global.normalGameScore = 0;
                    if (global.gameMode == global.SCOREATTACK_MODE) {
                        global.extends = 0;
                    } else {
                        global.extends = global.initLives;
                    }
                    global.lastCheckpoint = 0;
                    room_goto(global.currentRoom);
                    break;
                case 2:
                    // Back to title
                    if (self.isGameOver) {
                        scr_end_level(false);
                    } else {
                        scr_end_level(true);
                    }
                    break;
            }
            
            audio_sound_gain(global.currentBGM, 1, 0);
            break;
    }
} else if (self.reportTicker > (self.fadeTime + self.faderDuration)) {
    instance_destroy();
    if (self.isGameOver) {
        scr_end_level(false);
    } else {
        scr_end_level(true);
    }
}

if (played_sound_id != noone) {
    scr_play_sound(played_sound_id, global.SFX_UI, false);
}

self.reportTicker++;
