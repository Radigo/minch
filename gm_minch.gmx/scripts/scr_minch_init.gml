// Executed on minch_obj create
show_debug_message("Init MinCH");

// DEBUG VARS
global.invincible = false;
global.clip = false;

// DECLARING VARS
global.minchControlIsActive = true;

// Status vars
global.SPAWN = "spawn";// Sprite fades in
global.ALIVE = "alive";// Full control and death opportunities
global.DEATH = "death";// Sprite fades out (TODO: better death anim)
global.TELEPORT = "teleport";

global.LEGS_IDLE = "idle";
global.LEGS_WALK = "walk";
global.LEGS_JUMP = "jump";

global.BODY_IDLE = "idle";// Do nothing
global.BODY_SHOT = "shot";// Free shot
global.BODY_FIXED = "fixed";// Fixed shot
global.BODY_AIM = "aim";// Aimed shot towards the fixed target
global.BODY_AIMEDSHOT = "aimedshot";// Aimed shot towards the fixed target
global.BODY_CLAW = "claw";// Claw attack
global.BODY_HOLD = "hold";// Holding objects

self.mainAngle = pi * 0.5;// Direction of player (in Radians)
self.legsAngle = pi * 0.5;// Direction of legs (in Radians)
self.bodyAngle = pi * 0.5;// Direction of shot (in Radians)

// Move vars
self.initX = x;
self.initY = y;

self.warmupDuration = 60;// Invincibility time after spawn
self.spawnDuration = 40;// Duration of the spawn process
self.deathDuration = 120;// Duration of the death sequence
global.teleportDuration = 30;// Duration of the teleport process (20)

self.controlTime = warmupDuration;// Init as spawning
self.invincibilityTicker = 0;

self.jumpDuration = 20;// Duration of jump in frames
self.jumpTicker = 0;// Jump duration counter

self.conveyorMoveX = 0;
self.conveyorMoveY = 0;

// Jump vars
self.canJump = true;
self.isJumpTargetValid = false;
self.abReleased = true;
self.markerDistance = 56;//48: Distance of target marker (ie: jump distance)
self.jumpStartingPosX = -1;
self.jumpStartingPosY = -1;
self.jumpTargetPosX = -1;
self.jumpTargetPosY = -1;
//TODO: implement tolerance timer to make jump timing easyier
self.jumpToleranceTimerDuration = 4;
self.jumpToleranceTimer = 0;

// Shooting vars
self.numShots = 0;
self.aFirstReleaseDelay = 5;// Delay after the first shot fired
self.aReleaseDelay = 16;// Delay between 2 A button press to keep shot status
self.aPressDelay = 10;// Delay before A button release to enter hold status
self.aPressTime = 0;// A button press counter
self.aReleaseTime = 0;// A button release counter

self.firstShotDelay = 12;// Delay after the first shot fired
self.shotDelay = 2;// Delay between 2 shots fired
self.fixedDelay = 4;// Delay between 2 aimed shots fired
self.shotTime = 0;// Shot delay counter

// Claw vars
self.clawDuration = 8;// The duration of the claw attack
self.clawDelay = 12;// The delay between 2 claw attacks
self.clawTime = 0;// The current timing of the claw attack
self.clawDelayTime = 0;// The current delay

// Teleport vars
self.teleportTargetX = 0;
self.teleportTargetY = 0;

// FX vars
self.shotFX = instance_create(0, 0, obj_shot_fx);

// ASSIGNING INIT VARS
global.controlStatus = global.SPAWN;
global.legsStatus = global.LEGS_IDLE;
global.bodyStatus = global.BODY_IDLE;

global.controlTime = self.spawnDuration;

// Create target with minch
object_set_depth(obj_marker, -12000);
instance_create(x ,y, obj_marker);
// Create feets
instance_create(x, y, obj_minch_feets);
// Create camera pointer
instance_create(x, y, obj_minch_camera);

// Create particles systems
self.em_smoke = part_emitter_create(global.ps_ground);
global.em_shots_sparkles = part_emitter_create(global.ps_light);

obj_minch_feets.depth = -1; 
depth = -2;
