//show_debug_message("ticker: " + string(self.ticker) + " > " + string(self.tickerLimit) + ", self.isIntro: " + string(self.isIntro) + ", move: " + self.move + " / patternTicker: " + string(self.patternTicker) + " > " + string(self.patternTickerLimit) + ", pattern: " + self.pattern);

if (!self.switchTriggered)
{
    return false;
}

// Calm before the storm
if (self.isIntro) {
    if (self.ticker > self.tickerLimit) {
        self.move = self.MOVE_RAGING;
        self.pattern = self.PATTERN_RAGING;
        self.ticker = 0;
        self.patternTicker = 0;
        self.isIntro = false;
    }
    
    return false;
} else if (self.isKillSequence) {
    instance_destroy(obj_ch1_laser_h);
    instance_destroy(obj_ch1_laser_h_charge);
    scr_ch1_killsequence();
    return false;
}

// Rage on
if (self.move == self.MOVE_RAGING) {
    // Just wait
    if (self.ticker == 1) {
        self.legs.sprite_index = spr_ch1_legs_idle;
        self.tickerLimit = 90;
    }
    
    if (self.ticker > self.tickerLimit) {
        self.move = self.MOVE_STATIC;
    }
} else if (self.move == self.MOVE_STATIC) {
    // Just wait
    if (self.ticker == 1) {
        self.legs.sprite_index = spr_ch1_legs_idle;
        self.tickerLimit = 90;
    }
    
    if (self.ticker > self.tickerLimit) {
        if (self.pattern == self.PATTERN_IDLE) {
            self.move = self.MOVE_JUMPING;
        }
    }
} else if (self.move == self.MOVE_JUMPING) {
    // Jumps up or down
    if (self.ticker == 1) {
        var forwardDistance = 48;
        var stompDistance = 92;
        self.jumpSourceX = self.x;
        self.jumpSourceY = self.y;
        
        if (obj_minch_feets.x < self.x + stompDistance) {
            self.jumpTargetX = obj_minch_feets.x;
            self.jumpTargetY = obj_minch_feets.y;
        } else {
            self.jumpTargetX = self.x + forwardDistance;
            if (self.y > self.jumpTargetYMiddle) {
                // From upper part to lower
                self.jumpTargetY = self.jumpTargetYMiddle - random(self.jumpTargetYMax - self.jumpTargetYMiddle);
            } else {
                // From lower part to upper
                self.jumpTargetY = self.jumpTargetYMiddle + random(self.jumpTargetYMax - self.jumpTargetYMiddle);
            }
        }
        
        if (self.jumpTargetY < self.jumpSourceY) {
            self.legs.sprite_index = spr_ch1_legs_jumpup;
        } else {
            self.legs.sprite_index = spr_ch1_legs_jumpdown;
        }
        self.tickerLimit = 30;
        
        // Jumping smoke FX
        part_emitter_region(self.ps_smoke, self.em_smoke, (self.x - 16), (self.x + 16), (self.y - 16), (self.y + 16), ps_shape_ellipse, ps_distr_invgaussian);
        part_type_direction(global.pt_smoke, (direction + 120), (direction + 240), 0, 0);
        part_emitter_burst(self.ps_smoke, self.em_smoke, global.pt_smoke, 10);
    }
    
    self.x = self.jumpSourceX + (self.ticker / self.tickerLimit) * (self.jumpTargetX - self.jumpSourceX);
    self.y = self.jumpSourceY + (self.ticker / self.tickerLimit) * (self.jumpTargetY - self.jumpSourceY);
    
    if (self.ticker > self.tickerLimit) {
        self.move = self.MOVE_STATIC;
        // Landing smoke FX
        part_emitter_region(self.ps_smoke, self.em_smoke, (self.x - 8), (self.x + 8), (self.y - 8), (self.y + 8), ps_shape_ellipse, ps_distr_invgaussian);
        part_type_direction(global.pt_smoke, 0, 360, 0, 0);
        part_emitter_burst(self.ps_smoke, self.em_smoke, global.pt_smoke, 16);
    }
}

// scr_bullet_shot((self.x + 20), (self.y - 32), scr_aim_at_minch(self, 5, 20, -32), 5, 2);

var switchOffLasers = false;

if (self.pattern == self.PATTERN_RAGING) {
    switchOffLasers = true;
    // Does nothing harmful
    if (self.patternTicker == 1) {
        self.sprite_index = spr_ch1_body_spread;
        self.patternTickerLimit = 90;
    }
} else if (self.pattern == self.PATTERN_IDLE) {
    switchOffLasers = true;
    // Does nothing at all
    if (self.patternTicker == 1) {
        self.sprite_index = spr_ch1_body_idle;
        self.patternTickerLimit = 60;
    }
} else if (self.pattern == self.PATTERN_LASERUP) {
    // Fire laser with left arm, warmup time, then short blast
    if (self.patternTicker == 1) {
        switchOffLasers = true;
        self.sprite_index = spr_ch1_body_laserup;
        self.patternTickerLimit = 60;
        var charge = instance_create(self.x + self.ARM_X, self.y + self.LEFT_ARM_Y, obj_ch1_laser_h_charge);
        charge.image_speed = 0.5;
    } else if ((self.patternTicker > self.SINGLE_LASER_WARMUP_TIME - 6)
              && (instance_number(obj_ch1_laser_h) == 0)) {
        instance_destroy(obj_ch1_laser_h_charge);
        var laser = instance_create(self.x + self.ARM_X, self.y + self.LEFT_ARM_Y, obj_ch1_laser_h);
        laser.image_speed = 0.5;
    } else if ((self.patternTicker > self.SINGLE_LASER_WARMUP_TIME)
              && (collision_rectangle(self.x + self.ARM_X, self.y + self.LEFT_ARM_Y - self.LASER_HALF_WIDTH,
                                      self.x + self.ARM_X + self.LASER_LENGTH, self.y + self.LEFT_ARM_Y + self.LASER_HALF_WIDTH,
                                      obj_minch_feets, false, false))) {
        scr_minch_death("laser");
    }
} else if (self.pattern == self.PATTERN_LASERDOWN) {
    // Fire laser with right arm, warmup time, then short blast
    if (self.patternTicker == 1) {
        switchOffLasers = true;
        
        self.sprite_index = spr_ch1_body_laserdown;
        self.patternTickerLimit = 60;
        var charge = instance_create(self.x + self.ARM_X, self.y + self.RIGHT_ARM_Y, obj_ch1_laser_h_charge);
        charge.image_speed = 0.5;
    } else if ((self.patternTicker > self.SINGLE_LASER_WARMUP_TIME - 6)
              && (instance_number(obj_ch1_laser_h) == 0)) {
        instance_destroy(obj_ch1_laser_h_charge);
        var laser = instance_create(self.x + self.ARM_X, self.y + self.RIGHT_ARM_Y, obj_ch1_laser_h);
        laser.image_speed = 0.5;
    } else if ((self.patternTicker > self.SINGLE_LASER_WARMUP_TIME)
              && (collision_rectangle(self.x + self.ARM_X, self.y + self.RIGHT_ARM_Y - self.LASER_HALF_WIDTH,
                                      self.x + self.ARM_X + self.LASER_LENGTH, self.y + self.RIGHT_ARM_Y + self.LASER_HALF_WIDTH,
                                      obj_minch_feets, false, false))) {
        scr_minch_death("laser");
    }
} else if (self.pattern == self.PATTERN_LASERTWIN) {
    // Fire lasers with both arms, warmup time (shorter), then medium long blast
    if (self.patternTicker == 1) {
        switchOffLasers = true;
        
        self.sprite_index = spr_ch1_body_lasertwin;
        self.patternTickerLimit = 90;
        var chargeL = instance_create(self.x + self.ARM_X, self.y + self.LEFT_ARM_Y, obj_ch1_laser_h_charge);
        chargeL.image_speed = 0.5;
        var chargeR = instance_create(self.x + self.ARM_X, self.y + self.RIGHT_ARM_Y, obj_ch1_laser_h_charge);
        chargeR.image_speed = 0.5;
    } else if ((self.patternTicker > self.TWIN_LASER_WARMUP_TIME - 6)
              && (instance_number(obj_ch1_laser_h) == 0)) {
        instance_destroy(obj_ch1_laser_h_charge);
        var laserL = instance_create(self.x + self.ARM_X, self.y + self.LEFT_ARM_Y, obj_ch1_laser_h);
        laserL.image_speed = 0.5;
        var laserR = instance_create(self.x + self.ARM_X, self.y + self.RIGHT_ARM_Y, obj_ch1_laser_h);
        laserR.image_speed = 0.5;
    } else if (self.patternTicker > self.TWIN_LASER_WARMUP_TIME) {
        if (collision_rectangle(
                self.x + self.ARM_X, self.y + self.LEFT_ARM_Y - self.LASER_HALF_WIDTH,
                self.x + self.ARM_X + self.LASER_LENGTH, self.y + self.LEFT_ARM_Y + self.LASER_HALF_WIDTH,
                obj_minch_feets, false, false)
            || collision_rectangle(
                self.x + self.ARM_X, self.y + self.RIGHT_ARM_Y - self.LASER_HALF_WIDTH,
                self.x + self.ARM_X + self.LASER_LENGTH, self.y + self.RIGHT_ARM_Y + self.LASER_HALF_WIDTH,
                obj_minch_feets, false, false)) {
            scr_minch_death("laser");
        }
    }
} else if (self.pattern == self.PATTERN_SPREADUP) {
    switchOffLasers = true;
    // Fire spread with left arm, no warmup, short blast
    if (self.patternTicker == 1) {
        self.sprite_index = spr_ch1_body_spreadup;
        self.patternTickerLimit = 30;
    } else if ((self.patternTicker > self.SINGLE_SPREAD_WARMUP_TIME)
               && (self.patternTicker % 4 == 0)) {
        var spreadAngle = 30;
        scr_pattern_spread(self.x + self.ARM_X, self.y + self.LEFT_ARM_Y, 0, 4, 3, 3, 60);
    }
} else if (self.pattern == self.PATTERN_SPREADDOWN) {
    switchOffLasers = true;
    // Fire spread with right arm, no warmup, short blast
    if (self.patternTicker == 1) {
        self.sprite_index = spr_ch1_body_spreaddown;
        self.patternTickerLimit = 30;
    } else if ((self.patternTicker > self.SINGLE_SPREAD_WARMUP_TIME)
               && (self.patternTicker % 4 == 0)) {
        scr_pattern_spread(self.x + self.ARM_X, self.y + self.RIGHT_ARM_Y, 0, 4, 3, 3, 60);
    }
} else if (self.pattern == self.PATTERN_SPREADTWIN) {
    switchOffLasers = true;
    // Fire spread with both arms, short warmup, long dense pattern
    if (self.patternTicker == 1) {
        self.sprite_index = spr_ch1_body_spreadtwin;
        self.patternTickerLimit = 180;
    } else if ((self.patternTicker > self.TWIN_SPREAD_WARMUP_TIME)
               && (self.patternTicker % 32 == 0)) {
        scr_pattern_spread(self.x + self.ARM_X, self.y + self.LEFT_ARM_Y, scr_get_moreorless(0, 10), 1.5, 2, irandom(2) + 3, 80);
        scr_pattern_spread(self.x + self.ARM_X, self.y + self.RIGHT_ARM_Y, scr_get_moreorless(0, 10), 1.5, 2, irandom(2) + 3, 80);
    }
} else if (self.pattern == self.PATTERN_SPREADSHOULDER) {
    switchOffLasers = true;
    // Rage pose, spawns modules that surround the place
    if (self.patternTicker == 1) {
        self.sprite_index = spr_ch1_body_spread;
        self.patternTickerLimit = 540;
        self.podsLeft = self.NUM_PODS;
    } else if ((self.podsLeft > 0)
              && (self.patternTicker > self.PODS_SPAWN_WARMUP_TIME)
              && (self.patternTicker % self.PODS_SPAWN_DELAY == 0)) {
        // Spawning pods
        var pod;
        var randPodColor = irandom(1);
        if (randPodColor == 0) {
            pod = instance_create(self.x, self.y, obj_pod_cy);
        } else if (randPodColor == 1) {
            pod = instance_create(self.x, self.y, obj_pod_ma);
        }
        pod.parentCarrier = self;
        pod.sourceX = self.x;
        pod.travelTargetX = self.x + 128;
        pod.sourceY = self.y;
        pod.spawnTimeOffset = self.patternTicker;
        if ((self.podsLeft % 2) == 0) {
           pod.travelDirection = -1;
        }
        
        self.podsLeft--;
    }
}

if (switchOffLasers) {
    //show_debug_message("switchOffLasers");

    for (var i = 0; i < instance_number(obj_ch1_laser_h); i += 1){
        var laserInstance = instance_find(obj_ch1_laser_h, i);

        part_emitter_region(global.ps_light, self.em_greenlaser_dots, laserInstance.bbox_left, laserInstance.bbox_right, laserInstance.y, laserInstance.y, ps_shape_line, ps_distr_linear);
        part_type_direction(self.pt_greenlaser, 0, 360, 0, 0);
        part_emitter_burst(global.ps_light, self.em_greenlaser_dots, self.pt_greenlaser, 48);
        
        instance_destroy(laserInstance);
    }
    
    instance_destroy(obj_ch1_laser_h_charge);// Just in case
}

// Script will choose what comes next and reset ticker
scr_ch1_setnextpattern();

// Move legs with body
self.legs.x = self.x + self.legsRelativePositionX;
self.legs.y = self.y + self.legsRelativePositionY;
