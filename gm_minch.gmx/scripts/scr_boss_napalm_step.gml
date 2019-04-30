TODO: loses focus when minch dies

scr_ai_step();

if (self.isIntro) {
    // Wait for MinCH to shoot at us or if we move too close
    if (collision_circle(self.x, self.y, 64, obj_shot, false, true)) {
       instance_create(self.x, self.y, obj_katana);
       self.isIntro = false;
       self.ticker = 0;
    }
    
    return false;
}

//show_debug_message("napalm step:");
//show_debug_message(string(self.yList[| irandom(3)]));
//show_debug_message(string(self.currentPattern));
//show_debug_message(string(point_distance(self.x, self.y, self.targetCol, self.targetRow)));


// Moves
if (self.currentPattern == self.REACH_SIDE) {
    if (self.targetX > self.x)
        self.x += 3;
    else
        self.x -= 3;
    self.y = self.targetY + ((self.y - self.targetY) * 0.9);
    scr_fly_katana_shield_step(self.x, self.y, obj_katana.x, obj_katana.y, scr_aim_at_minch(self, 0, 0, 0), 32, 0.8);
    
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
    scr_fly_katana_shield_step(self.x, self.y, obj_katana.x, obj_katana.y, scr_aim_at_minch(self, 0, 0, 0), 16, 0.08);
    
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
    if (self.ticker < 60) {
        // Getset
        self.targetX = obj_minch.x;
        // Prevent OOB of boss... send him on the other side of room in case of panic
        if ((self.slashDirection > 0) && (self.targetX > self.col2))
            self.targetX = self.col0;
        else if ((self.slashDirection < 0) && (self.targetX < self.col0))
            self.targetX = self.col2;
        scr_fly_katana_shield_step(self.x, self.y, obj_katana.x, obj_katana.y, scr_aim_at_minch(self, 0, 0, 0), 16, 0.9);
    } else {
        // Rush
        self.x += self.slashDirection * 4;
        
        var katanaAngle = 180;
        if (self.slashDirection < 0)
            katanaAngle = 0;
        scr_fly_katana_shield_step(self.x, self.y, obj_katana.x, obj_katana.y, katanaAngle, 16, 0.9);
        
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
    scr_fly_katana_shield_step(self.x, self.y, obj_katana.x, obj_katana.y, scr_aim_at_minch(self, 0, 0, 0), 32, 0.1);
    
    if (self.ticker < 120) {
        self.y = self.targetY + ((self.y - self.targetY) * 0.98);
        scr_loop_stop();
    } else {
        self.targetX = self.xList[| irandom(1)];
        self.targetY = self.yList[| irandom(0)];// Always on top
        self.ticker = 0;
        self.currentPattern = self.REACH_SIDE;
        sprite_index = spr_napalm_rush;
        if (self.targetX > x)
            image_xscale = 1;
        else
            image_xscale = -1;
    }
}






if (self.currentPhase == self.ONE_KATANA) {
    // Fly one katana around as a shield
    // Rushes horizontally and slashes when reaching MinCH x
    // Slash forward when rushing
} else if (self.currentPattern == self.TWO_KATANA) {
    // An extra katana flies for vertical hits
    // Slash forward and sides when rushing
} else if (self.currentPattern == self.FOUR_KATANA) {
    // 2 extra katanas fly randomly in the room
    // Find a nice slash pattern if necessary
}
