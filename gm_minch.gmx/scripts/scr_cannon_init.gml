scr_register_dynamic_object(3, global.ENEMY_TRIGGER_ON);
scr_ai_init();

// Inits
self.overlay = noone;
self.roof = noone;
self.hp = 200;
self.shield = true;

// Instance arguments
var roofObj = argument0;
var overlayObj = argument1;

// Rule for HP
/*
C - 800 (roof only)
B - 400 + 400 (roof + overlay)
A - 200 (nothing)
*/
if (overlayObj != noone) {
    self.overlay = instance_create(self.x, self.y, overlayObj);
    self.overlay.image_angle = self.image_angle;
    self.overlay.depth = self.depth - 1;
    self.hp = 800;
}

if (roofObj != noone) {
    self.roof = instance_create(self.x, self.y, roofObj);
    self.roof.depth = self.depth - 2;
    self.roof.shield = true;
    self.safeZone = 16;
    if (overlayObj == noone) {
        // We are cannon C
        self.hp = 600;
    }
}

