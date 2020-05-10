if (!self.switchTriggered)
{
    return false;
}

var enemy_id, enemy, angle;

if (self.ticker == self.tickerLimit)
{
    if (self.enemiesAreRandom)
    {
        self.listIndex = random(ds_list_size(self.enemyList));
    }
    else
    {
        self.listIndex++;
    }
    
    if (self.listIndex >= ds_list_size(self.enemyList))
    {
        self.listIndex = 0;
    }
    
    show_debug_message("generating...");
    // Generate an enemy
    enemy_id = ds_list_find_value(self.enemyList, self.listIndex);
    enemy = instance_create(self.x, self.y, enemy_id);
    with (enemy) depth = -10;
    
    angle = random(self.generatorAngleMax - self.generatorAngleMin) + self.generatorAngleMin;
    enemy.direction = angle;
    
    if (self.enemySpeed > 0)
    {
        enemy.speed = self.enemySpeed;
    }
    
    self.enemyNumIndex++;
}

if (self.enemyNumIndex >= self.numEnemies)
{
// TODO: if necessary, destroy generator wake up event
    self.switchTriggered = false;
}
