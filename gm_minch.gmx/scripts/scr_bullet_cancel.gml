// Replace a bullet by a cancel sprite
// Self is supposed to be a bullet object instance

bullet_cancel = instance_create(self.x, self.y, obj_bullet_cancel);
bullet_cancel.image_speed = 0.25;
bullet_cancel.speed = self.speed * 0.6;
bullet_cancel.direction = self.direction;

with (self) instance_destroy();
