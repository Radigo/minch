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

if (argument0 > global.lastCheckpoint)
{
    // Progress in checkpoints
    global.lastCheckpoint = argument0;
    
    // Get the associated start checkpoint
    var checkpoint_obj = asset_get_index("obj_checkpoint_" + string(global.lastCheckpoint));
    
    if (object_exists(checkpoint_obj))
    {
        // set coordinates to MinCH for further respawn
        with (obj_minch) self.initX = checkpoint_obj.x;
        with (obj_minch) self.initY = checkpoint_obj.y;
    }
    
    /*
    // Destroy checkpoint trigger (single-serving area)
    if (object_get_name(self.object_index) == "obj_area_checkpoint")
    {
        show_debug_message("- destroying checkpoint area");
        with (self) instance_destroy();
    }
    */
}
