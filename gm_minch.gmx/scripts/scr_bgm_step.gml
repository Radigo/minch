self.bgmStep++;

if (global.currentBGM == noone) {
    // First bgm played, start instantly
    global.bgmSequencing = global.BGM_SEQUENCE_INSTANT;
}

if  (global.nextBGM == global.currentBGM) {
    // Next BGM is the same as current, wait for loop
    global.bgmSequencing = global.BGM_SEQUENCE_LOOP;
}

if  ((global.nextBGM == noone)
    && audio_is_playing(global.currentBGM)) {
    // No next BGM planned & BGM is over, loop
    global.nextBGM = global.currentBGM;
    global.bgmSequencing = global.BGM_SEQUENCE_LOOP;
}

switch (global.bgmSequencing) {
    case global.BGM_SEQUENCE_INSTANT:
        break;
        
    case global.BGM_SEQUENCE_SYNC:
         // Mute current, unmute next
        audio_sound_gain(global.currentBGM, 0, 100);
        audio_sound_gain(global.nextBGM, 1, 100);
        global.currentBGM = global.nextBGM;
        global.nextBGM = noone;
        global.bgmSequencing = global.BGM_SEQUENCE_LOOP;
        return false;
        
    default:
    case global.BGM_SEQUENCE_LOOP:
        if (audio_is_playing(global.currentBGM)) {
            // BGM is still playing...
            return false;
        }
        break;
}

// Next is planned, update current and play it
audio_stop_sound(global.currentBGM); 
global.currentBGM = global.nextBGM;
global.nextBGM = noone;

self.bgmFrame = 0;

if (global.currentBGM != bgm_stop) {
    scr_play_bgm();
}
