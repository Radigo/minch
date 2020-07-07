/*
Escaping Trash
- stunned and escapes to the next pattern
- or explodes and... escapes
*/
show_debug_message("scr_trash_death_init");
show_debug_message(ds_list_find_value(obj_trash_conductor.patternsSequence, 0));

scr_ai_init();

// SETTINGS
self.PHASE_STUN = "phaseStun";
self.PHASE_JUMP = "phaseJump";
self.PHASE_LAND = "phaseLand";
self.PHASE_ESCAPE = "phaseEscape";
self.PHASE_GOODBYE = "phaseGoodBye";// Last pattern ending

self.stunDuration = 40;
self.jumpDuration = 30;
self.landDuration = 10;
self.escapeDuration = 30;

// Inits
self.currentPhase = self.PHASE_STUN;
self.tickerLimit = self.stunDuration;
self.shield = true;
self.sprite_index = spr_trash_land_down;
self.landX = self.x;
self.landY = self.y;

self.prevPattern = ds_list_find_value(obj_trash_conductor.patternsSequence, 0);
ds_list_delete(obj_trash_conductor.patternsSequence, 0);
self.prevDirection = ds_list_find_value(obj_trash_conductor.directionSequence, 0);
ds_list_delete(obj_trash_conductor.directionSequence, 0);

// Last pattern
if (ds_list_empty(obj_trash_conductor.patternsSequence)) {
    // Longer stun
    self.tickerLimit = 90;
    return false;
}

self.currentPattern = ds_list_find_value(obj_trash_conductor.patternsSequence, 0);
self.currentDirection = ds_list_find_value(obj_trash_conductor.directionSequence, 0);

switch (prevDirection) {
    case obj_trash_conductor.DIRECTION_UP:
        obj_trash_conductor.patternY -= (obj_trash_conductor.LAYOUT_TILE_HEIGHT * obj_trash_conductor.LAYOUT_TILE_SIZE);
        scr_switch_machine(obj_trash_conductor.OPEN_TOP_DOOR);
        
        self.landX = obj_trash_conductor.patternX;
        self.landY = obj_trash_conductor.patternY + (7 * obj_trash_conductor.LAYOUT_TILE_SIZE);
        break;
    case obj_trash_conductor.DIRECTION_LEFT:
        obj_trash_conductor.patternX -= (obj_trash_conductor.LAYOUT_TILE_WIDTH * obj_trash_conductor.LAYOUT_TILE_SIZE);
        scr_switch_machine(obj_trash_conductor.OPEN_LEFT_DOOR);
        
        self.landX = obj_trash_conductor.patternX + (7 * obj_trash_conductor.LAYOUT_TILE_SIZE);
        self.landY = obj_trash_conductor.patternY;
        break;
    case obj_trash_conductor.DIRECTION_RIGHT:
        obj_trash_conductor.patternX += (obj_trash_conductor.LAYOUT_TILE_WIDTH * obj_trash_conductor.LAYOUT_TILE_SIZE);
        scr_switch_machine(obj_trash_conductor.OPEN_RIGHT_DOOR);
        
        self.landX = obj_trash_conductor.patternX - (7 * obj_trash_conductor.LAYOUT_TILE_SIZE);
        self.landY = obj_trash_conductor.patternY;
        break;
}

switch (self.currentPattern) {
    case obj_trash_conductor.PATTERN_SQUARE_PUNCH:
        var nextPattern = instance_create(obj_trash_conductor.patternX, obj_trash_conductor.patternY, obj_trash_pattern_squarepunch_instance);
        break;
         
    case obj_trash_conductor.PATTERN_SQUARE_BURST:
        var nextPattern = instance_create(obj_trash_conductor.patternX, obj_trash_conductor.patternY, obj_trash_pattern_squareburst_instance);
        break;
         
    case obj_trash_conductor.PATTERN_SQUARE_SPIRAL:
        var nextPattern = instance_create(obj_trash_conductor.patternX, obj_trash_conductor.patternY, obj_trash_pattern_squarespiral_instance);
        break;
         
    case obj_trash_conductor.PATTERN_CROSS:
        var nextPattern = instance_create(obj_trash_conductor.patternX, obj_trash_conductor.patternY, obj_trash_pattern_cross_instance);
        break;
         
    case obj_trash_conductor.PATTERN_RING:
        var nextPattern = instance_create(obj_trash_conductor.patternX, obj_trash_conductor.patternY, obj_trash_pattern_ring_instance);
        break;
         
    case obj_trash_conductor.PATTERN_BAR:
        var nextPattern = instance_create(obj_trash_conductor.patternX, obj_trash_conductor.patternY, obj_trash_pattern_bar_instance);
        break;
         
    case obj_trash_conductor.PATTERN_I:
        var nextPattern = instance_create(obj_trash_conductor.patternX, obj_trash_conductor.patternY, obj_trash_pattern_i_instance);
        break;
}

nextPattern.incomingDirection = self.prevDirection;
