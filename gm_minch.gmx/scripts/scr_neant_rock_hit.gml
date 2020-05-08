scr_enemy_hit();

if (self.behavior == self.BEHAVE_THRONE) {
    // Shoot towards circle outside (cannot be pushed)
    return false;
} else if (self.behavior == self.BEHAVE_STRAIGHT) {
    // Leave a trail of shots
} else if (self.behavior == self.BEHAVE_CURVE) {
    // Leave a trail of shots
} else if (self.behavior == self.BEHAVE_SUN) {
    // No shot
}

//show_debug_message("ROCK hit: " + string(self.id) + ", shield: " + string(self.shield) + ", hp: " + string(self.hp));

var hitStrength = 0.01;
var hitSpeedX = 0;
var hitSpeedY = 0;

if (other != noone) {
    switch (other.object_index) {
        case obj_bullet:
            hitSpeedX = other.x - other.xprevious;
            hitSpeedY = other.y - other.yprevious;
            break;
            
        case obj_sunray:
            hitSpeedX = other.x - other.xprevious;
            hitSpeedY = other.y - other.yprevious;
            hitStrength = 0.001;
            break;
            
        case obj_shot:
            hitSpeedX = other.x - other.xprevious;
            hitSpeedY = other.y - other.yprevious;
            break;
            
        case obj_wave_attack:
            hitSpeedX = self.x - other.x;
            hitSpeedY = self.y - other.y;
            hitStrength = 0.0006;
            break;
            
        case obj_claw_hitbox:
            hitSpeedX = other.x - other.xprevious;
            hitSpeedY = other.y - other.yprevious;
            hitStrength = 0.05;
            break;
    }
    
    //show_debug_message("hit to dir: " + string(other.direction) + ", speed: " + string(other.speed) + ", hitSpeedX: " + string(hitSpeedX) + ", hitSpeedY: " + string(hitSpeedY));
}

var speedX = self.x - self.xprevious + (hitSpeedX * hitStrength);
var speedY = self.y - self.yprevious + (hitSpeedY * hitStrength);

self.direction = arctan2(-speedY, speedX) / pi * 180;
self.speed = sqrt((speedX * speedX) + (speedY * speedY));

