/** Static list of all bgm sequences in the game */

switch (global.currentBGM)
{
    // Generator boss level
    case bgm_23_low:
        return bgm_23_mid;
    case bgm_23_mid:
        return bgm_23_high;
    default:
        return global.currentBGM;
}
