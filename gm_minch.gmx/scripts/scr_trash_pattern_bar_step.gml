if (!scr_trash_instance_step()) {
    return false;
}

// Moves
if (self.currentMoveState == self.MOVE_STAY) {
    // Stands still
    if (self.hp < self.nextMoveHp) {
        // Jumps when hp step has been reached
        self.lastMoveHp = self.nextMoveHp;
        self.nextMoveHp = self.lastMoveHp - ceil(self.lastMoveHp * 0.1);
        
        var jumpDistance = (obj_trash_conductor.LAYOUT_TILE_SIZE * 2) + random(obj_trash_conductor.LAYOUT_TILE_SIZE * 3);
        // We change direction, jump target location is based on previous move direction
        var targetDirection = 1;
        
        if (self.direction == 0) {
            targetDirection = -1;
        }
        
        self.moveTargetX = (self.x + (jumpDistance * targetDirection));
        
        if (self.moveTargetX > self.moveRangeRight) {
            self.moveTargetX = self.moveRangeRight;
        } else if (self.moveTargetX < self.moveRangeLeft) {
            self.moveTargetX = self.moveRangeLeft;
        }
        
        self.speed = 3;
        self.sprite_index = spr_trash_jump_right;
        
        if (self.moveTargetX > self.x) {
            self.direction = 0;
        } else {
            self.direction = 180;
            self.image_xscale = -1;
        }
        self.currentMoveState = self.MOVE_JUMP;
    }
} else if (self.currentMoveState == self.MOVE_JUMP) {
    // Jumps
    var hasLanded = false;
    if ((self.direction == 0) && (self.x > self.moveTargetX)) {
        hasLanded = true;
    } else if ((self.direction == 180) && (self.x < self.moveTargetX)) {
        hasLanded = true;
    }
    
    if  (hasLanded) {
        self.sprite_index = spr_trash_land_right;
        self.speed = 0;
        self.ticker = 0;
        self.tickerLimit = 30;
        self.currentMoveState = self.MOVE_LAND;
    }
} else if (self.currentMoveState == self.MOVE_LAND) {
    // Just wait a while
    if (self.ticker == self.tickerLimit) {
        self.sprite_index = spr_trash_idle;
        self.image_xscale = 1;
        self.currentMoveState = self.MOVE_STAY;
    }
}

if (self.currentPhase == self.PHASE_ACTIVE) {
    if (self.spawnerCurrentState == self.SPAWNER_STATE_INIT) {
        // Spawners moves (based on self.topLeftSpawner)
        var deltaX = abs(self.leftSpawnerX - self.leftSpawner.x) * 0.05;
        
        if (self.leftSpawner.x > (self.leftSpawnerX + 1)) {
            self.leftSpawner.x -= deltaX;
            self.rightSpawner.x += deltaX;
            
            self.leftSpawner.direction = -90;
            self.rightSpawner.direction = 270;
            self.leftSpawner.speed = 0.6;
            self.rightSpawner.speed = 0.6;
        } else {
            self.leftSpawner.x = self.leftSpawnerX;
            self.rightSpawner.x = self.rightSpawnerX;
            
            self.spawnerCurrentState = self.SPAWNER_STATE_ACTIVE;
        }
    } else if (self.spawnerCurrentState == self.SPAWNER_STATE_ACTIVE) {
    
        if (self.hp > (self.MAX_HP * 0.8)) {
            self.patternTickerLimit = 60;
        } else if (self.hp > (self.MAX_HP * 0.5)) {
            self.patternTickerLimit = 40;
        } else if (self.hp > (self.MAX_HP * 0.3)) {
            self.patternTickerLimit = 24;
            self.leftSpawner.speed = 2;
            self.rightSpawner.speed = 2;
        } else {
            self.patternTickerLimit = 16;//8 = hard, 16 = easy
            self.leftSpawner.speed = 3;
            self.rightSpawner.speed = 3;
        }
        
        // Spawners moves        
        if ((self.leftSpawner.direction == 90) && (self.leftSpawner.y < self.spawnerTop)) {
            self.leftSpawner.direction = 270;
            //self.leftSpawner.speed = 1; speed based on hp ?
        } else if ((self.leftSpawner.direction == 270) && (self.leftSpawner.y > self.spawnerBottom)) {
            self.leftSpawner.direction = 90;
        }
        
        if ((self.rightSpawner.direction == 90) && (self.rightSpawner.y < self.spawnerTop)) {
            self.rightSpawner.direction = 270;
        } else if ((self.rightSpawner.direction == 270) && (self.rightSpawner.y > self.spawnerBottom)) {
            self.rightSpawner.direction = 90;
        }
        
        // Spawner bullets
        if (self.patternTicker == self.patternTickerLimit) {
            if (self.activeSpawner > 0) {
                var spawnerAngle = 315;// top left to bottom right
                
                if (self.leftSpawner.y > self.spawnerCenterY) {
                    spawnerAngle = 45;
                }
                
                scr_bullet_shot(self.leftSpawner.x, self.leftSpawner.y, spawnerAngle, 0.6, 4);
                self.activeSpawner = 0;
            } else {
                var spawnerAngle = 225;// top right to bottom left
                
                if (self.rightSpawner.y > self.spawnerCenterY) {
                    spawnerAngle = 135;
                }
                
                scr_bullet_shot(self.rightSpawner.x, self.rightSpawner.y, spawnerAngle, 0.6, 4);
                self. activeSpawner = 1;
            }
        }
    }
}

// Bars
if (self.currentPhase == PHASE_ACTIVE) {
    var moveRange = (obj_trash_conductor.LAYOUT_TILE_SIZE * 0.5) + (self.hp / self.MAX_HP) * (obj_trash_conductor.LAYOUT_TILE_SIZE * 1.5);
    
    self.topRangeTop = topRangeBottom - moveRange;
    self.bottomRangeBottom = bottomRangeTop + moveRange;
    
    for (i = 0; i < ds_list_size(self.topDeflectors); i++) {
        var topDeflector = ds_list_find_value(self.topDeflectors, i);
        
        if (topDeflector.speed == 0) {
            topDeflector.speed = 0.2;// Init
        } else if (topDeflector.y < self.topRangeTop) {
            topDeflector.speed = (random(0.4) + 0.1);
        } else if (topDeflector.y > self.topRangeBottom) {
            topDeflector.speed = -(random(0.4) + 0.1);
        }
    }
    
    for (i = 0; i < ds_list_size(self.bottomDeflectors); i++) {
        var bottomDeflector = ds_list_find_value(self.bottomDeflectors, i);
        
        if (bottomDeflector.speed == 0) {
            bottomDeflector.speed = 0.2;// Init
        } else if (bottomDeflector.y < self.bottomRangeTop) {
            bottomDeflector.speed = -(random(0.4) + 0.1);
        } else if (bottomDeflector.y > self.bottomRangeBottom) {
            bottomDeflector.speed = (random(0.4) + 0.1);
        }
    }
}
