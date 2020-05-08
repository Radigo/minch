//show_debug_message("ROCK step: patternTicker" + string(self.patternTicker) + "/" + string(self.patternTickerLimit) + ", id: " + string(self.id) + ", speed: " + string(self.speed) + ", dir: " + string(self.direction));

// Move
if (self.behavior == self.BEHAVE_THRONE) {
    // Rotates around sitting Neant, can pass behind church roof
    self.patternTickerLimit = 10 + ceil((self.hp / self.MAX_HP) * 60);
    
    var neant = instance_find(obj_neant, 0);
    
    if (neant == noone) {
        // Change beahavior? destroy?
        instance_destroy();
        return false;
    }
    
    self.tickerLimit = neant.THRONE_INTRO_TICKER_LIMIT;
    var orbitAngle = (pi * 2) * (self.ticker / self.tickerLimit);
    self.x = neant.x + (cos(orbitAngle) * neant.ORBIT_X);
    self.y = neant.y + (sin(orbitAngle) * neant.ORBIT_Y) + neant.THRONE_ORBIT_CENTER_Y_OFFSET;
    
    if (self.y < neant.y) {
        self.depth = neant.depth + 10;
    } else {
        self.depth = neant.depth - 10;
    }
    
    self.image_angle = 360 * (self.ticker / self.tickerLimit);
} else if (self.behavior == self.BEHAVE_STRAIGHT) {
    // No influence after init throw
    self.patternTickerLimit = 1;
} else if (self.behavior == self.BEHAVE_CURVE) {
    // Turns to draw nice curves
    self.patternTickerLimit = 1;
    self.direction += self.curveRatio;
    self.image_angle += self.curveRatio;
} else if (self.behavior == self.BEHAVE_SUN) {
    // Rotates around flying neant
    self.patternTickerLimit = (self.hp / self.MAX_HP) * 100;
    self.direction += self.curveRatio / self.speed;
    self.image_angle += self.curveRatio;
}

// Shoot
var shot = false;

if ((self.patternTicker == self.patternTickerLimit) && (self.hp < self.MAX_HP)) {
    var shotAngleDeg = random(360);
    var shotSpeed = 2;
    if (self.behavior == self.BEHAVE_THRONE) {
        var shotAngleRad = (pi * 2) * (self.ticker / self.tickerLimit);
        shotAngleDeg = -shotAngleRad / pi * 180;
        shot = true;
    } else if (self.behavior == self.BEHAVE_STRAIGHT) {
        // Leave a trail of shots
        shotAngleDeg = scr_get_moreorless(self.direction + 180, 3);
        shotSpeed = 1;
        shot = true;
    } else if (self.behavior == self.BEHAVE_CURVE) {
        // Leave a trail of shots
        shotAngleDeg = scr_get_moreorless(self.direction + 180, 4);
        shotSpeed = 1;
        shot = true;
    } else if (self.behavior == self.BEHAVE_SUN) {
        // No shot
    }
    
    if (shot) {
        var shotAngleRad = shotAngleDeg * pi / 180;
        var spawnDistance = image_xscale * 16;
        var shotX = self.x + cos(shotAngleRad) * spawnDistance;
        var shotY = self.y - sin(shotAngleRad) * spawnDistance;
        
        scr_bullet_shot(shotX, shotY, shotAngleDeg, shotSpeed, 2);
        self.hp += 1;
    }
}

// Visual cue for hps (grows bigger when close to explode)
if (self.hp > 0) {
    var scale = 0.5 + (1 - ((self.hp / self.MAX_HP) * 0.7));
    image_xscale = scale;
    image_yscale = scale;
}

// Manages frames animation
if (image_speed > 0)
{
    if (image_index >= image_number - 1)
    {
        image_speed = 0;
        // Spawns core
        self.core.image_speed = 0.5;
    }
} else if (self.core.image_speed > 0) {
    if (self.core.image_index >= self.core.image_number - 1)
    {
        instance_destroy(self.core);
        // Spawns core color
        self.color = scr_colors_str_to_int(self.strColor);
        switch (self.color) {
            case global.CY:
                self.core = instance_create(self.x, self.y, obj_rock_core_cy);
                break;
            case global.MA:
                self.core = instance_create(self.x, self.y, obj_rock_core_ma);
                break;
            case global.YE:
                self.core = instance_create(self.x, self.y, obj_rock_core_ye);
                break;
            case global.PU:
                self.core = instance_create(self.x, self.y, obj_rock_core_pu);
                break;
            case global.RG:
                self.core = instance_create(self.x, self.y, obj_rock_core_or);
                break;
            case global.GR:
                self.core = instance_create(self.x, self.y, obj_rock_core_gr);
                break;
            case global.BR:
                self.core = instance_create(self.x, self.y, obj_rock_core_br);
                break;
            case global.BK:
            default:
                self.core = instance_create(self.x, self.y, obj_rock_core_bk);
                break;
        }
    }
}

self.core.depth = self.depth - 1;
self.core.x = self.x;
self.core.y = self.y;
