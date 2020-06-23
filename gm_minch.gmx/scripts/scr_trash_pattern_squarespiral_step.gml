if (!scr_trash_instance_step()) {
    return false;
}

if (self.sprite_index != spr_trash_hover) {
    self.sprite_index = spr_trash_hover;
    self.image_speed = 0.4;
    
    var numDeflectors = 3;
    for (var i = 0; i < numDeflectors; i++) {
        var deflector = instance_create(self.x, self.y, obj_spiral_deflector_canon);
        deflector.centerX = self.x;
        deflector.centerY = self.y;
        deflector.radius = 1;
        deflector.maxRadius = 32;
        deflector.angle = (i / numDeflectors) * (pi * 2);
        deflector.rotationSpeed = 0.1;
        deflector.radiusSpeed = 0.2;
        deflector.isShooting = false;
        deflector.streamGap = 10;
        deflector.patternTickerLimit = 30;
        ds_list_add(self.deflectors, deflector);
    }
}

var hpRatio = self.hp / self.MAX_HP;

// Move to center
if (self.isMoving) {
    if (abs(self.centerX - self.x) > 1) {
        self.x += max(abs(self.centerX - self.x) * 0.05, 0.5);
    }
    
    if (abs(self.centerY - self.y) > 1) {
        self.y += max(abs(self.centerY - self.y) * 0.03, 0.5);
    } else {
        self.y = self.centerY;
        self.isMoving = false;
        
        self.patternTicker = self.patternTickerLimit - 1;
    }
    
    for (var i = 0; i < ds_list_size(self.deflectors); i ++) {
        var deflector = ds_list_find_value(self.deflectors, i);
        deflector.centerX = self.x;
        deflector.centerY = self.y;
        deflector.isShooting = !self.isMoving;
    }
    
    return false;
}

for (var i = 0; i < ds_list_size(self.deflectors); i ++) {
    var deflector = ds_list_find_value(self.deflectors, i);
    deflector.rotationSpeed = 0.004 + (hpRatio * 0.066);
    deflector.streamGap = 10 + floor(hpRatio * 50);
    deflector.patternTickerLimit = 30 + floor(hpRatio * 40);
}

if (self.patternTicker == self.patternTickerLimit) {
    // Build a ring
    var nextRingRotationSpeed = 0.003 + random(0.006 * (1 - hpRatio));
    
    if (self.lastRingRotationSpeed > 0) {
        self.lastRingRotationSpeed = -nextRingRotationSpeed;
    } else {
        self.lastRingRotationSpeed = nextRingRotationSpeed;
    }
    
    self.numRingElements = ceil((1 - hpRatio) * 4) + 3;
    var numBoxes = ceil(numRingElements * 0.25);
    var initAngle = random(pi * 2);
    
    for (var i = 0; i < self.numRingElements; i++) {
        var elementId = obj_spiral_deflector_canon;
        var isShooting = true;
        if (i <= numBoxes) {
            elementId = obj_spiral_box_cy;
            isShooting = false;
        }
        var element = instance_create(self.x, self.y, elementId);
        element.centerX = self.centerX;
        element.centerY = self.centerY;
        element.radius = 200;
        element.minRadius = 24;
        element.angle = initAngle + (i / self.numRingElements) * (pi * 2);
        element.rotationSpeed = self.lastRingRotationSpeed;
        element.radiusSpeed = -0.5;
        element.isShooting = isShooting;
        element.streamGap = 30;
        element.patternTickerLimit = 60;
    }
}
