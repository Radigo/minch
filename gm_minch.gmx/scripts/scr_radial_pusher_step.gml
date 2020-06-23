self.ticker++;

if (self.ticker > self.tickerLimit) {
    with (self) instance_destroy();
} else {
    self.image_xscale = self.targetScale * (self.ticker / self.tickerLimit);
    self.image_yscale = self.targetScale * (self.ticker / self.tickerLimit);
}
