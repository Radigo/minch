if (self.isIntro) {
    // Wait for MinCH to shoot at us or if we move too close
    if (collision_circle(self.x, self.y, 64, obj_shot, false, true) || collision_circle(self.x, self.y, 64, obj_minch_feets, false, true)) {
       instance_create(self.x, self.y, obj_katana_shield);
       self.isIntro = false;
       self.ticker = 0;
    } 
    
    return false;
}

//show_debug_message("napalm step:" + string(self.currentPattern) + ", phase: " + string(self.currentPhase) + ", ticker: " + string(self.ticker));
//show_debug_message(string(self.yList[| irandom(3)]));
//show_debug_message(string(point_distance(self.x, self.y, self.targetCol, self.targetRow)));

if ((self.currentPhase == self.ONE_KATANA) && (self.hp < self.phaseTwoHp)) {
    // Switch to next phase
    self.currentPhase = self.TWO_KATANAS;
    self.currentPattern = self.TRANSITION;
    self.shield = true;
    self.ticker = 0;
    scr_boom(self.x, self.y, self.explosionLevel, self.explosionSize);
} else if ((self.currentPhase == self.TWO_KATANAS) && (self.hp < self.phaseFourHp)) {
    // Switch to next phase
    self.currentPhase = self.FOUR_KATANAS;
    self.currentPattern = self.TRANSITION;
    self.shield = true;
    self.ticker = 0;
    scr_boom(self.x, self.y, self.explosionLevel, self.explosionSize);
} else if ((self.currentPhase == self.FOUR_KATANAS) && (self.hp < self.phaseFinaleHp)) {
    // Switch to diying phase
    self.currentPhase = self.DIYING;
    self.currentPattern = self.TRANSITION;
    self.shield = true;
    self.ticker = 0;
    scr_boom(self.x, self.y, self.explosionLevel, self.explosionSize * 1.6);
}

if (self.currentPhase == self.DIYING) {
    return false;
}

// Moves (if not dying)
if (self.currentPattern == self.REACH_SIDE) {
    if (self.targetX > self.x)
        self.x += 3;
    else
        self.x -= 3;
    self.y = self.targetY + ((self.y - self.targetY) * 0.9);
    scr_fly_katana_shield_step(self.x, self.y, scr_aim_at_minch(self, 0, 0, 0), 32, 0.8);
    
    if (point_distance(self.x, self.y, self.targetX, self.targetY) < 2) {
        // TODO: Select closest row to minch y
        self.x = self.targetX;
        self.y = self.targetY;
        self.targetY = self.yList[| irandom(3)];
        self.currentPattern = self.SEARCH_MINCH_Y;
        sprite_index = spr_napalm;
    }
} else if (self.currentPattern == self.SEARCH_MINCH_Y) {
    self.y += 4;
    scr_fly_katana_shield_step(self.x, self.y, scr_aim_at_minch(self, 0, 0, 0), 16, 0.08);
    
    if (point_distance(self.x, self.y, self.targetX, self.targetY) < 6) {
        self.ticker = 0;
        self.currentPattern = self.RUSH_MINCH;
        sprite_index = spr_napalm_rush;
        if (self.x > self.col1)// Right side
            self.slashDirection = -1;
        else
            self.slashDirection = 1;
        
        image_xscale = self.slashDirection;
    }
} else if (self.currentPattern == self.RUSH_MINCH) {
    self.shield = true;
    if (self.ticker < 30) {
        // Getset
        self.targetX = obj_minch.x;
        // Prevent OOB of boss... send him on the other side of room in case of panic
        if ((self.slashDirection > 0) && (self.targetX > self.col2))
            self.targetX = self.col0;
        else if ((self.slashDirection < 0) && (self.targetX < self.col0))
            self.targetX = self.col2;
        scr_fly_katana_shield_step(self.x, self.y, scr_aim_at_minch(self, 0, 0, 0), 16, 0.9);
    } else {
        // Rush
        self.x += self.slashDirection * 4;
        
        var katanaAngle = 180;
        if (self.slashDirection < 0)
            katanaAngle = 0;
        scr_fly_katana_shield_step(self.x, self.y, katanaAngle, 16, 0.9);
        
        if (point_distance(self.x, self.y, self.targetX, self.targetY) < 16) {
            self.shield = false;
            self.ticker = 0;
            instance_create(self.x, self.y, obj_slash_r);
            
            var slashScale = self.slashDirection;
            with (obj_slash_r) {
                image_xscale = slashScale;
            }
            
            self.targetX += 32 * self.slashDirection;
            
            image_speed = 0.25;
            sprite_index = spr_napalm_slash_a;
            self.currentPattern = self.RUSH_SLASH;
        }
    }
} else if (self.currentPattern == self.RUSH_SLASH) {
    // Slash n slowdown
    scr_fly_katana_shield_step(self.x, self.y, scr_aim_at_minch(self, 0, 0, 0), 24, 0.1);
    
    if (self.ticker < 60) {
        if ((self.currentPhase == self.TWO_KATANAS) || (self.currentPhase == self.FOUR_KATANAS)) {
            // Throw bullets in front
            var slash_ratio = (self.ticker / 50);
            if ((slash_ratio <= 1) && ((self.ticker % 6) == 0)) {
                var spread_width = 48;
                var spread_angle_width = 64;
                
                var pattern_origin_x = self.x + (10 * image_xscale);
                var pattern_origin_y = self.y - (spread_width / 2) + (spread_width * slash_ratio);
                var shot_angle = -(spread_angle_width /2) + (spread_angle_width * slash_ratio);
                if (image_xscale < 0)
                    shot_angle = -shot_angle + 180;
                var shot_speed = 1 + (2 * slash_ratio);
                
                scr_bullet_shot(pattern_origin_x, pattern_origin_y, shot_angle, shot_speed, 3);
            }
        }
        self.y = self.targetY + ((self.y - self.targetY) * 0.98);
        scr_loop_stop();
    } else {
        self.targetX = self.xList[| irandom(1)];
        self.targetY = self.yList[| irandom(0)];// Always on top
        self.ticker = 0;
        
        if (self.currentPhase == self.ONE_KATANA) {
            // Move on
            self.currentPattern = self.REACH_SIDE;
            sprite_index = spr_napalm_rush;
            if (self.targetX > x)
                image_xscale = 1;
            else
                image_xscale = -1;
        } else {
            // Second slash
            self.shield = false;
            self.ticker = 0;
            
            image_speed = 0.25;
            sprite_index = spr_napalm_slash_b;
            self.currentPattern = self.RUSH_SLASH_BIS;
        }
    }
} else if (self.currentPattern == self.RUSH_SLASH_BIS) {
    if (self.ticker < 60) {
        var circle_ratio = (self.ticker / 50);
        if (circle_ratio < 1) {
            if (instance_number(obj_katana) == 0) instance_create(self.x, self.y, obj_katana);
            obj_katana.x = self.x - (dcos(360 * circle_ratio + 180) * 32) * image_xscale;
            obj_katana.y = self.y + dsin(360 * circle_ratio + 180) * 32;
            obj_katana.image_angle = 360 * circle_ratio * image_xscale;
            obj_katana.image_yscale = -image_xscale;
            
            if (image_xscale < 0) obj_katana.image_angle += 180;
        } else {
            instance_destroy(obj_katana);
        }
        
        if ((self.currentPhase == self.FOUR_KATANAS) && (self.ticker == 16)) {
            for (var i = 0; i < 8; i++) {
                var circle_angle = i * (360 / 8);
                var source_x = self.x + dcos(circle_angle) * 12;
                var source_y = self.y - dsin(circle_angle) * 12;
                scr_bullet_shot(source_x, source_y, scr_get_moreorless(circle_angle, 5), 1, 3);
                scr_bullet_shot(source_x, source_y, scr_get_moreorless(circle_angle, 3), 2, 2);
                scr_bullet_shot(source_x, source_y, scr_get_moreorless(circle_angle, 1), 2.5, 2);
            }
        }
        scr_loop_stop();
    } else {
        // Move on
            self.currentPattern = self.REACH_SIDE;
            sprite_index = spr_napalm_rush;
            if (self.targetX > x)
                image_xscale = 1;
            else
                image_xscale = -1;
    }
} else if (self.currentPattern == self.TRANSITION) {
    // Stops for a moment if not diying
    if ((self.currentPhase != self.DIYING) && (self.ticker > 16)) {
        self.shield = false;
        self.targetX = self.xList[| irandom(1)];
        self.targetY = self.yList[| 0];
        self.currentPattern = self.REACH_SIDE;
    }
}

/*
if (self.currentPhase == self.ONE_KATANA) {
    // Fly one katana around as a shield
    // Rushes horizontally and slashes when reaching MinCH x
    // Slash forward when rushing
} else if (self.currentPhase == self.TWO_KATANAS) {
    // An extra katana flies for vertical hits
    // Slash forward and sides when rushing
} else if (self.currentPhase == self.FOUR_KATANAS) {
    // 2 extra katanas fly randomly in the room
    // Find a nice slash pattern if necessary
}
*/
