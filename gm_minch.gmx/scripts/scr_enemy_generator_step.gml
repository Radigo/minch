scr_ai_step();

if (!self.switchTriggered)
{
    return false;
}

var enemy_id, enemy, angle;

if (self.ticker == self.tickerLimit) {
    if (self.enemiesAreRandom) {
        self.listIndex = random(ds_list_size(self.enemyList));
    } else {
        self.listIndex++;
    }
    
    if (self.listIndex >= ds_list_size(self.enemyList)) {
        self.listIndex = 0;
    }
    
    // Generate an enemy
    enemy_id = ds_list_find_value(self.enemyList, self.listIndex);
    enemy = instance_create(self.x, self.y, enemy_id);
    with (enemy) depth = -10;
    
    angle = random(self.generatorAngleMax - self.generatorAngleMin) + self.generatorAngleMin;
    enemy.direction = angle;
    
    if (self.enemySpeed > 0) {
        enemy.speed = self.enemySpeed;
    }
    
    self.enemyNumIndex++;
    self.image_speed = 0.3;
    
    scr_play_sound(snd_generator, global.SFX_ENVIRONMENT, false);
}

if (self.enemyNumIndex >= self.numEnemies) {
    // TODO: if necessary, destroy generator wake up event
    self.switchTriggered = false;
}

if (self.image_index == self.image_number - 1) {
    self.image_index = 0;
    self.image_speed = 0;
}
