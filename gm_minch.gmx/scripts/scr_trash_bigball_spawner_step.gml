self.ticker++;

if (self.ticker < self.growthDuration) {
    // Growing ball
    var ballScale = min(max(scr_get_moreorless((self.ticker / self.growthDuration), 0.1), 0), 1) * self.targetScale;
    self.image_xscale = ballScale;
    self.image_yscale = ballScale;
    // Charging rays
    var rayAngleRad = random(pi * 2);
    var distance = self.BALL_RADIUS * ballScale;
    var rayX = self.x + cos(rayAngleRad) * distance;
    var rayY = self.y - sin(rayAngleRad) * distance;
    var ray = instance_create(rayX, rayY, obj_biggerbullet_ray);
    ray.depth = self.depth - 1;
    ray.image_angle = rayAngleRad / pi * 180;
    ray.image_xscale = (self.targetScale - ballScale);
    ray.image_yscale = (self.targetScale - ballScale);
} else if (self.ticker == self.growthDuration) {
    self.speed = self.travelSpeed;
    self.image_speed = 0.5;
    
    // Only one at a time to avoid overlaps
    audio_stop_sound(snd_trash_bgibullet);
    scr_play_sound(snd_trash_bgibullet, global.SFX_ENVIRONMENT, false);
}
