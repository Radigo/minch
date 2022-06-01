// When we hit a secret area with the claw

// Hack to pretend it's an enemy...
self.explosionSize = 32;

scr_boom((self.x + 16), (self.y + 16), 3, 32);
instance_destroy();

scr_reveal_neighbor();

// Play special BGM
scr_play_sound(bgm_22_triumph_wav, global.SFX_BGM, false);

// Start level BGM
global.nextBGM = bgm_22_mp3;
global.bgmSequencing = global.bgmSequenceInstant;
audio_stop_sound(global.currentBGM);
scr_play_bgm();
