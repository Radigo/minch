//show_debug_message("scr_minch_death by " + argument0 + ", global.invincible: " + string(global.invincible));

var destroy_instance = false;

if (global.invincible)
{
    exit;
}

if ((global.controlStatus == global.ALIVE)
    && (global.legsStatus != global.LEGS_JUMP))
{
    with (obj_claw_hitbox) instance_destroy();
    with (obj_claw_fx) instance_destroy();
    
    global.bodyStatus = global.BODY_IDLE;
    global.legsStatus = global.LEGS_IDLE;
    
    with (obj_minch)
    {
        self.controlTime = self.deathDuration;
        
        switch (argument0)
        {
            case "enemy":
            case "trap":
            case "deus_ex":// debug cause
                global.controlStatus = global.DEATH;
                break;
            case "bullet":
                global.controlStatus = global.DEATH;
                destroy_instance = true;
                break;
            case "laser":
                global.controlStatus = global.DEATH;
                break;
            case "hole":
                global.controlStatus = global.FALL;
                audio_play_sound(snd_fall, 0, false);
                break;
        }
    
        self.jumpTicker = 0;
        self.canJump = true;
        self.abReleased = true;
        self.aPressTime = 0;
        self.aReleaseTime = 0;
        self.shotTime = 0;
        self.clawTime = 0;
        self.clawDelayTime = 0;
        
        global.extends--;
        
        // Restore focus
        if (!obj_minch_camera.keepFocusAfterDeath) {
            obj_minch_camera.transitionDuration = obj_minch_camera.transitionOutDuration;
            obj_minch_camera.transitionStep = obj_minch_camera.transitionOutDuration;
            obj_minch_camera.focus = obj_minch;
        }
    }
    
    if (destroy_instance)
    {
        instance_destroy();
    }
    
    scr_all_bullet_cancel();
}
