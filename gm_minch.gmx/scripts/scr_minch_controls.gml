/** Minch Movement and behavior */

// Console
if (keyboard_check_released(vk_enter))
{
    scr_console_controls();
}

var walk_speed = 0;

var prev_x = x;
var prev_y = y;

self.isColliding = false;

//show_debug_message("scr_minch_controls global.controlStatus: " + global.controlStatus + ", controlTime: " + string(self.controlTime));
    
// GET KEY PRESSED if we can move
if (global.controlStatus == global.SPAWN)
{
    if (global.extends < 0)
    {
        // Game over
        scr_end_level(false);
    }
    
    if (self.controlTime == self.spawnDuration)
    {
        self.x = self.initX;
        self.y = self.initY;
        self.mainAngle = pi * 0.5;
        self.image_angle = 0;
        
        self.image_xscale = 1;
        self.image_yscale = 1;
        self.image_index = 1;
        
        scr_all_bullet_cancel();
    }
    
    self.image_alpha = 1 - (self.controlTime / self.spawnDuration);
    obj_minch_feets.image_alpha = 1 - (self.controlTime / self.spawnDuration);
    
    if (self.controlTime == 0)
    {
        global.controlStatus = global.ALIVE;
        global.invincible = true;
        self.controlTime = self.warmupDuration;
        exit;
    }
    
    self.controlTime--;
}
else if (global.controlStatus == global.TELEPORT)
{
    // No possible move
    if (self.controlTime == 0)
    {
        global.controlStatus = global.ALIVE;
        exit;
    }
    else if (self.controlTime < global.teleportDuration / 2)
    {
        self.x = self.teleportTargetX;
        self.y = self.teleportTargetY;
    }
    
    self.controlTime--;
}
else if (global.controlStatus == global.DEATH)
{
    self.image_alpha = self.controlTime / self.deathDuration;
    obj_minch_feets.image_alpha = self.controlTime / self.deathDuration;
    
    scr_all_bullet_cancel();
    
    if (self.controlTime == 0)
    {
        // Get the associated start checkpoint
        var checkpoint_obj = asset_get_index("obj_checkpoint_" + string(global.lastCheckpoint));
        show_debug_message("obj_checkpoint_" + string(global.lastCheckpoint));
        show_debug_message(string(object_exists(checkpoint_obj)));
        
        if (object_exists(checkpoint_obj))
        {
            // set coordinates to MinCH for further respawn
            self.initX = checkpoint_obj.x;
            self.initY = checkpoint_obj.y;
        }
        
        self.controlTime = self.spawnDuration;
        global.controlStatus = global.SPAWN;
        exit;
    }
    
    self.controlTime--;
}
else if (global.controlStatus == global.FALL)
{
    self.image_xscale = self.controlTime / self.deathDuration;
    self.image_yscale = self.controlTime / self.deathDuration;
    self.y += 0.2;
    self.image_angle += 6;
    
    obj_minch_feets.image_alpha = 0;
    
    scr_all_bullet_cancel();
    
    if (self.controlTime == 0)
    {
        self.controlTime = self.spawnDuration;
        global.controlStatus = global.SPAWN;
        exit;
    }
    
    self.controlTime--;
}
else if (global.minchControlIsActive)
{
    if (self.controlTime > 0) {
        if (self.controlTime == 1) {
            global.invincible = false;
        }
        self.controlTime--;
    }
    
    if (keyboard_check(global.key_right) &&  keyboard_check(global.key_up))
    {
        self.mainAngle = pi * 1.75;
        walk_speed = 2;
    }
    else if (keyboard_check(global.key_left) &&  keyboard_check(global.key_up))
    {
        self.mainAngle = pi * 1.25;
        walk_speed = 2;
    }
    else if (keyboard_check(global.key_left) && keyboard_check(global.key_down))
    {
        self.mainAngle = pi * 0.75;
        walk_speed = 2;
    }
    else if (keyboard_check(global.key_down) && keyboard_check(global.key_right))
    {
        self.mainAngle = pi * 0.25;
        walk_speed = 2;
    }
    else if (keyboard_check(global.key_up))
    {
        self.mainAngle = pi * 1.5;
        walk_speed = 2;
    }
    else if (keyboard_check(global.key_down))
    {
        self.mainAngle = pi * 0.5;
        walk_speed = 2;
    }
    else if (keyboard_check(global.key_left))
    {
        self.mainAngle = pi * 1;
        walk_speed = 2;
    }
    else if (keyboard_check(global.key_right))
    {
        self.mainAngle = 0;
        walk_speed = 2;
    }
    
    if (self.jumpTicker > 0)
    {
        global.legsStatus = global.LEGS_JUMP;
    }
    else if (walk_speed > 0)
    {
        global.legsStatus = global.LEGS_WALK;
    }
    else
    {
        global.legsStatus = global.LEGS_IDLE;
    }
    
    if (keyboard_check(global.key_a) && keyboard_check(global.key_b))
    {
        //show_debug_message("press: AB");
        if (self.abReleased
            && (global.legsStatus != global.LEGS_JUMP))
        {
            obj_marker.x = x + cos(self.bodyAngle) * self.markerDistance;
            obj_marker.y = y + sin(self.bodyAngle) * self.markerDistance;
            
            if (scr_can_jump(x, y, self.bodyAngle))
            {
                // init start/target positions
                self.jumpStartingPosX = x;
                self.jumpStartingPosY = y;
                self.jumpTargetPosX = obj_marker.x;
                self.jumpTargetPosY = obj_marker.y;
                global.legsStatus = global.LEGS_JUMP;// << JUMP!
                self.abReleased = false;
            }
        }
        else if (global.bodyStatus != global.BODY_CLAW)
        {
            global.bodyStatus = global.BODY_AIMEDSHOT;// << AIMED SHOT
        }
    }
    else if (keyboard_check(global.key_a))
    {
        //show_debug_message("press: A");
        self.abReleased = false;
        
        if ((global.bodyStatus != global.BODY_CLAW)
           && (global.bodyStatus != global.BODY_HOLD))
        {
            
            if (self.numShots > 1)
            {
                self.aReleaseTime = self.aReleaseDelay;
            }
            else
            {
                self.aReleaseTime = self.aFirstReleaseDelay;
            }
            
            self.aPressTime++;
            
            if (self.aPressTime < self.aPressDelay)
            {
                global.bodyStatus = global.BODY_SHOT;// << FREE SHOT
            }
            else
            {
                self.aPressTime = self.aPressDelay;
                global.bodyStatus = global.BODY_FIXED;// << FIXED SHOT
            }
        }
    }
    else if (keyboard_check(global.key_b))
    {
        //show_debug_message("press: B");
        self.abReleased = false;
        
        if ((self.clawTime = 0)
            && (self.clawDelayTime = 0))
        {
            switch (global.bodyStatus)
            {
                case global.BODY_AIM:
                case global.BODY_AIMEDSHOT:
                    global.bodyStatus = global.BODY_AIM;// Free aim
                    break;
                case global.BODY_CLAW:
                case global.BODY_HOLD:
                    // Nothing
                    break;
                default:
                    self.aPressTime = 0;
                    self.aReleaseTime = 0;
                    
                    if ((global.legsStatus = global.LEGS_JUMP)// Add timing
                        && (self.jumpTicker > self.jumpDuration - 6))
                    {
                        global.bodyStatus = global.BODY_CLAW;// << POWER WAVE CLAW ATTACK
                        scr_wave_attack(self.x, self.y, 1);
                    }
                    else
                    {
                        global.bodyStatus = global.BODY_CLAW;// << CLAW ATTACK
                    }
                    break;
            }
        }
    }
    else
    {
        self.aPressTime = 0;
        self.abReleased = true;
        
        if (self.aReleaseTime > 0)
        {
            self.aReleaseTime--;
        }
        else if ((global.bodyStatus != global.BODY_CLAW)
            && (global.bodyStatus != global.BODY_HOLD))
        {
            global.bodyStatus = global.BODY_IDLE;// NO MORE SHOOTING
        }
    }
}
else
{
    global.bodyStatus = global.BODY_IDLE;
    global.legsStatus = global.LEGS_IDLE;
}

// STATUS
switch (global.bodyStatus)
{
    case global.BODY_IDLE:
        self.bodyAngle = self.mainAngle;
        
        direction = 180 * (-self.bodyAngle) / pi;
        obj_marker.sprite_index = spr_marker_position;
        obj_marker.image_angle = 0;
        
        self.numShots = 0;
        break;
    case global.BODY_SHOT:
        var angle_step = 0.2;// Rotates by step Radians at each frame
        var angle_diff = self.mainAngle - self.bodyAngle;
        if (angle_diff > pi)
        {
            self.mainAngle -= (2 * pi);
        }
        else if (angle_diff < -pi)
        {
            self.mainAngle += 2 * pi;
        }
        
        if (self.bodyAngle < (self.mainAngle - angle_step))
        {
            self.bodyAngle += angle_step;
        }
        else if (self.bodyAngle > (self.mainAngle + angle_step))
        {
            self.bodyAngle -= angle_step;
        }
        else
        {
            self.bodyAngle = self.mainAngle;
        }
        
        if (self.mainAngle < 0)
        {
            self.mainAngle += (2 * pi);
        }
        else if (self.mainAngle > (2 * pi))
        {
            self.mainAngle -= (2 * pi);
        }
        
        direction = 180 * (-self.bodyAngle) / pi;
        obj_marker.sprite_index = spr_marker_freeshot;// Free shot
        obj_marker.image_angle = direction;
        
        if (self.shotTime = 0)
        {
            scr_shot(x, y, direction);
            self.numShots++;
            self.shotTime = self.shotDelay;
            
            audio_play_sound(snd_shot_1, 0, false);
        }
        else
        {
            self.shotTime--;
        }
        
        break;
        
    case global.BODY_AIMEDSHOT:
        if (self.shotTime = 0)
        {
            scr_shot(x, y, direction);
            self.numShots++;
            self.shotTime = self.fixedDelay;
            
            audio_play_sound(snd_shot_1, 0, false);
        }
        else
        {
            self.shotTime--;
        }
        
    case global.BODY_AIM:
        var x_dist = obj_marker.x - x;
        var y_dist = obj_marker.y - y;
        self.bodyAngle = arctan2(y_dist, x_dist); 
        
        direction = 180 * (-self.bodyAngle) / pi;
        obj_marker.sprite_index = spr_marker_anchorshot;
        obj_marker.image_angle = 180 * (-self.bodyAngle) / pi;
        
        break;
        
    case global.BODY_FIXED:
        direction = 180 * (-self.bodyAngle) / pi;
        obj_marker.sprite_index = spr_marker_focusshot;// Shot (fixed)
        obj_marker.image_angle = 180 * (-self.bodyAngle) / pi;
        
        if (self.shotTime = 0)
        {
            scr_shot(x, y, direction);
            self.numShots++;
            self.shotTime = self.fixedDelay;
            
            audio_play_sound(snd_shot_1, 0, false);
        }
        else
        {
            self.shotTime--;
        }
        
        break;
    case global.BODY_CLAW:
        if ((self.clawTime = 0) && (self.clawDelayTime = 0))
        {
            self.clawTime = self.clawDuration;
            self.clawHitbox = instance_create(x, y, obj_claw_hitbox);
            self.clawFX = instance_create(x, y, obj_claw_fx);
            scr_clawhitbox_position(self);
            scr_claw_fx_position(self);
            
            audio_play_sound(snd_claw, 0, false);
        }
        else if (self.clawTime > 0)
        {
            self.clawTime--;
            scr_clawhitbox_position(self);
            scr_claw_fx_position(self);
        }
        else
        {
            global.bodyStatus = global.BODY_IDLE;
            with (obj_claw_hitbox) instance_destroy();
            with (obj_claw_fx) instance_destroy();
        }
        
        self.clawDelayTime = self.clawDelay;
        break;
}

if (self.clawDelayTime > 0)
{
    self.clawDelayTime--;
}

if (self.bodyAngle > (pi * 2))
{
    self.bodyAngle -= (pi * 2);
}
else if (self.bodyAngle < 0)
{
    self.bodyAngle += (pi * 2);
}

// MOVES (LEGS STATUS)
if (global.legsStatus = global.LEGS_JUMP)
{
    obj_marker.sprite_index = spr_marker_jump;
    if (self.jumpTicker < self.jumpDuration)
    {
        // Jump smoke
        if (self.jumpTicker = 0)
        {
            part_emitter_region(global.ps_ground, self.em_smoke, (self.x - 8), (self.x + 8), (self.y - 8), (self.y + 8), ps_shape_ellipse, ps_distr_invgaussian);
            part_type_direction(global.pt_smoke, (direction + 120), (direction + 240), 0, 0);
            part_emitter_burst(global.ps_ground, self.em_smoke, global.pt_smoke, 8);
            
            var jump_boost_fx = instance_create(self.x, self.y, obj_jump_boost);
            jump_boost_fx.image_angle = direction - 90;
            
            audio_play_sound(snd_jump, 0, false);
        }
        
        
        self.jumpTicker++;
        scr_jump_position(self);
    }
    else
    {
        self.jumpTicker = 0;
        self.legsAngle = self.mainAngle;
        global.legsStatus = global.BODY_IDLE;
        
        audio_play_sound(snd_land, 0, false);
    }
}
else
{
    self.legsAngle = self.mainAngle;
    
    x += (cos(self.legsAngle) * walk_speed) + self.conveyorMoveX;
    y += (sin(self.legsAngle) * walk_speed) + self.conveyorMoveY;
            
    self.conveyorMoveX = 0;
    self.conveyorMoveY = 0;
    
    switch (global.bodyStatus)
    {
        case global.BODY_AIMEDSHOT:
        case global.BODY_AIM:
            // Fixed position
            // Room here for optionnal "lock enemy" marker position
            break;
        default:
            obj_marker.x = x + cos(self.bodyAngle) * self.markerDistance;
            obj_marker.y = y + sin(self.bodyAngle) * self.markerDistance;
            break;
    }
    
    // Movement collision
    if (!global.clip)
    {
        if (collision_circle(x, y, 8, obj_wall, false, false))
        {
            if (!collision_circle(xprevious, y, 8, obj_wall, false, false))
            {
                x = xprevious;
            }
            else if (!collision_circle(x, yprevious, 8, obj_wall, false, false))
            {
                y = yprevious;
            }
            else if (!collision_circle(xprevious, yprevious, 8, obj_wall, false, false))
            {
                x = xprevious;
                y = yprevious;
            }
        }
        else if (collision_circle(x, y, 8, obj_player_wall, false, false))
        {
            if (!collision_circle(xprevious, y, 8, obj_player_wall, false, false))
            {
                x = xprevious;
            }
            else if (!collision_circle(x, yprevious, 8, obj_player_wall, false, false))
            {
                y = yprevious;
            }
            else if (!collision_circle(xprevious, yprevious, 8, obj_player_wall, false, false))
            {
                x = xprevious;
                y = yprevious;
            }
        }
    }
}

// DISPLAY
scr_get_legssprites(self);
scr_get_bodysprite(self);
