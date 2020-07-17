self.ticker++;

if (self.ticker > self.duration) {
    with (self) instance_destroy();
}
