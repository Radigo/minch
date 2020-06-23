if (!scr_trash_instance_step()) {
    return false;
}

var hpRatio = self.hp / self.MAX_HP;

// Moves
if (self.currentMove == self.MOVE_JUMP) {
    self.shield = true;
    var moveRatio = self.ticker / self.tickerLimit;
    var jumpHeight = sin(pi * moveRatio) * 12 - (4 * hpRatio);
    self.x = self.sourceX + ((self.targetX - self.sourceX) * moveRatio);
    self.y = self.sourceY + ((self.targetY - self.sourceY) * moveRatio) - jumpHeight;
    
    if (self.ticker >= self.tickerLimit) {
        self.ticker = 0;
        self.tickerLimit = self.landDuration;
        self.currentMove = self.MOVE_LAND;
        
        self.sprite_index = spr_trash_punch_stance_land;
    }
} else if (self.currentMove == self.MOVE_LAND) {
    self.shield = true;
    if (self.ticker == self.tickerLimit) {
        self.ticker = 0;
        
        self.numJumpsBeforePunch--;
        
        if (self.numJumpsBeforePunch <= 0) {
            self.numJumpsBeforePunch = 5;
            
            self.tickerLimit = self.punchDuration + floor(self.punchDurationVar * hpRatio);
            self.currentMove = self.MOVE_PUNCH;
            
            self.sprite_index = spr_trash_punch;
            self.image_speed = 0.2;
        } else {
            self.tickerLimit = self.jumpDuration + floor(self.jumpDurationVar * hpRatio);
            self.currentMove = self.MOVE_JUMP;
            
            self.sprite_index = spr_trash_punch_stance;
            
            self.sourceX = self.x;
            self.sourceY = self.y;
            
            var maxHorizontalLeap = 48;
            var maxVerticalLeap = 32;
            
            var hLeap = (random(2) - 1) * maxHorizontalLeap;
            var aimRange = self.numJumpsBeforePunch * 24;
            
            if (abs(sourceX - obj_minch_feets.x) > aimRange) {
                hLeap = abs(hLeap);
                if (self.sourceX > obj_minch_feets.x) {
                    hLeap = -hLeap;
                }
            }
            // Jump within ranges
            self.targetX = max(self.moveRangeLeft, min(self.moveRangeRight, (self.sourceX + hLeap)));
            
            var vLeap = random(maxVerticalLeap);
            if (self.sourceY > obj_minch_feets.y) {
                // Going up is always at max speed
                vLeap = -maxVerticalLeap;
            }
            // Jump within ranges
            self.targetY = max(self.moveRangeTop, min(self.moveRangeBottom, (self.sourceY + vLeap)));
        }
    }
} else if (self.currentMove == self.MOVE_PUNCH) {
    self.shield = false;
    // Freeze last frame
    if (self.image_index >= self.image_number - 1) {
        self.image_speed = 0;
    }
    
    // Spawn pusher after a delay
    if (self.ticker == 8) {
        instance_create(self.x, self.y, obj_trash_pusher);
    } else if (self.ticker == self.tickerLimit) {
        self.ticker = 0;
        self.tickerLimit = self.landDuration;
        self.currentMove = self.MOVE_LAND;
    }
}

// Spawners
for (var i = 0; i < ds_list_size(self.spawnerList); i++) {
    var spawner = ds_list_find_value(self.spawnerList, i);
    
    // Horizontal move
    var isLeftSpawner = (i < self.numSpawnerPerSide);
    var canShoot = true;
    
    if (isLeftSpawner && (spawner.x > self.spawnerLeft)) {
        spawner.x -= max(abs(self.spawnerLeft - spawner.x) * 0.05, 0.5);
        canShoot = false;
    } else if (!isLeftSpawner && (spawner.x < self.spawnerRight)) {
        spawner.x += max(abs(self.spawnerRight - spawner.x) * 0.05, 0.5);
        canShoot = false;
    }
    
    // Vertical move
    var topBounds = self.spawnerTop;
    var bottomBounds = self.spawnerBottom;
    var isFollowingTrashSpawner = ((i % self.numSpawnerPerSide) == 1);
    
    if (isFollowingTrashSpawner) {
        topBounds = self.y;
        bottomBounds = self.y + 64;
    }
    
    if (spawner.y < topBounds) {
        spawner.direction = -90;
    } else if (spawner.y > bottomBounds) {
        spawner.direction = 90;
    }
    
    // Shots
    var isAimingSpawner = ((i % self.numSpawnerPerSide) == 0);
    var spawnerTicker = ds_list_find_value(self.spawnerTickers, i);
    var spawnerShotStreamDuration = ds_list_find_value(self.spawnerShotStreamDuration, i);
    
    spawnerTicker--;
    
    if (spawnerTicker <= 0) {
        spawner.speed = 4 - (3.5 * hpRatio) + random(0.2);
        spawnerTicker = spawnerShotStreamDuration + floor(random(100) + (80 * hpRatio));
        if (isFollowingTrashSpawner) {
            spawner.speed = 0.4;
        }
        if (isAimingSpawner) {
            spawnerTicker = spawnerShotStreamDuration + 200 - (80 * hpRatio);
        }
        
        spawnerShotStreamDuration = 200 - floor(160 * hpRatio);
        if (isAimingSpawner) {
            spawnerShotStreamDuration = 2;
        }
        ds_list_replace(self.spawnerShotStreamDuration, i, spawnerShotStreamDuration);
    } else if (spawnerTicker == spawnerShotStreamDuration) {
        spawner.speed = 0;
        if (isAimingSpawner) {
            ds_list_replace(self.spawnerShotAngle, i, scr_aim_at_minch(spawner, 0, 0, 0));
        }
    } else if (spawnerTicker < spawnerShotStreamDuration) {
        if (canShoot && (isAimingSpawner || ((spawnerTicker % 4) == 0))) {
            scr_bullet_shot(spawner.x, spawner.y, ds_list_find_value(self.spawnerShotAngle, i), 1, 3);
        }
    }
    
    ds_list_replace(self.spawnerTickers, i, spawnerTicker);
}
