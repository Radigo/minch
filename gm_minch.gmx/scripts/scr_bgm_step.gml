self.bgmStep++;

if (global.currentBGM == noone) {
    // First bgm played, start instantly
    global.bgmSequencing = global.bgmSequenceInstant;
}

if  (global.nextBGM == global.currentBGM) {
    // Next BGM is the same as current, wait for loop
    global.bgmSequencing = global.bgmSequenceLoop;
}

if  ((global.nextBGM == noone)
    && audio_is_playing(global.currentBGM)) {
    // No next BGM planned & BGM is over, loop
    global.nextBGM = global.currentBGM;
    global.bgmSequencing = global.bgmSequenceLoop;
}

switch (global.bgmSequencing) {
    case global.bgmSequenceLoop:
        if (audio_is_playing(global.currentBGM)) {
            // BGM is still playing...
            return false;
        }
        break;
        
    case global.bgmSequenceInstant:
        break;
    
    default:
    case global.bgmSequenceMeasure:
        if ((self.bgmStep % 450) != 0) {
            return false;
        }
        break;
}

// Next is planned, update current and play it
audio_stop_sound(global.currentBGM); 
global.currentBGM = global.nextBGM;
global.nextBGM = noone;

self.bgmFrame = 0;
global.bgmSequencing = global.bgmSequenceLoop;

if (global.currentBGM != bgm_stop) {
    scr_play_bgm();
}
