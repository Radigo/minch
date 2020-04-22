if (!self.switchTriggered) {
    return false;
}

scr_ai_step();
self.shield = false;

// Settings
var numCannons = instance_number(obj_cannon_a);
var rotationSpeed = 0.6;

var aimTime = 300 + 240 - (numCannons * 16);
var lockOnTime = aimTime + 90 - (numCannons * 10);
var shootTime = lockOnTime + 180 - (numCannons * 20);
var coolDownTime = shootTime + 90 - (numCannons * 10);

if (self.ticker < aimTime) {
    // Aim
    var targetAngle = scr_aim_at_minch(self, 0, 0, 0);
    var angleDiff = targetAngle - image_angle;
    if (angleDiff > 180) {
        targetAngle = targetAngle - 360;
    }
    
    if (image_angle < (targetAngle - 2)) {
        image_angle += rotationSpeed;
    } else if (image_angle > (targetAngle + 2)) {
        image_angle -= rotationSpeed;
    }
} else if (self.ticker < lockOnTime) {
    // Wait
} else if (self.ticker < shootTime) {
    // Shoot
    if ((self.ticker % 3) == 0) {
        var radAngle = -image_angle * (pi / 180);
        
        var cannonTipX = self.x + (cos(radAngle - 0.3) * 12);
        var cannonTipY = self.y + (sin(radAngle - 0.3) * 12);
        scr_bullet_shot(cannonTipX, cannonTipY, image_angle, 2, 1);
        var cannonTipX = self.x + (cos(radAngle + 0.3) * 12);
        var cannonTipY = self.y + (sin(radAngle + 0.3) * 12);
        scr_bullet_shot(cannonTipX, cannonTipY, image_angle, 2, 1);
    }
} else if (self.ticker < coolDownTime) {
    // Wait
} else {
    // Repeat
    self.ticker = 0;
}
