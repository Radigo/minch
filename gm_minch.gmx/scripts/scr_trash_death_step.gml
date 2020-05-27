/*
Escaping Trash
- wait a while then jumps in chosen direction
- disapears
*/

self.PHASE_STUN = "phaseStun";
self.PHASE_JUMP = "phaseJump";
self.PHASE_LAND = "phaseLand";
self.PHASE_ESCAPE = "phaseEscape";

if (self.currentPhase == self.PHASE_STUN) {
    if (self.ticker > self.tickerLimit) {
        if (ds_list_empty(obj_trash_conductor.patternsSequence)) {
            // Last pattern
            self.currentPhase = self.PHASE_GOODBYE;
            self.tickerLimit = 180;
            self.ticker = 0;
            self.sprite_index = spr_trash_goodbye;
            if (self.x < obj_trash_conductor.patternX) {
                self.image_xscale = -1;
            }
        } else {
            self.currentPhase = self.PHASE_JUMP;
            self.tickerLimit = self.jumpDuration;
            self.ticker = 0;
            
            switch (self.prevDirection) {
                case obj_trash_conductor.DIRECTION_UP:
                    self.sprite_index = spr_trash_jump_up;
                    break;
                case obj_trash_conductor.DIRECTION_LEFT:
                    self.sprite_index = spr_trash_jump_right;
                    self.image_xscale = -1;
                    break;
                case obj_trash_conductor.DIRECTION_RIGHT:
                    self.sprite_index = spr_trash_jump_right;
                    break;
            }
            
            self.speed = point_distance(self.x, self.y, self.landX, self.landY) / self.jumpDuration;
            self.direction = point_direction(self.x, self.y, self.landX, self.landY);
        }
    }
} else if (self.currentPhase == self.PHASE_GOODBYE) {
    // Open doors
    var tileSize = 32;
    if (obj_trash_conductor.leftFence.x > obj_trash_conductor.patternX - (tileSize * 3)) {
        obj_trash_conductor.leftFence.x -= 0.2;
    }
    
    if (obj_trash_conductor.rightFence.x < obj_trash_conductor.patternX + (tileSize * 3)) {
        obj_trash_conductor.rightFence.x += 0.2;
    }
    
    // Animate trash
    if (self.ticker == 100) {
        self.sprite_index = spr_trash_goodbye_look;
        if (self.x < obj_trash_conductor.patternX) {
            self.image_xscale = -1;
        }
    } else if (self.ticker > self.tickerLimit) {
        // Escapes
        self.currentPhase = self.PHASE_ESCAPE;
        self.tickerLimit = self.escapeDuration * 1.5;
        self.ticker = 0;
        
        var escapeX = obj_trash_conductor.patternX + (7 * obj_trash_conductor.LAYOUT_TILE_SIZE);
        
        self.sprite_index = spr_trash_jump_right;
        self.direction = 0;
        
        if (self.x < obj_trash_conductor.patternX) {
            escapeX = obj_trash_conductor.patternX - (7 * obj_trash_conductor.LAYOUT_TILE_SIZE);
            self.image_xscale = -1;
            self.direction = 180;
        }
        
        self.speed = abs(escapeX - self.x) / self.escapeDuration;
    }

} else if (self.currentPhase == self.PHASE_JUMP) {
    if (self.ticker > self.tickerLimit) {
        self.currentPhase = self.PHASE_LAND;
        self.tickerLimit = self.landDuration;
        self.ticker = 0;
        
        switch (self.prevDirection) {
            case obj_trash_conductor.DIRECTION_UP:
                self.sprite_index = spr_trash_land_up;
                break;
            case obj_trash_conductor.DIRECTION_LEFT:
                self.sprite_index = spr_trash_land_right;
                self.image_xscale = -1;
                break;
            case obj_trash_conductor.DIRECTION_RIGHT:
                self.sprite_index = spr_trash_land_right;
                break;
        }
        
        self.speed = 0;
    }
} else if (self.currentPhase == self.PHASE_LAND) {
    if (self.ticker > self.tickerLimit) {
        self.currentPhase = self.PHASE_ESCAPE;
        self.tickerLimit = self.escapeDuration;
        self.ticker = 0;
        
        switch (self.prevDirection) {
            case obj_trash_conductor.DIRECTION_UP:
                self.sprite_index = spr_trash_jump_up;
                break;
            case obj_trash_conductor.DIRECTION_LEFT:
                self.sprite_index = spr_trash_jump_right;
                self.image_xscale = -1;
                break;
            case obj_trash_conductor.DIRECTION_RIGHT:
                self.sprite_index = spr_trash_jump_right;
                break;
        }
        
        self.speed = point_distance(self.x, self.y, obj_trash_conductor.patternX, obj_trash_conductor.patternY) / self.escapeDuration;
        self.direction = point_direction(self.x, self.y, obj_trash_conductor.patternX, obj_trash_conductor.patternY);
    }
} else if (self.currentPhase == self.PHASE_ESCAPE) {
    if (self.ticker > self.tickerLimit) {
        with (self) instance_destroy();
    }
}
