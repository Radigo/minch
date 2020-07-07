// Focus
var roomCenterX = self.originX + (obj_trash_conductor.LAYOUT_TILE_SIZE * 5.5);
var roomCenterY = self.originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 5.5);

var xDiff = (roomCenterX) - obj_trash_conductor.focus.x;
if (abs(xDiff) > 1) {
    obj_trash_conductor.focus.x += max(xDiff * 0.007, 1);
} else {
    obj_trash_conductor.focus.x = roomCenterX;
}

var yDiff = roomCenterY - obj_trash_conductor.focus.y;
if (abs(yDiff) > 1) {
    obj_trash_conductor.focus.y -= max(yDiff * 0.007, 1);
} else {
    obj_trash_conductor.focus.y = roomCenterY;
}

if (self.currentPhase == self.PHASE_IDLE) {
    // Wait in shield protection state
    if (part_emitter_exists(global.ps_ground, self.em_fx)) {
        part_emitter_region(global.ps_ground, self.em_fx, (self.x - 2), (self.x + 2), (self.y - 16), (self.y + 4), ps_shape_ellipse, ps_distr_gaussian);
    }

    // Activates when we come too close
    var triggered = false;
    if (self.incomingDirection == obj_trash_conductor.DIRECTION_UP) {
        triggered = obj_minch_feets.y < self.originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 8);
    } else if (self.incomingDirection == obj_trash_conductor.DIRECTION_LEFT) {
        triggered = obj_minch_feets.x < self.originX + (obj_trash_conductor.LAYOUT_TILE_SIZE * 9);
    } else if (self.incomingDirection == obj_trash_conductor.DIRECTION_RIGHT) {
        triggered = obj_minch_feets.x > self.originX + (obj_trash_conductor.LAYOUT_TILE_SIZE * 2);
    }
    
    if (triggered) {
        self.currentPhase = self.PHASE_ACTIVE;
        self.ticker = 0;
        self.patternTicker = 0;
        self.shield = false;
        
        var hasTopDoor = true;
        var hasBottomDoor = true;
        var hasLeftDoor = true;
        var hasRightDoor = true;
        
        if (ds_list_size(obj_trash_conductor.patternsSequence) == 1) {
            hasTopDoor = false;
        } else if (object_get_name(object_index) == "obj_trash_pattern_bar_instance") {
            hasTopDoor = false;
            hasBottomDoor = false;
        } else if (object_get_name(object_index) == "obj_trash_pattern_i_instance") {
            hasLeftDoor = false;
            hasRightDoor = false;
        }
        
        // Move all real doors and close them
        if (hasTopDoor) {
            obj_trash_conductor.topDoor.x = self.originX + (obj_trash_conductor.LAYOUT_TILE_SIZE * 5);
            obj_trash_conductor.topDoor.y = self.originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 1);
            obj_trash_conductor.topDoor.image_alpha = 1;
            scr_switch_machine(obj_trash_conductor.CLOSE_TOP_DOOR);
        }
        
        if (hasBottomDoor) {
            obj_trash_conductor.bottomDoor.x = self.originX + (obj_trash_conductor.LAYOUT_TILE_SIZE * 5);
            obj_trash_conductor.bottomDoor.y = self.originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 9);
            obj_trash_conductor.bottomDoor.image_alpha = 1;
            scr_switch_machine(obj_trash_conductor.CLOSE_BOTTOM_DOOR);
        }
        
        if (hasLeftDoor) {
            obj_trash_conductor.leftDoor.x = self.originX;
            obj_trash_conductor.leftDoor.y = self.originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 5);
            obj_trash_conductor.leftDoor.image_alpha = 1;
            scr_switch_machine(obj_trash_conductor.CLOSE_LEFT_DOOR);
        }
        
        if (hasRightDoor) {
            obj_trash_conductor.rightDoor.x = self.originX + (obj_trash_conductor.LAYOUT_TILE_SIZE * 10);
            obj_trash_conductor.rightDoor.y = self.originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 5);
            obj_trash_conductor.rightDoor.image_alpha = 1;
            scr_switch_machine(obj_trash_conductor.CLOSE_RIGHT_DOOR);
        }
        
        // Move respawn point
        obj_checkpoint_1.x = self.respawnX;
        obj_checkpoint_1.y = self.respawnY;
        
        // Camera focus
        scr_switch_machine(obj_trash_conductor.CAMERA_FOCUS_ON);
        self.sprite_index = spr_trash_idle;
        
        // Extra FX
        part_type_speed(self.pt_fx, 0.1, 4, -0.05, 0);
        part_type_life(self.pt_fx, 10, 80);
        part_type_gravity(self.pt_fx, 0, 0);
        part_type_direction(self.pt_fx, 0, 360, 0, 1);
        part_emitter_burst(global.ps_ground, self.em_fx, self.pt_fx, 40);
        // Stop particles stream
        part_emitter_destroy(global.ps_ground, self.em_fx);
    }
    
    return false;
} else if (self.currentPhase == self.PHASE_ACTIVE) {
    return true;
}
