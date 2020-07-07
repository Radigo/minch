if (!scr_trash_instance_step()) {
    return false;
}

var hpRatio = self.hp / self.MAX_HP;

// Trash
if (self.sprite_index != spr_trash_sitting) {
    self.sprite_index = spr_trash_sitting;
}

// Patterns
if (self.patternTicker == self.patternTickerLimit) {
    var speedDirection = 1;
    if (self.targetRotationSpeed > 0) {
        speedDirection = -1;
    }
    self.targetRotationSpeed = (1 - hpRatio) * (360 / (self.numStreams * 6)) * speedDirection;
}

if ((self.targetRotationSpeed > 0) && (self.rotationSpeed < self.targetRotationSpeed)) {
    self.rotationSpeed += 0.01;
} else if ((self.targetRotationSpeed < 0) && (self.rotationSpeed > self.targetRotationSpeed)) {
    self.rotationSpeed -= 0.01;
}

self.rotationAngle += self.rotationSpeed;

var frequency = ceil(hpRatio * 30) + 12;

if ((self.patternTicker % frequency) == 0) {
    for (var i = 0; i < self.numStreams; i++) {
        var shotAngle = self.rotationAngle + ((360 / self.numStreams) * i);
        scr_bullet_shot(self.centerX, self.centerY, shotAngle, 1.2, 2);
    }
}

// Balls
if (hpRatio < 0.2) {
    self.numBalls = 8;
} else if (hpRatio < 0.4) {
    self.numBalls = 6;
} else if (hpRatio < 0.6) {
    self.numBalls = 4;
} else if (hpRatio < 0.8) {
    self.numBalls = 2;
} else if (hpRatio < 0.95) {
    self.numBalls = 1;
}

if (instance_number(obj_trash_bigball) < self.numBalls) {
    var isHorizontal = true;
    var ballX = self.centerX - (obj_minch_feets.x - self.centerX);
    if (ballX < (self.centerX - self.ballHRadius + 32)) {
        // On the left vertical row
        ballX = self.centerX - self.ballHRadius;
        isHorizontal = false;
    } else if (ballX > (self.centerX + self.ballHRadius - 32)) {
        // On the right vertical row
        ballX = self.centerX + self.ballHRadius;
        isHorizontal = false;
    }
    
    var ballY = self.centerY - (obj_minch_feets.y - self.centerY);
    if (ballY < (self.centerY - self.ballVRadius + 32)) {
        // On the top horizontal row
        ballY = self.centerY - self.ballVRadius;
    } else if (ballY > (self.centerY + self.ballVRadius - 32)) {
        // On the bottom horizontal row
        ballY = self.centerY + self.ballVRadius;
    }
    
    var bigBall = instance_create(ballX, ballY, obj_trash_bigball);
    ds_list_add(self.balls, bigBall);
    bigBall.travelSpeed = 0.3 + (hpRatio * 1);
    bigBall.targetScale = 1.5;
    
    if ((ds_list_size(self.balls) % 2) == 0) {
        if (isHorizontal) {
            bigBall.direction = 0;
        } else {
            bigBall.direction = 90;
        }
    } else {
        if (isHorizontal) {
            bigBall.direction = 180;
        } else {
            bigBall.direction = 270;
        }
    }
}

for (var i = 0; i < ds_list_size(self.balls); i++) {
    var bigBall = ds_list_find_value(self.balls, i);
    
    show_debug_message(string(bigBall.x) + ", " + string(bigBall.y) + ", " + string(bigBall.direction));
    
    if ((bigBall.direction == 0) && (bigBall.x > (self.centerX + self.ballHRadius))) {
        bigBall.x = self.centerX + self.ballHRadius;
        if (bigBall.y > self.centerY) {
            bigBall.direction = 90;
        } else {
            bigBall.direction = 270;
        }
    } else if ((bigBall.direction == 90) && (bigBall.y < (self.centerY - self.ballVRadius))) {
        bigBall.y = self.centerY - self.ballVRadius;
        if (bigBall.x > self.centerX) {
            bigBall.direction = 180;
        } else {
            bigBall.direction = 0;
        }
    } else if ((bigBall.direction == 180) && (bigBall.x < (self.centerX - self.ballHRadius))) {
        bigBall.x = self.centerX - self.ballHRadius;
        if (bigBall.y > self.centerY) {
            bigBall.direction = 90;
        } else {
            bigBall.direction = 270;
        }
    } else if ((bigBall.direction == 270) && (bigBall.y > (self.centerY + self.ballVRadius))) {
        bigBall.y = self.centerY + self.ballVRadius;
        if (bigBall.x > self.centerX) {
            bigBall.direction = 180;
        } else {
            bigBall.direction = 0;
        }
    }
}
