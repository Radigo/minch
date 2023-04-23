if (!self.switchTriggered) {
    return false;
}

self.shield = false;

// Settings
// No overlay at all
var rotationSpeed = 2;
var aimTime = 16;
var lockOnTime = aimTime + 10;
var shootTime = lockOnTime + 1;
var shootFrequency = 1;
var coolDownTime = shootTime + 10;
var targetAngle = 0;
var rotationArcDuration = 200;

if (self.overlay != noone) {
    // Overlay only on us
    self.overlay.image_angle = self.image_angle;
    
    rotationSpeed = 1;    
    aimTime = 120;
    lockOnTime = aimTime + 60;
    shootTime = lockOnTime + 30;
    shootFrequency = 10;
    coolDownTime = shootTime + 40;
    
    if (self.hp < 400) {
        instance_destroy(self.overlay);
        self.overlay = noone;
        scr_boom(self.x, self.y, 3, 32);
    }
} else if (instance_number(obj_cannon_b_overlay_bk) > 0) {
    // Overlay on other
    aimTime = 160;
    lockOnTime = aimTime + 30;
    shootTime = lockOnTime + 200;
    shootFrequency = 24;
    coolDownTime = shootTime + 6;
}

if (self.ticker < aimTime) {
    // Aim if one overlay exists
    if (instance_number(obj_cannon_b_overlay_bk) > 0) {
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
