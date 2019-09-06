if (argument1 != noone)
{
    global.bgmSequencing = argument2;
    
    if (argument1 == bgm_next)
    {
        global.nextBGM = scr_get_next_bgm();
    }
    else
    {
        global.nextBGM = argument1;
    }
}

if ((argument0 > global.lastCheckpoint) || (argument0 == "follow") || (global.lastCheckpoint == "follow"))
{
    // Progress in checkpoints
    global.lastCheckpoint = argument0;
}
