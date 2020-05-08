if (!self.switchTriggered) {
    return false;
}

self.shield = false;

// Settings
var numCannons = instance_number(obj_cannon_a) + instance_number(obj_cannon_b);

var rotationSpeed = 0.1;
var aimTime = 200 + (numCannons * 20);
var lockOnTime = aimTime + 6 + (numCannons * 6);
var coolDownTime = lockOnTime + 40;

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
} else if (self.ticker < (lockOnTime + 1)) {
    // Shoot
    var radAngle = -image_angle * (pi / 180);
        
    var cannonTipX = self.x + (cos(radAngle - 0.2) * 38);
    var cannonTipY = self.y + (sin(radAngle - 0.2) * 38);
    scr_bullet_shot(cannonTipX, cannonTipY, image_angle, 4, 5);
    var cannonTipX = self.x + (cos(radAngle + 0.2) * 38);
    var cannonTipY = self.y + (sin(radAngle + 0.2) * 38);
    scr_bullet_shot(cannonTipX, cannonTipY, image_angle, 4, 5);
} else if (self.ticker < coolDownTime) {
    // Wait
} else {
    // Repeat
    self.ticker = 0;
}
