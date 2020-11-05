scr_ai_init();

// Moves
self.MOVE_RAGING = "moveRaging";// Init pose of screaming CH1 when we fall down
self.MOVE_STATIC = "moveStatic";// Legs are still, body can fire
self.MOVE_JUMPING = "moveJumping";// Legs are jumping, body can fire too
self.jumpSourceX = self.x;
self.jumpSourceY = self.y;
self.jumpTargetX = self.x;
self.jumpTargetY = self.y;

self.jumpTargetYMin = 736;
self.jumpTargetYMax = 832;
self.jumpTargetYMiddle = (self.jumpTargetYMax + self.jumpTargetYMin) * 0.5;

// Patterns
self.PATTERN_RAGING = "patternRaging";// Spread arms, shaking, sound...
self.PATTERN_IDLE = "patternIdle";// Idle pose, does nothing
self.PATTERN_LASERUP = "patternLaserUp";// Fire beam with upper (left) arm
self.PATTERN_LASERDOWN = "patternLaserDown";// Fire beam with lower (right) arm
self.PATTERN_LASERTWIN = "patternLaserTwin";// Fire beams with both arms
self.PATTERN_SPREADUP = "patternSpreadUp";// Fire pattern with upper (left) claws
self.PATTERN_SPREADDOWN = "patternSpreadDown";// Fire pattern with lower (right) claws
self.PATTERN_SPREADTWIN = "patternSpreadTwin";// Fire pattern with both claws
self.PATTERN_SPREADSHOULDER = "patternSpreadShoulders";// Spread arms, fire pattern with shoulders
self.NUM_PODS = 20;
self.PODS_SPAWN_DELAY = 16;

self.staticPatternsList = ds_list_create();
ds_list_add(self.staticPatternsList, self.PATTERN_LASERUP, self.PATTERN_LASERDOWN, self.PATTERN_LASERTWIN, self.PATTERN_SPREADUP, self.PATTERN_SPREADDOWN, self.PATTERN_SPREADTWIN, self.PATTERN_SPREADSHOULDER);

self.staticPatternIndex = 0;// Pattern thrown when staying static
self.staticPatternCount = 3;// Number of patterns thrown while static
self.cycleIndex = 0;// Index of static patterns cycle
self.cycleCount = 5;// Num of cycles before going to next phase
self.SPREAD_SHOULDER_COUNT = 6;// Max num of spread shoulder patttern (because of leeching)
self.spreadSoulderIndex = 0;

self.podsLeft = self.NUM_PODS;

// Patterns config
self.ARM_X = 43
self.LEFT_ARM_Y = -22;
self.RIGHT_ARM_Y = 18;

self.LASER_HALF_WIDTH = 10;
self.LASER_LENGTH = 300;

self.SINGLE_LASER_WARMUP_TIME = 48;
self.TWIN_LASER_WARMUP_TIME = 32;
self.SINGLE_SPREAD_WARMUP_TIME = 16;
self.TWIN_SPREAD_WARMUP_TIME = 32;
self.PODS_SPAWN_WARMUP_TIME = 16;

// Create
self.legsRelativePositionX = 6;
self.legsRelativePositionY = 14;

self.legs = instance_create(self.x + self.legsRelativePositionX, self.y + self.legsRelativePositionY, obj_ch1_legs);
self.legs.depth = self.depth + 1;
self.hp = 6000;
self.killSequenceHp = 1000;

// OK let's go
self.isIntro = true;
self.isKillSequence = false;
self.tickerLimit = 60;
self.move = self.MOVE_STATIC;
self.pattern = self.PATTERN_IDLE;

// FX
self.ps_smoke = part_system_create();
part_system_depth(self.depth + 2, self.ps_smoke);
self.em_smoke = part_emitter_create(self.ps_smoke);

// Big bullets particles
self.pt_greenlaser = part_type_create();
part_type_sprite(self.pt_greenlaser, spr_greenlaser_dots, true, true, false);
part_type_speed(self.pt_greenlaser, 0.8, 2.5, -0.15, 0);
part_type_direction(self.pt_greenlaser, 0, 360, 0, 2);
part_type_life(self.pt_greenlaser, 16, 40);

self.em_greenlaser_dots = part_emitter_create(global.ps_light);
