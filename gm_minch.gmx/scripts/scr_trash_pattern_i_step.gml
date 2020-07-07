if (!scr_trash_instance_step()) {
    return false;
}

var hpRatio = self.hp / self.MAX_HP;

// Moves
if (self.currentMove == self.MOVE_IDLE) {
    self.currentMove = self.MOVE_SPAWN;
    self.tickerLimit = self.spawnDuration;
    self.ticker = 0;
    
    self.sprite_index = spr_trash_jump_down;
} else if (self.currentMove == self.MOVE_SPAWN) {
    // Trash
    self.y += (self.centerY - self.y) * 0.05;
    
    // Spawners
    for (var i = 0; i < self.numSpawnersBySide; i++) {
        var travelRatio = self.ticker / self.tickerLimit;
        var spawnerTargetY = self.spawnerTargetYTop + ((self.spawnerTargetYBottom - self.spawnerTargetYTop) * (i / self.numSpawnersBySide));
        
        var spawnerLeft = ds_list_find_value(self.spawnerLeft, i);
        spawnerLeft.x = self.centerX - (travelRatio * self.spawnerTargetXMax);
        spawnerLeft.y = self.y + (travelRatio * (spawnerTargetY - self.y));
        var spawnerRight = ds_list_find_value(self.spawnerRight, i);
        spawnerRight.x = self.centerX + (travelRatio * self.spawnerTargetXMax);
        spawnerRight.y = self.y + (travelRatio * (spawnerTargetY - self.y));
    }
    
    if (self.ticker == self.tickerLimit) {
        self.currentMove = self.MOVE_FLY;
        
        self.sprite_index = spr_trash_hover;
        self.image_speed = 0.25;
        self.x = self.centerX;
        self.y = self.centerY;
    }
} else if (self.currentMove == self.MOVE_FLY) {
    // Hover in circles
    self.rotationHSpeedTarget = 0.012 + ((1 - hpRatio) * 0.04);
    if (self.rotationHSpeed < self.rotationHSpeedTarget) {
        self.rotationHSpeed += 0.0002;
    }
    
    self.angleH += self.rotationHSpeed;
    self.x = self.centerX + cos(self.angleH) * self.ellipseRadiusH;
    
    if (self.rotationVSpeed < self.rotationVSpeedTarget) {
        self.rotationVSpeed += 0.001;
    }
    
    self.angleV += self.rotationVSpeed;
    self.y = self.centerY + cos(self.angleV) * self.ellipseRadiusV;
    
    // Patterns
    var trashShotFreqency =  2 + floor(hpRatio * 60);
    if ((self.patternTicker % trashShotFreqency) == 0) {
        scr_bullet_shot(self.x, self.y, 270, 1, 2);
    }
    
    // Spawners
    var xTarget = self.spawnerTargetXMin + (hpRatio * (self.spawnerTargetXMax - self.spawnerTargetXMin));
    for (var i = 0; i < self.numSpawnersBySide; i++) {
        var spawnerLeft = ds_list_find_value(self.spawnerLeft, i);
        spawnerLeft.x = self.centerX - xTarget;
        var spawnerRight = ds_list_find_value(self.spawnerRight, i);
        spawnerRight.x = self.centerX + xTarget;
    }
    
    if (self.patternTicker >= self.patternTickerLimit) {
        var spawnerList = self.spawnerLeft;
        // Rotate shots
        self.angleSwayMax = 4 + (1 - hpRatio) * 16;
        self.angleSwaySpeed = 1.5;
        self.patternAngle += self.angleSwaySpeed * self.angleSwayDirection;
        
        if (self.patternAngle > self.angleSwayMax) {
            self.angleSwayDirection = -1;
        } else if (self.patternAngle < -self.angleSwayMax) {
            self.angleSwayDirection = 1;
        }
        
        var shotAngle = self.patternAngle;
        
        if (self.spawnerSide == "right") {
            spawnerList = self.spawnerRight;
            shotAngle = self.patternAngle + 180;
        }
        for (var i = 0; i < self.numSpawnersBySide; i++) {
            var spawner = ds_list_find_value(spawnerList, i);
            scr_bullet_shot(spawner.x, spawner.y, shotAngle, 0.6, 3);
        }
        
        self.streamNumBullets--;
        
        if (self.streamNumBullets <= 0) {
            if (self.spawnerSide == "right") {
                self.spawnerSide = "left";
            } else {
                self.spawnerSide = "right";
            }
            
            self.streamNumBullets = ceil(((hpRatio * 1.4) - 0.4) * 8);
            self.patternTickerLimit = ceil(hpRatio * 8) + 24;
        }
        
        self.patternTicker = 0;
    }
}
