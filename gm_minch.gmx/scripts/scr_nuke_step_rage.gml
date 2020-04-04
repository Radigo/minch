/*
Spawn in knee attack up with front FX
Lands on CH1
Wait, look at MinCH
knee attack down and disapears through hole
*/

self.shield = true;

if (self.ticker == 2) {
    if (instance_exists(obj_ch1_legs))
        self.landingTargetY = obj_ch1_legs.y;
    self.sprite_index = spr_nuke_kneeattack_up;
    image_speed = 0.5;
    self.greenWave = instance_create(self.x, self.y, obj_grenwave);
} else if (self.ticker < 60) {
    var attackProgress = self.ticker / 60;
    self.y = self.initY - ((self.initY - self.landingTargetY) * attackProgress);
    self.greenWave.y = self.y - self.greenWaveDistance;
} else if (self.ticker < 300) {
    self.sprite_index = spr_nuke_idle_down;
    instance_destroy(self.greenWave);
} else if (self.ticker < 500) {
    self.sprite_index = spr_nuke_idle_down_facingright;
} else if (self.ticker == 500) {
    self.sprite_index = spr_nuke_kneeattack_down;
    image_speed = 0.5;
    self.greenWave = instance_create(self.x, self.y, obj_grenwave);
    self.greenWave.image_angle = 180;
} else if (self.y < self.initY) {
    self.y += 4;
    self.greenWave.y = self.y + self.greenWaveDistance;
} else if (image_alpha > 0) {
    self.y +=4;
    image_alpha -= 0.08;
    instance_destroy(obj_grenwave);
} else {
    with (self)
        instance_destroy();
}
