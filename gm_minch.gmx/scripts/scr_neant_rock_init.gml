scr_ai_init();

// Settings
self.MAX_HP = 600;

self.hp = 500;
self.strColor = "bk";

// Params
self.BEHAVE_THRONE = "behaveThrone";
self.BEHAVE_STRAIGHT = "behaveStraight";
self.BEHAVE_CURVE = "behaveCurve";
self.BEHAVE_SUN = "behaveSun";

self.behavior = self.BEHAVE_STRAIGHT;
self.curveRatio = 0;// Influence direction whn moving

// Spawn
self.image_speed = 0.4;
// Core
self.core = instance_create(self.x, self.y, obj_rock_core_spawn);
self.core.image_speed = 0;
