/*
Active instance of Trash
- base init for any Trash instance (pattern)
- all steps are custom for each trash pattern
*/

scr_ai_init();

// SETTINGS
self.PHASE_IDLE = "phaseIdle";
self.PHASE_ACTIVE = "phaseActive";

// Inits
self.currentPhase = self.PHASE_IDLE;
self.explosionSize = 24;
self.explosionLevel = 3;
self.hp = 100;
self.shield = true;
// Because global.ps_ground.depth = 1000;
self.depth = -100;

// Build phase @ given position
//show_debug_message("scr_trash_instance_init: " + object_get_name(object_index) + " @ " + string(self.x) + ", " + string(self.y));

self.incomingDirection = obj_trash_conductor.DIRECTION_UP;

self.originX = self.x - 176;
self.originY = self.y - 176;

self.respawnX = self.originX + (obj_trash_conductor.LAYOUT_TILE_SIZE * 5.5);
self.respawnY = self.originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 7.5);

// Always build side walls
var wall_tl = instance_create(self.originX, self.originY, obj_player_wall);
wall_tl.image_xscale = 5;
wall_tl.image_yscale = 2;
var wall_lt = instance_create(self.originX, self.originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 2), obj_player_wall);
wall_lt.image_xscale = 1;
wall_lt.image_yscale = 3;
var wall_lb = instance_create(self.originX, self.originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 6), obj_player_wall);
wall_lb.image_xscale = 1;
wall_lb.image_yscale = 3;
var wall_bl = instance_create(self.originX, self.originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 9), obj_player_wall);
wall_bl.image_xscale = 5;
wall_bl.image_yscale = 1;

var wall_tr = instance_create(self.originX + (obj_trash_conductor.LAYOUT_TILE_SIZE * 6), self.originY, obj_player_wall);
wall_tr.image_xscale = 5;
wall_tr.image_yscale = 2;
var wall_rt = instance_create(self.originX + (obj_trash_conductor.LAYOUT_TILE_SIZE * 10), self.originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 2), obj_player_wall);
wall_rt.image_xscale = 1;
wall_rt.image_yscale = 3;
var wall_rb = instance_create(self.originX + (obj_trash_conductor.LAYOUT_TILE_SIZE * 10), self.originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 6), obj_player_wall);
wall_rb.image_xscale = 1;
wall_rb.image_yscale = 3;
var wall_br = instance_create(self.originX + (obj_trash_conductor.LAYOUT_TILE_SIZE * 6), self.originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 9), obj_player_wall);
wall_br.image_xscale = 5;
wall_br.image_yscale = 1;

// Build all (fake) doors
var hasTopDoor = true;
var hasBottomDoor = true;
var hasLeftDoor = true;
var hasRightDoor = true;

switch (object_get_name(object_index)) {
    case "obj_trash_pattern_squarepunch_instance":
    case "obj_trash_pattern_squareburst_instance":
    case "obj_trash_pattern_squarespiral_instance":
        if (ds_list_size(obj_trash_conductor.patternsSequence) > 1) {
            var layout = instance_create(self.x, self.y, obj_trash_layout_square);
            layout.depth = 10000;
        } else {
            var layout = instance_create(self.x, self.y, obj_trash_layout_square_end);
            layout.depth = 10000;
            
            obj_area_end_level.x = self.originX + (obj_trash_conductor.LAYOUT_TILE_SIZE * 5);
            obj_area_end_level.y = self.originY;
            
            with (obj_trash_conductor) {
                self.leftFence = instance_create(self.x, self.y, obj_trash_layout_square_end_fence);
                self.rightFence = instance_create(self.x, self.y, obj_trash_layout_square_end_fence);
                self.rightFence.image_xscale = -1;
            }
            
            obj_trash_conductor.leftFence.x = self.originX + (obj_trash_conductor.LAYOUT_TILE_SIZE * 3);
            obj_trash_conductor.leftFence.y = self.originY;
            obj_trash_conductor.rightFence.x = self.originX + (obj_trash_conductor.LAYOUT_TILE_SIZE * 8);
            obj_trash_conductor.rightFence.y = self.originY;
            obj_trash_conductor.rightFence.image_xscale = -1;
            
            var leftEndWall = instance_create(self.originX, self.originY, obj_trash_layout_square_end_wall);
            leftEndWall.depth =  obj_trash_conductor.leftFence.depth -1;
            var rightEndWall = instance_create(self.originX + (obj_trash_conductor.LAYOUT_TILE_SIZE * 11), self.originY, obj_trash_layout_square_end_wall);
            rightEndWall.depth =  obj_trash_conductor.rightFence.depth -1;
            rightEndWall.image_xscale = -1;
            
            hasTopDoor = false;
        }
        
        self.x = self.originX + (obj_trash_conductor.LAYOUT_TILE_SIZE * 5.5);
        self.y = self.originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 3.5);
        break;
         
    case "obj_trash_pattern_cross_instance":
        var layout = instance_create(self.x, self.y, obj_trash_layout_cross);
        layout.depth = 10000;
        
        var tl_corner = instance_create(self.originX + (obj_trash_conductor.LAYOUT_TILE_SIZE * 1), self.originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 1), obj_player_wall);
        tl_corner.image_xscale = 3.5;
        tl_corner.image_yscale = 3.5;
        var tr_corner = instance_create(self.originX + (obj_trash_conductor.LAYOUT_TILE_SIZE * 6.5), self.originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 1), obj_player_wall);
        tr_corner.image_xscale = 3.5;
        tr_corner.image_yscale = 3.5;
        var bl_corner = instance_create(self.originX + (obj_trash_conductor.LAYOUT_TILE_SIZE * 1), self.originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 6.5), obj_player_wall);
        bl_corner.image_xscale = 3.5;
        bl_corner.image_yscale = 3.5;
        var br_corner = instance_create(self.originX + (obj_trash_conductor.LAYOUT_TILE_SIZE * 6.5), self.originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 6.5), obj_player_wall);
        br_corner.image_xscale = 3.5;
        br_corner.image_yscale = 3.5;
        
        self.x = self.originX + (obj_trash_conductor.LAYOUT_TILE_SIZE * 5.5);
        self.y = self.originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 5.5);
        break;
         
    case "obj_trash_pattern_ring_instance":
        var layout = instance_create(self.x, self.y, obj_trash_layout_ring);
        layout.depth = 10000;
        
        var crates = instance_create(self.originX + (obj_trash_conductor.LAYOUT_TILE_SIZE * 2.5), self.originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 3.5), obj_player_wall);
        crates.image_xscale = 6;
        crates.image_yscale = 4;
        
        self.x = self.originX + (obj_trash_conductor.LAYOUT_TILE_SIZE * 5.5);
        self.y = self.originY + 146;
        break;
         
    case "obj_trash_pattern_bar_instance":
        var layout = instance_create(self.x, self.y, obj_trash_layout_bar);
        layout.depth = 10000;
        
        var t_wall = instance_create(self.originX + (obj_trash_conductor.LAYOUT_TILE_SIZE * 1), self.originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 1), obj_player_wall);
        t_wall.image_xscale = 9;
        t_wall.image_yscale = 3.5;
        var b_wall = instance_create(self.originX + (obj_trash_conductor.LAYOUT_TILE_SIZE * 1), self.originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 6.5), obj_player_wall);
        b_wall.image_xscale = 9;
        b_wall.image_yscale = 3.5;
        
        hasTopDoor = false;
        hasBottomDoor = false;
        break;
         
    case "obj_trash_pattern_i_instance":
        var layout = instance_create(self.x, self.y, obj_trash_layout_i);
        layout.depth = 10000;
        
        var l_wall = instance_create(self.originX + (obj_trash_conductor.LAYOUT_TILE_SIZE * 1), self.originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 1), obj_player_wall);
        l_wall.image_xscale = 3.5;
        l_wall.image_yscale = 8;
        var r_wall = instance_create(self.originX + (obj_trash_conductor.LAYOUT_TILE_SIZE * 6.5), self.originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 1), obj_player_wall);
        r_wall.image_xscale = 3.5;
        r_wall.image_yscale = 8;
        
        self.x = self.originX + (obj_trash_conductor.LAYOUT_TILE_SIZE * 5.5);
        self.y = self.originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 4.5);
        
        hasLeftDoor = false;
        hasRightDoor = false;
        
        self.respawnX = self.originX + (obj_trash_conductor.LAYOUT_TILE_SIZE * 5.5);
        self.respawnY = self.originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 7.5);
        break;
}

if (hasTopDoor) {
    var topDummyDoor = instance_create(originX + (obj_trash_conductor.LAYOUT_TILE_SIZE * 5), originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 1), obj_door_h_1_open);
    topDummyDoor.depth = 9000;
}

if (hasBottomDoor) {
    var bottomDummyDoor = instance_create(originX + (obj_trash_conductor.LAYOUT_TILE_SIZE * 5), originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 9), obj_door_h_1_open);
    bottomDummyDoor.depth = 9000;
}

if (hasLeftDoor) {
    var leftDummyDoor = instance_create(originX, originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 5), obj_door_v_1_open);
    leftDummyDoor.depth = 9000;
}

if (hasRightDoor) {
    var rightDummyDoor = instance_create(originX + (obj_trash_conductor.LAYOUT_TILE_SIZE * 10), originY + (obj_trash_conductor.LAYOUT_TILE_SIZE * 5), obj_door_v_1_open);
    rightDummyDoor.depth = 9000;
}

// Sprite shileded animation
self.sprite_index = spr_trash_shield;

self.pt_fx = part_type_create();
part_type_sprite(self.pt_fx, spr_black_particle, true, true, false);
part_type_speed(self.pt_fx, 0.1, 0.4, -0.02, 0);
part_type_life(self.pt_fx, 10, 80);
part_type_gravity(self.pt_fx, -0.02, -90);
part_type_direction(self.pt_fx, 0, 180, 0, 1);
part_type_orientation(self.pt_fx, 0, 0, 0, 0, true);

self.em_fx = part_emitter_create(global.ps_ground);
part_emitter_stream(global.ps_ground, self.em_fx, self.pt_fx, 1);
