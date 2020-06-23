if (!scr_trash_instance_step()) {
    return false;
}

var hpRatio = self.hp / self.MAX_HP;

// Moves
if (self.currentMove == self.MOVE_JUMP) {
    // Fly to destination
    var moveRatio = self.ticker / self.tickerLimit;
    var jumpHeight = sin(pi * moveRatio) * (256 - (128 * hpRatio));
    self.x = self.sourceX + ((self.targetX - self.sourceX) * moveRatio);
    self.y = self.sourceY + ((self.targetY - self.sourceY) * moveRatio) - jumpHeight;
    
    if (self.ticker > self.tickerLimit) {
        var waveScale = 1 - (hpRatio * 0.2);
        scr_black_wave(self.x, self.y, waveScale);
        
        self.currentMove = self.MOVE_LAND;
        self.tickerLimit = self.landDuration + (self.landDurationVar * hpRatio);
        self.ticker = 0;
        self.noCollision = false;
        self.shield = true;
        
        self.sprite_index = spr_trash_land_down;
    }
} else if (self.currentMove == self.MOVE_LAND) {
    // Lands, wave attack, pushes bullets
    
    if (self.ticker == self.burstDuration) {
        self.shield = false;
        
        self.sprite_index = spr_trash_idle;
    } else if (self.ticker > self.tickerLimit) {
        // Select next target
        self.sourceX = self.x;
        self.sourceY = self.y;
        self.targetX = obj_minch_feets.x;
        self.targetY = obj_minch_feets.y;
        
        
        self.currentMove = self.MOVE_JUMP;
        self.tickerLimit = self.jumpDuration + (self.jumpDurationVar * hpRatio);
        self.ticker = 0;
        self.noCollision = true;
        self.shield = true;
        
        self.sprite_index = spr_trash_jump_down;
    }
}

// Spawners
var canShoot = true;
// Left
if (self.tlSpawner.x > self.spawnerLeft) {
    self.tlSpawner.x -= max(abs(self.spawnerLeft - self.tlSpawner.x) * 0.05, 0.5);
    self.blSpawner.x -= max(abs(self.spawnerLeft - self.blSpawner.x) * 0.05, 0.5);
    canShoot = false;
}
// Right
if (self.trSpawner.x < self.spawnerRight) {
    self.trSpawner.x += max(abs(self.spawnerRight - self.trSpawner.x) * 0.05, 0.5);
    self.brSpawner.x += max(abs(self.spawnerRight - self.brSpawner.x) * 0.05, 0.5);
    canShoot = false;
}
// Top
if (self.tlSpawner.y > self.spawnerTop) {
    self.tlSpawner.y -= max(abs(self.spawnerTop - self.tlSpawner.y) * 0.1, 0.5);
    self.trSpawner.y -= max(abs(self.spawnerTop - self.trSpawner.y) * 0.1, 0.5);
    canShoot = false;
}
// Bottom
if (self.blSpawner.y < self.spawnerBottom) {
    self.blSpawner.y += max(abs(self.spawnerBottom - self.blSpawner.y) * 0.02, 0.5);
    self.brSpawner.y += max(abs(self.spawnerBottom - self.brSpawner.y) * 0.02, 0.5);
    canShoot = false;
}

var bulletSpeed = 1.2;

if (canShoot) {
    // HP variables
    self.streamNumBullets = 16 - floor(6 * hpRatio);
    self.streamDelay = 60 + floor(120 * hpRatio);
    
    // TL
    for (var i = 0; i < ds_list_size(self.tlTimers); i++) {
        var tlTimer = ds_list_find_value(self.tlTimers, i);
        tlTimer--;
        if (tlTimer <= 0) {
            // Reinit
            tlTimer = self.streamDelay + (self.streamNumBullets * self.streamBulletsFrequency);
            ds_list_replace(self.tlAngles, i, random_range(270, 360));
        } else if (tlTimer < (self.streamNumBullets * self.streamBulletsFrequency)) {
            // Shoot
            if ((tlTimer % self.streamBulletsFrequency) == 0) {
                scr_bullet_shot(self.tlSpawner.x, self.tlSpawner.y, ds_list_find_value(self.tlAngles, i), bulletSpeed, 3);
            }
        }
        ds_list_replace(self.tlTimers, i, tlTimer);
    }
    // TR
    for (var i = 0; i < ds_list_size(self.trTimers); i++) {
        var trTimer = ds_list_find_value(self.trTimers, i);
        trTimer--;
        if (trTimer <= 0) {
            // Reinit
            trTimer = self.streamDelay + (self.streamNumBullets * self.streamBulletsFrequency);
            ds_list_replace(self.trAngles, i, random_range(180, 270));
        } else if (trTimer < (self.streamNumBullets * self.streamBulletsFrequency)) {
            // Shoot
            if ((trTimer % self.streamBulletsFrequency) == 0) {
                scr_bullet_shot(self.trSpawner.x, self.trSpawner.y, ds_list_find_value(self.trAngles, i), bulletSpeed, 3);
            }
        }
        ds_list_replace(self.trTimers, i, trTimer);
    }
    // BL
    for (var i = 0; i < ds_list_size(self.blTimers); i++) {
        var blTimer = ds_list_find_value(self.blTimers, i);
        blTimer--;
        if (blTimer <= 0) {
            // Reinit
            blTimer = self.streamDelay + (self.streamNumBullets * self.streamBulletsFrequency);
            ds_list_replace(self.blAngles, i, random_range(0, 90));
        } else if (blTimer < (self.streamNumBullets * self.streamBulletsFrequency)) {
            // Shoot
            if ((blTimer % self.streamBulletsFrequency) == 0) {
                scr_bullet_shot(self.blSpawner.x, self.blSpawner.y, ds_list_find_value(self.blAngles, i), bulletSpeed, 3);
            }
        }
        ds_list_replace(self.blTimers, i, blTimer);
    }
    // BR
    for (var i = 0; i < ds_list_size(self.brTimers); i++) {
        var brTimer = ds_list_find_value(self.brTimers, i);
        brTimer--;
        if (brTimer <= 0) {
            // Reinit
            brTimer = self.streamDelay + (self.streamNumBullets * self.streamBulletsFrequency);
            ds_list_replace(self.brAngles, i, random_range(90, 180));
        } else if (brTimer < (self.streamNumBullets * self.streamBulletsFrequency)) {
            // Shoot
            if ((brTimer % self.streamBulletsFrequency) == 0) {
                scr_bullet_shot(self.brSpawner.x, self.brSpawner.y, ds_list_find_value(self.brAngles, i), bulletSpeed, 3);
            }
        }
        ds_list_replace(self.brTimers, i, brTimer);
    }
}
