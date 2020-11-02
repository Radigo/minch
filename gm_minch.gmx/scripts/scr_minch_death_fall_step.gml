self.image_xscale = 1 - (self.ticker / self.fallDuration);
self.image_yscale = 1 - (self.ticker / self.fallDuration);
self.y += 0.2;
self.image_angle += 6;

self.ticker++;

if (self.ticker >= self.fallDuration) {
    with (self) instance_destroy();
}
