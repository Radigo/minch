scr_ai_init();

// Moves
self.MOVE_RAGING = "moveRaging";// Init pose of screaming CH1 when we fall down
self.MOVE_STATIC = "moveStatic";// Legs are still, body can fire
self.MOVE_JUMPING = "moveJumping";// Legs are jumping, body can fire too
self.jumpSourceX = self.x;
self.jumpSourceY = self.y;
self.jumpTargetX = self.x;
self.jumpTargetY = self.y;

self.jumpTargetYMin = 704;
self.jumpTargetYMax = 864;

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

self.staticPatternsList = ds_list_create();
ds_list_add(self.staticPatternsList, self.PATTERN_LASERUP, self.PATTERN_LASERDOWN, self.PATTERN_LASERTWIN, self.PATTERN_SPREADUP, self.PATTERN_SPREADDOWN, self.PATTERN_SPREADTWIN, self.PATTERN_SPREADSHOULDER);

self.staticPatternIndex = 0;// Pattern thrown when staying static
self.staticPatternCount = 3;// Number of patterns thrown while static
self.cycleIndex = 0;// Index of static patterns cycle
self.cycleCount = 5;// Num of cycles before going to next phase

// Create
self.shield = true;

self.bodyRelativePositionX = -6;
self.bodyRelativePositionY = -14;

self.body = instance_create(self.x + self.bodyRelativePositionX, self.y + self.bodyRelativePositionY, obj_ch1_body);
self.depth = self.body.depth + 1;
self.body.hp = 500;

// OK let's go
self.isIntro = true;
self.tickerLimit = 60;
self.move = self.MOVE_STATIC;
self.pattern = self.PATTERN_IDLE;
