if (!self.switchTriggered) {
    return false;
}

scr_ai_step();
self.shield = false;

// Settings
// No overlay at all
var rotationSpeed = 2;
var aimTime = 30;
var lockOnTime = aimTime + 20;
var shootTime = lockOnTime + 2;
var shootFrequency = 1;
var coolDownTime = shootTime + 20;
var targetAngle = 0;
var rotationArcDuration = 400;

if (self.overlay != noone) {
    // Overlay only on us
    self.overlay.image_angle = self.image_angle;
    
    rotationSpeed = 1;    
    aimTime = 240;
    lockOnTime = aimTime + 120;
    shootTime = lockOnTime + 60;
    shootFrequency = 20;
    coolDownTime = shootTime + 90;
    
    if (self.hp < 400) {
        instance_destroy(self.overlay);
        self.overlay = noone;
        scr_boom(self.x, self.y, 3, 32);
    }
} else if (instance_number(obj_cannon_b_overlay) > 0) {
    // Overlay on other
    aimTime = 300;
    lockOnTime = aimTime + 60;
    shootTime = lockOnTime + 400;
    shootFrequency = 48;
    coolDownTime = shootTime + 10;
}

if (self.ticker < aimTime) {
    // Aim if one overlay exists
    if (instance_number(obj_cannon_b_overlay) > 0) {
        targetAngle = scr_aim_at_minch(self, 0, 0, 0);
        var angleDiff = targetAngle - image_angle;
        if (angleDiff > 180) {
            targetAngle = targetAngle - 360;
        }
    } else {
        // Rotate automaticaly
        if (self.patternTicker < rotationArcDuration) {
            if (self.x > 1056) {
                targetAngle = -30;// Right cannon
            } else {
                targetAngle = -150;// Left cannon
            }
        } else if (self.patternTicker < (rotationArcDuration * 2)) {
            if (self.x > 1056) {
                targetAngle = -150;// Right cannon
            } else {
                targetAngle = -30;// Left cannon
            }
        } else {
            self.patternTicker = 0;
        }
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
    if (self.overlay != noone) {
        if ((self.ticker % shootFrequency) == 0) {
            var radAngle = -image_angle * (pi / 180);
            
            var cannonTipX = self.x + (cos(radAngle - 0.5) * 28);
            var cannonTipY = self.y + (sin(radAngle - 0.5) * 28);
            scr_pattern_spread(cannonTipX, cannonTipY, image_angle, 1, 3, 7, 140);
            cannonTipX = self.x + (cos(radAngle + 0.5) * 28);
            cannonTipY = self.y + (sin(radAngle + 0.5) * 28);
            scr_pattern_spread(cannonTipX, cannonTipY, image_angle, 1, 3, 7, 140);
        }
    } else {
        if ((self.ticker % shootFrequency) == 0) {
            var radAngle = -image_angle * (pi / 180);
            
            var cannonTipX = self.x + (cos(radAngle - 0.8) * 22);
            var cannonTipY = self.y + (sin(radAngle - 0.8) * 22);
            scr_pattern_spread(cannonTipX, cannonTipY, image_angle, 1.6, 3, 6, 150);
            var cannonTipX = self.x + (cos(radAngle) * 18);
            var cannonTipY = self.y + (sin(radAngle) * 18);
            scr_pattern_spread(cannonTipX, cannonTipY, image_angle, 1.6, 3, 5, 150);
            cannonTipX = self.x + (cos(radAngle + 0.8) * 22);
            cannonTipY = self.y + (sin(radAngle + 0.8) * 22);
            scr_pattern_spread(cannonTipX, cannonTipY, image_angle, 1.6, 3, 6, 150);
        }
    }
} else if (self.ticker < coolDownTime) {
    // Wait
} else {
    // Repeat
    self.ticker = 0;
}
