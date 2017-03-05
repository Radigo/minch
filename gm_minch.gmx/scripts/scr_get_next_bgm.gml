/** Static list of all bgm sequences in the game */

switch (global.currentBGM)
{
    // Generator boss level
    case bgm_generator_1:
        return bgm_generator_2;
    case bgm_generator_2:
        return bgm_generator_3;
    default:
        return global.currentBGM;
}
