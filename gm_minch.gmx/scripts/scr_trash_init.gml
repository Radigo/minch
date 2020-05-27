/*
Conductor for Trash experience
- must be attached to dummy sprite (invisible)
- hold patterns settings
- keep track of patterns and followed path
*/

self.LAYOUT_TILE_WIDTH = 11;
self.LAYOUT_TILE_HEIGHT = 10;
self.LAYOUT_TILE_SIZE = 32;

self.PATTERN_SQUARE_PUNCH = "patternSquarePunch";
self.PATTERN_SQUARE_BURST = "patternSquareBurst";
self.PATTERN_SQUARE_SPIRAL = "patternSquareSpiral";
self.PATTERN_CROSS = "patternCross";
self.PATTERN_BAR = "patternBar";
self.PATTERN_I = "patternI";

self.DIRECTION_UP = "up";
self.DIRECTION_LEFT = "left";
self.DIRECTION_RIGHT = "right";

// Master list
var allPatterns = ds_list_create();
ds_list_add(allPatterns, self.PATTERN_SQUARE_PUNCH, self.PATTERN_SQUARE_BURST, self.PATTERN_SQUARE_SPIRAL, self.PATTERN_CROSS, self.PATTERN_BAR, self.PATTERN_I);
ds_list_shuffle(allPatterns);

// Force use at sequence begin and end
var squarePatterns = ds_list_create();
ds_list_add(squarePatterns, self.PATTERN_SQUARE_PUNCH, self.PATTERN_SQUARE_BURST, self.PATTERN_SQUARE_SPIRAL);
ds_list_shuffle(squarePatterns);

// Those can't follow each other
var unchainablePatterns = ds_list_create();
ds_list_add(unchainablePatterns, self.PATTERN_BAR, self.PATTERN_I);
ds_list_shuffle(unchainablePatterns);

// Save last
var lastPattern = ds_list_find_value(squarePatterns, 0);
// This should never fail...
ds_list_delete(allPatterns, ds_list_find_index(allPatterns, lastPattern));

// Determine patterns sequence
self.patternsSequence = ds_list_create();
var numPatterns = ds_list_size(allPatterns);
var lastPatternName = "undefined";

while (ds_list_size(allPatterns) > 0) {
     var nextPatternName = ds_list_find_value(allPatterns, 0);
     var success = true;
     var unchainableHasBeenChosen = false;
     
     for (var i = 0; i < ds_list_size(unchainablePatterns); i++) {
         var unchainablePatternName = ds_list_find_value(unchainablePatterns, i);
         if (ds_list_find_index(self.patternsSequence, unchainablePatternName) >= 0) {
             unchainableHasBeenChosen = true;
             break;
         }
     }
     
     var squareIndex = -1;
     var unchainableIndex = -1;
     
     // Filter
     if (ds_list_empty(self.patternsSequence)) {
         // First (and last) are squares
         squareIndex = ds_list_find_index(squarePatterns, nextPatternName);
         success = squareIndex >= 0;
     } else if (!unchainableHasBeenChosen && ((ds_list_size(allPatterns) < 4))) {
         // Get I or Bar before it's too late
         unchainableIndex = ds_list_find_index(unchainablePatterns, nextPatternName);
         success = unchainableIndex >= 0;
     } else if ((ds_list_find_index(unchainablePatterns, lastPatternName) >= 0) && (ds_list_find_index(unchainablePatterns, nextPatternName) >= 0)) {
         // Can't chain two unchainables
         success = false;
     }
     
     if (success) {
         // Populate sequence
         ds_list_add(self.patternsSequence, ds_list_find_value(allPatterns, 0));
         
         // Cleanup list
         ds_list_delete(allPatterns, 0);
         
         lastPatternName = nextPatternName;
     } else {
         // Cycle list
         ds_list_add(allPatterns, ds_list_find_value(allPatterns, 0));
         ds_list_delete(allPatterns, 0);
     }
}

ds_list_add(self.patternsSequence, lastPattern);

// Determine directions
self.patternX = self.x;
self.patternY = self.y;

// Master list
var allDirections = ds_list_create();
ds_list_add(allDirections, self.DIRECTION_UP, self.DIRECTION_LEFT, self.DIRECTION_RIGHT);
ds_list_shuffle(allDirections);

self.directionSequence = ds_list_create();
var numAttempts = 0;

for (var i = 0; i < ds_list_size(self.patternsSequence); i++) {
    var currentDirection = ds_list_find_value(allDirections, 0);
    var currentPattern = ds_list_find_value(self.patternsSequence, i);
    var success = undefined;
    
    // Check current mandatory directions
    if ((currentPattern == self.PATTERN_BAR) && (currentDirection == self.DIRECTION_UP)) {
        // Current cannot be up
        success = false;
    } else if (currentPattern == self.PATTERN_I) {
        // Current must be up
        currentDirection = self.DIRECTION_UP;
        success = true;
    }
    
    if (is_undefined(success)) {
        // Check VS next for mandatory direction
        if (i < (ds_list_size(self.patternsSequence) - 1)) {
            var nextPattern = ds_list_find_value(self.patternsSequence, (i+1));
            if ((nextPattern == self.PATTERN_BAR) && (currentDirection == self.DIRECTION_UP)) {
                // Next cannot be up
                success = false;
            } else if (nextPattern == self.PATTERN_I) {
                // Next must be up
                currentDirection = self.DIRECTION_UP;
                success = true;
            } else {
                success = true;
            }
        } else {
            // Last
            success = true;
        }
    }
    
    // Check VS previous to avoid way back
    if ((i > 0) && (success)) {
        var prevDirection = ds_list_find_value(self.directionSequence, (i-1));
        if ((currentDirection == self.DIRECTION_RIGHT) && (prevDirection == self.DIRECTION_LEFT)) {
            success = false;
        } else if ((currentDirection == self.DIRECTION_LEFT) && (prevDirection == self.DIRECTION_RIGHT)) {
            success = false;
        }
    }

    if (success) {
       ds_list_add(self.directionSequence, currentDirection);
       ds_list_shuffle(allDirections);
       numAttempts = 0;
    } else {
        // Cycle list
        ds_list_add(allDirections, ds_list_find_value(allDirections, 0));
        ds_list_delete(allDirections, 0);
        // On for another ride
        i--;
        numAttempts++;
        if (numAttempts > ds_list_size(allDirections)) {
            show_debug_message("could not find valid direction");
            break;
        }
    }
}

// debug
ds_list_clear(self.patternsSequence);
ds_list_add(self.patternsSequence, self.PATTERN_SQUARE_PUNCH);

show_debug_message("-- Trash sequence --");
for (var i = 0; i < ds_list_size(self.patternsSequence); i++) {
    show_debug_message(ds_list_find_value(self.patternsSequence, i) + " - " + ds_list_find_value(self.directionSequence, i));
}

// Instanciate objects
var originX = self.x - 176;
var originY = self.y - 176;
var tileSize = 32;

self.CLOSE_TOP_DOOR = 1;
self.OPEN_TOP_DOOR = 2;
self.CLOSE_BOTTOM_DOOR = 3;
self.OPEN_BOTTOM_DOOR = 4;
self.CLOSE_LEFT_DOOR = 5;
self.OPEN_LEFT_DOOR = 6;
self.CLOSE_RIGHT_DOOR = 7;
self.OPEN_RIGHT_DOOR = 8;

self.CAMERA_FOCUS_ON = 9;
self.CAMERA_FOCUS_OFF = 10;

// Create doors
self.topDoor = instance_create(0, 0, obj_door_h_1_bk);
with (self.topDoor) {
    scr_register_dynamic_object(obj_trash_conductor.CLOSE_TOP_DOOR, global.DOOR_CLOSE);
    scr_register_dynamic_object(obj_trash_conductor.OPEN_TOP_DOOR, global.DOOR_OPEN);
}
self.bottomDoor = instance_create(0, 0, obj_door_h_1_bk);
with (self.bottomDoor) {
    scr_register_dynamic_object(obj_trash_conductor.CLOSE_BOTTOM_DOOR, global.DOOR_CLOSE);
    scr_register_dynamic_object(obj_trash_conductor.OPEN_BOTTOM_DOOR, global.DOOR_OPEN);
}
self.leftDoor = instance_create(0, 0, obj_door_v_1_bk);
with (self.leftDoor) {
    scr_register_dynamic_object(obj_trash_conductor.CLOSE_LEFT_DOOR, global.DOOR_CLOSE);
    scr_register_dynamic_object(obj_trash_conductor.OPEN_LEFT_DOOR, global.DOOR_OPEN);
}
self.rightDoor = instance_create(0, 0, obj_door_v_1_bk);
with (self.rightDoor) {
    scr_register_dynamic_object(obj_trash_conductor.CLOSE_RIGHT_DOOR, global.DOOR_CLOSE);
    scr_register_dynamic_object(obj_trash_conductor.OPEN_RIGHT_DOOR, global.DOOR_OPEN);
}

// Instanciate first phase
switch (ds_list_find_value(self.patternsSequence, 0)) {
    case self.PATTERN_SQUARE_PUNCH:
        instance_create(self.x, self.y, obj_trash_pattern_squarepunch_instance);
        break;
         
    case self.PATTERN_SQUARE_BURST:
        instance_create(self.x, self.y, obj_trash_pattern_squareburst_instance);
        break;
         
    case self.PATTERN_SQUARE_SPIRAL:
        instance_create(self.x, self.y, obj_trash_pattern_squarespiral_instance);
        break;
         
    case self.PATTERN_CROSS:
        instance_create(self.x, self.y, obj_trash_pattern_cross_instance);
        break;
         
    case self.PATTERN_BAR:
        instance_create(self.x, self.y, obj_trash_pattern_bar_instance);
        break;
         
    case self.PATTERN_I:
        instance_create(self.x, self.y, obj_trash_pattern_i_instance);
        break;
}

// Respawn point
instance_create(self.x, self.y, obj_checkpoint_1);

// Camera focus
self.focus = instance_create(self.x, self.y, obj_dummy);
with (self.focus) {
    scr_register_dynamic_object(obj_trash_conductor.CAMERA_FOCUS_ON, global.CAMERA_FOCUS_ENEMY_ON);
    scr_register_dynamic_object(obj_trash_conductor.CAMERA_FOCUS_OFF, global.CAMERA_FOCUS_ENEMY_OFF);
}
