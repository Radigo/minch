var rand_bounce_angle, target_next_position_x, target_next_position_y, num_attempts;

self.rotationDirection = -self.rotationDirection;

// Throw a bouncing pattern
scr_pattern_spread(self.x, self.y, random(360), 2.5, 3, 12, 360);
self.hp -= 5;

// Place target in a safe area
// For a small amount of frames, sentinel will move towards the target
rand_bounce_angle = random(pi * 2);

target_next_position_x = self.x + cos(rand_bounce_angle) * 32;
target_next_position_y = self.y + sin(rand_bounce_angle) * 32;

num_attempts = 0;

while (collision_circle(target_next_position_x, target_next_position_y, 24, obj_wall, false, true))
{
    num_attempts++
    
    if (num_attempts > 10)
    {
        self.value = 0;
        self.hp = 0;
        return false;
    }
    
    rand_bounce_angle = random(pi * 2);
    
    target_next_position_x = self.x + cos(rand_bounce_angle) * 32;
    target_next_position_y = self.y + sin(rand_bounce_angle) * 32;
}

self.target.x = target_next_position_x;
self.target.y = target_next_position_y;

// Reset rotation movement
self.moveRadius = 0;
self.ticker = 0;
self.status = self.STATUS_COLLISION;
