if (!self.switchTriggered) {
    return false;
}

// Has focus all the time
if (object_exists(obj_minch_camera)) {
    if (obj_minch_camera.focus == obj_minch) {
        // Restore focus
        scr_switch_machine(1);
    }
}

//show_debug_message("scr_neant_step: " + self.currentPhase + ", hp: " + string(self.hp));

if (self.currentPhase == self.PHASE_THRONE_INTRO) {
    // Just a dummy phase to reinit tickers
    self.ticker = 0;
    self.patternTicker = 0;
    self.currentPhase = self.PHASE_THRONE_ROCKS;
    self.sprite_index = spr_neant_sitting_hand;
} else if (self.currentPhase == self.PHASE_THRONE_ROCKS) {
    // Sitting on throne, creating rocks, activating cannons
    self.tickerLimit = self.THRONE_INTRO_TICKER_LIMIT;
    self.patternTickerLimit = floor(self.THRONE_INTRO_TICKER_LIMIT / self.NUM_THRONE_ROCKS);
    
    if (self.patternTicker == 1) {
        // Spawn rock at orbit position right
        var rock = instance_create((self.x + self.ORBIT_X), (self.y + self.THRONE_ORBIT_CENTER_Y_OFFSET), obj_neant_rock);
        rock.behavior = rock.BEHAVE_THRONE;
        rock.hp = rock.MAX_HP;
    }
    
    if (self.ticker == self.tickerLimit) {
        self.ticker = 0;
        self.currentPhase = self.PHASE_THRONE;
        self.sprite_index = spr_neant_sitting_idle;
    }
    
} else if (self.currentPhase == self.PHASE_THRONE) {
    // Sitting on throne, rocks turning around
    self.shield = false;
    if (self.hp < (self.PHASE_ROOM_HP + self.PHASE_SUN_HP)) {
        self.ticker = 0;
        self.tickerLimit = 120;
        self.currentPhase = self.PHASE_THRONE_STANDING;
        self.sprite_index = spr_neant_standing;
        self.image_speed = 0;
        
        // Roof explodes
        instance_destroy(self.roof);
        scr_boom(self.x, self.y, 4, 64);
        
        // All cannons explode
        while (instance_number(obj_cannon_a) > 0) {
            instance_destroy(instance_find(obj_cannon_a, 0));
        }
        while (instance_number(obj_cannon_b) > 0) {
            instance_destroy(instance_find(obj_cannon_b, 0));
        }
        while (instance_number(obj_cannon_c) > 0) {
            instance_destroy(instance_find(obj_cannon_c, 0));
        }
        
        scr_all_bullet_cancel();
        
        // All circling rocks explode
        while (instance_number(obj_neant_rock) > 0) {
            instance_destroy(instance_find(obj_neant_rock, 0));
        }
    }
} else if (self.currentPhase == self.PHASE_THRONE_STANDING) {
    // Stand up on throne, ready to jump in room
    var capeAnimStart = 60;
    var capeSpriteSpawn = capeAnimStart + floor(3 / self.image_speed);// Sprite spawn @ 3rd animation frame
    
    if (self.ticker == capeAnimStart) {
        // Throw cape
        self.image_speed = 0.1;
    } else if (self.ticker == capeSpriteSpawn) {
        // Spawn cape sprite
        var cape = instance_create((self.x - 8), (self.y + 8), obj_neant_cape);
        cape.depth = self.depth - 1;
        cape.direction = 220;
        cape.speed = 1;
    } else if (self.ticker < 120) {
        if (self.image_index == self.image_number - 1) {
            self.image_speed = 0;
        }
    } else {
        // Fly & start emitting particles
        scr_neant_change_room_pattern();
        part_emitter_stream(global.ps_ground, self.em_fx, self.pt_fx, 1);
        self.depth = 0;
    }
} else if (self.currentPhase == self.PHASE_ROCKS_EXPLODING) {
    // Flying in room, sending rocks in straight lines aiming for MinCH
    self.tickerLimit = 1000;
    self.patternTickerLimit = 200;
    
    var targetRadius = 128;
    var targetOrbitAngle = ((pi * 2) * (self.ticker / self.tickerLimit)) - (pi * 0.5);
    
    var targetX = self.orbitCenterX + cos(targetOrbitAngle) * targetRadius;
    var targetY = self.orbitCenterY + sin(targetOrbitAngle) * targetRadius;
    
    self.direction = point_direction(self.x, self.y, targetX, targetY);
    self.speed = 1;
    
    if (self.patternTicker == self.patternTickerLimit) {
        // Throw rock
        var rockAngle = point_direction(self.x, self.y, obj_minch_feets.x, obj_minch_feets.y);
        var rockAngleRad = -rockAngle * pi / 180;
        var spawnX = self.x + (cos(rockAngleRad) * 48);
        var spawnY = self.y + (sin(rockAngleRad) * 48);
        
        var rock = instance_create(spawnX, spawnY, obj_neant_rock);
        rock.behavior = rock.BEHAVE_STRAIGHT;
        rock.hp = floor(rock.MAX_HP * 0.6);
        rock.strColor = "cy";
        rock.direction = rockAngle;
        rock.speed = 1.5;
    }
    
    if ((self.hp < self.PHASE_SUN_HP) || (self.ticker == self.tickerLimit)) {
        // Change pattern
        scr_neant_change_room_pattern();
    }
    
} else if (self.currentPhase == self.PHASE_ROCKS_TRACES) {
    // FLying in room, sending rocks with curved pathes and leaving bullets
    self.tickerLimit = 1000;
    var throwDuration = 600;
    self.patternTickerLimit = 20 + ceil((1 - (self.ticker / throwDuration)) * 100);
    
    var targetOrbitAngle = ((pi * 2) * (self.ticker / self.tickerLimit));
    
    var targetX = self.orbitCenterX + cos(targetOrbitAngle * 2.5) * 64;
    var targetY = self.orbitCenterY + sin(targetOrbitAngle * 0.5) * 32;
    
    self.direction = point_direction(self.x, self.y, targetX, targetY);
    self.speed = 0.5;
    
    if (self.ticker < throwDuration) {
        // Change pattern
        self.currentPhase = self.PHASE_ROCKS_TRACES;
        if (self.patternTicker == self.patternTickerLimit) {
            // Throw rock
            var rockCurveValue = random(180);
            var rockAngle = rockCurveValue + 180;
            var rockAngleRad = -rockAngle * pi / 180;
            var spawnX = self.x + (cos(rockAngleRad) * 48);
            var spawnY = self.y + (sin(rockAngleRad) * 48);
            
            var rock = instance_create(spawnX, spawnY, obj_neant_rock);
            rock.behavior = rock.BEHAVE_CURVE;
            rock.curveRatio = -((rockCurveValue - 90) / 90);
            rock.hp = floor(rock.MAX_HP * 0.9);
            rock.strColor = "ma";
            rock.direction = rockAngle;
            rock.speed = 1.5;
        }
    } else if ((self.hp < self.PHASE_SUN_HP) || (self.ticker == self.tickerLimit)) {
        // Change pattern
        scr_neant_change_room_pattern();
    }
    
} else if (self.currentPhase == self.PHASE_ROCKS_SUN) {
    // FLying in room center, rocks turning around and throwing lasers
    self.tickerLimit = 10000;
    self.patternTickerLimit = 200;
    
    self.direction = point_direction(self.x, self.y, self.orbitCenterX, self.orbitCenterY);
    var distance = point_distance(self.x, self.y, self.orbitCenterX, self.orbitCenterY);
    
    if ((distance > 64) && (self.speed < 2)) {
        // Travel to center
        self.speed = self.speed + 0.05;
        self.ticker = 0;
    } else if ((distance > 1) && (self.speed > 0.2)) {
        // Travel to center
        self.speed = self.speed * 0.9;
        self.ticker = 0;
    } else {
        // Sun pattern
        self.speed = 0;
        self.sprite_index = spr_neant_flying_sun;
        
        var sourceX = self.x;
        var sourceY = self.y;
        
        if ((self.ticker > 450) && ((self.ticker % 4) == 0)) {
            // Send sunrays like crayzi
            var numRays = 56;
            var initAngle = self.ticker % 360;
            for (var i = 0; i < numRays; i++) {
                var rayAngle = initAngle + ((i / numRays) * 360);
                var ray = scr_bullet_shot(sourceX, sourceY, rayAngle, 3, 2, obj_sunray, true);
                ray.depth = self.depth +1;                
                ray.image_xscale = ray.speed * 0.4;
                ray.image_yscale = 0.5;
            }
        } else if (self.ticker == self.tickerLimit) {
            // Kill
            self.hp = 0;
        }
        
        if ((self.patternTicker == self.patternTickerLimit) && (instance_number(obj_neant_rock) < 32)) {
            // Throw rocks
            var rockCurveValue = 0.2;
            if (self.prevSunCurveRatio > 0) {
                rockCurveValue = -rockCurveValue;
            }
            self.prevSunCurveRatio = rockCurveValue;
            
            var rockAngle = random(360 / self.sunNumRocks);
            
            for (var i = 0; i < self.sunNumRocks; i++) {
                var rockAngleRad = -rockAngle * pi / 180;
                var spawnX = sourceX + (cos(rockAngleRad) * 48);
                var spawnY = sourceY + (sin(rockAngleRad) * 48);
                
                var rock = instance_create(spawnX, spawnY, obj_neant_rock);
                rock.behavior = rock.BEHAVE_SUN;
                rock.curveRatio = rockCurveValue;
                rock.hp = rock.MAX_HP;
                rock.strColor = "ye";
                if (rockCurveValue > 0) {
                    rock.direction = rockAngle + 90;
                } else {
                    rock.direction = rockAngle - 90;
                }
                rock.speed = 0.5;
                
                rockAngle = rockAngle + (360 / self.sunNumRocks);
            }
            
            if (self.sunNumRocks > 4) {
                self.sunNumRocks = self.sunNumRocks - 1;
            }
        }
    }
} else if (self.currentPhase == self.PHASE_DEATH) {
    // Falling dead to room top
    
}

if (part_emitter_exists(global.ps_ground, self.em_fx)) {
    part_emitter_region(global.ps_ground, self.em_fx, (self.x - 2), (self.x + 2), (self.y - 32), (self.y + 32), ps_shape_ellipse, ps_distr_gaussian);
}
