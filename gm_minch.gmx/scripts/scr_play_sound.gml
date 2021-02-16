var audioName = argument0;
var channel = argument1;
var loop = argument2;

// Filter sounds to avoir 'overlaps'
if (audio_is_playing(audioName)) {
    audio_stop_sound(audioName);
}

audio_play_sound(audioName, channel, loop);
