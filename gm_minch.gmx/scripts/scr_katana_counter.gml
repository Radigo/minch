// Throw back bullets
var bulletSpeed = random_range(0.5, 2);
scr_bullet_shot(self.x, self.y, scr_get_moreorless(self.image_angle, 30) + 90, bulletSpeed, irandom_range(1, 3));
