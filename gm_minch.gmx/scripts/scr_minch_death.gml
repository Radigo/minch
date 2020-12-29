//show_debug_message("scr_minch_death by " + argument0 + ", global.invincible: " + string(global.invincible));

var destroy_instance = false;

if (global.invincible) {
    exit;
}

if ((global.controlStatus == global.ALIVE)
    && (global.legsStatus != global.LEGS_JUMP)) {
    with (obj_claw_hitbox) instance_destroy();
    with (obj_claw_fx) instance_destroy();
    
    global.bodyStatus = global.BODY_IDLE;
    global.legsStatus = global.LEGS_IDLE;
    
    obj_minch.controlTime = obj_minch.deathDuration;
    
    switch (argument0) {
        case "trap":
        case "deus_ex":// debug cause
            global.controlStatus = global.DEATH;
            instance_create(obj_minch.x, obj_minch.y, obj_minch_death_bullet);
            break;
            
        case "enemy":
            global.controlStatus = global.DEATH;
            var death = instance_create(obj_minch.x, obj_minch.y, obj_minch_death_bullet);
            death.shotAngle = self.direction;
            death.shotSpeed = point_distance(self.x, self.y, self.xprevious, self.yprevious);
            break;
            
        case "bullet":
            global.controlStatus = global.DEATH;
            destroy_instance = true;
            var death = instance_create(obj_minch.x, obj_minch.y, obj_minch_death_bullet);
            death.shotAngle = self.direction;
            death.shotSpeed = self.speed;
            break;
            
        case "laser":
            global.controlStatus = global.DEATH;
            var death = instance_create(obj_minch.x, obj_minch.y, obj_minch_death_bullet);
            break;
            
        case "hole":
            global.controlStatus = global.DEATH;
            instance_create(obj_minch.x, obj_minch.y, obj_minch_death_fall);
            break;
    }

    obj_minch.jumpTicker = 0;
    obj_minch.canJump = true;
    obj_minch.abReleased = true;
    obj_minch.aPressTime = 0;
    obj_minch.aReleaseTime = 0;
    obj_minch.shotTime = 0;
    obj_minch.clawTime = 0;
    obj_minch.clawDelayTime = 0;
    
    global.extends--;
    
    if (global.extends < 0) {
        var report = instance_create(0, 0, obj_level_report);
        report.isLevelComplete = false;
    } else {
        // Restore focus
        if (!obj_minch_camera.keepFocusAfterDeath) {
            obj_minch_camera.transitionDuration = obj_minch_camera.transitionOutDuration;
            obj_minch_camera.transitionStep = obj_minch_camera.transitionOutDuration;
            obj_minch_camera.focus = obj_minch;
        }
    }
    
    if (destroy_instance) {
        with (self)
            instance_destroy();
    }
    
    scr_all_bullet_cancel();
}
