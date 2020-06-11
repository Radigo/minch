// Bounce bullets on hit

if (self.direction < 180) {
    // Bottom deflectors, bounce up
    if (other.vspeed > 0) {
        other.vspeed *= -1;
        // FX
        var numDots = 10;
        var impactX = other.x - floor(numDots * 0.5);
        var impactY = self.y - 8;
        
        for (var i = 0; i < numDots; i++) {
            var dot = instance_create(impactX + i, impactY, obj_fading_black_spot);
            dot.depth = self.depth -1;
            dot.image_speed = 0.4;
            dot.direction = 90;
            dot.speed = self.speed + random(1);
        }
    }
} else {
    // Top deflectors, bounce down
    if (other.vspeed < 0) {
        other.vspeed *= -1;
        // FX
        var numDots = 10;
        var impactX = other.x - floor(numDots * 0.5);
        var impactY = self.y + 4;
        
        for (var i = 0; i < numDots; i++) {
            var dot = instance_create(impactX + i, impactY, obj_fading_black_spot);
            dot.depth = self.depth -1;
            dot.image_speed = 0.4;
            dot.direction = -90;
            dot.speed = self.speed + random(1);
        }
    }
}

