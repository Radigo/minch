/** Static list of all bgm sequences in the game */

switch (global.currentBGM)
{
    // Generator boss level
    case bgm_23_low_mp3:
        return bgm_23_mid_mp3;
    case bgm_23_mid_mp3:
        return bgm_23_high_mp3;
    default:
        return global.currentBGM;
}
