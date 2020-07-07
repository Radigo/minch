if (!scr_trash_instance_step()) {
    return false;
}

var hpRatio = self.hp / self.MAX_HP;

// Moves
if (self.currentMove == self.MOVE_JUMP) {
    // Moves until reaching fly ellipse
    var ellipseTargetY = self.centerY - self.ellipseRadiusV;
    self.y -= abs(self.y - ellipseTargetY) * 0.06;
    
    if (self.y > (ellipseTargetY + 32)) {
        // Jump
        if (self.sprite_index != spr_trash_jump_down) {
            self.sprite_index = spr_trash_jump_down;
        }
    } else if (self.y > (ellipseTargetY + 1)) {
        // Arriving
        if (self.sprite_index != spr_trash_hover) {
            self.sprite_index = spr_trash_hover;
            self.image_speed = 0.25;
        }
    } else {
        // Reached destination
        self.y = ellipseTargetY;
        self.currentMove = self.MOVE_FLY;
    }
    
    return false;
}

// Rotation speed steps
if (hpRatio > 0.8) {
    self.rotationSpeedTarget = 0.005;
    self.tickerLimit = 500;
} else if (hpRatio > 0.6) {
    self.rotationSpeedTarget = 0.01;
    self.tickerLimit = 350;
} else if (hpRatio > 0.3) {
    self.rotationSpeedTarget = 0.015;
    self.tickerLimit = 150;
} else if (hpRatio > 0.15) {
    self.rotationSpeedTarget = 0.03;
    self.tickerLimit = 120;
} else {
    self.rotationSpeedTarget = 0.05;
    self.tickerLimit = 100;
}

if (self.rotationSpeed < self.rotationSpeedTarget) {
    self.rotationSpeed += abs(self.rotationSpeedTarget - self.rotationSpeed) * 0.003;
}

self.angle += self.rotationSpeed;

self.x = self.centerX + cos(self.angle) * self.ellipseRadiusH;
self.y = self.centerY + sin(self.angle) * self.ellipseRadiusV;

// Shots
self.patternTickerLimit = 12 + ceil(hpRatio * 60);
if (self.patternTicker >= self.patternTickerLimit) {
    self.patternTicker = 0;
    scr_bullet_shot(self.x, self.y, scr_aim_at_minch(self, 30 + (hpRatio * 60), 0, 0), random(1) + 0.2, 2);
    //scr_pattern_spread(self.x, self.y, scr_aim_at_minch(self, 10, 0, 0), 0.4, 2, 3, 90);
}

if (self.ticker >= self.tickerLimit) {
    self.ticker = 0;
    var ballDirections = ds_list_create();
    
    var isVertical = random(1) > 0.5;
    var isReverse = random(1) > 0.5;
    var isDouble = random(1.6) > hpRatio;
    
    if (isVertical) {
        if (isReverse) {
            ballDirection = 90;
        } else {
            ballDirection = 270;
        }
    } else {
        if (isReverse) {
            ballDirection = 180;
        } else {
            ballDirection = 0;
        }
    }
    
    ds_list_add(ballDirections, ballDirection);
    
    if (isDouble) {
        ds_list_add(ballDirections, ballDirection + 180);
    }
    
    for (var i = 0; i < ds_list_size(ballDirections); i++) {
        var bigBall = instance_create(self.centerX, self.centerY, obj_trash_bigball);
        bigBall.targetScale = 2;
        bigBall.direction = ds_list_find_value(ballDirections, i);
        bigBall.travelSpeed = 0.5 + ((1 - hpRatio) * 1.2);
        switch (bigBall.direction % 360) {
            case 0:
                bigBall.x -= (obj_trash_conductor.LAYOUT_TILE_SIZE * 5);
                break;
            case 90:
                bigBall.y += (obj_trash_conductor.LAYOUT_TILE_SIZE * 4);
                break;
            case 180:
                bigBall.x += (obj_trash_conductor.LAYOUT_TILE_SIZE * 5);
                break;
            case 270:
                bigBall.y -= (obj_trash_conductor.LAYOUT_TILE_SIZE * 4);
                break;
        }
    }
}
