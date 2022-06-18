show_debug_message("<scr_pass_checkpoint>");

if (argument1 != noone)
{
    show_debug_message(string(argument1));
    global.bgmSequencing = argument2;
    show_debug_message(string(argument2));
    
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
    show_debug_message(string(argument0));
    // Progress in checkpoints
    global.lastCheckpoint = argument0;
}

if (argument3 != noone)
{
    show_debug_message(string(argument3));
    with (self) instance_destroy();
}
