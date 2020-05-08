self.image_alpha = self.image_alpha - 0.01;

if (self.image_alpha <= 0) {
    with (self) instance_destroy();
}
