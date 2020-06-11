var travelRatio = min(abs(self.y - self.sourceY) / self.distance, 1);
self.image_index = floor((self.image_number - 1) * travelRatio);

if (self.y > self.targetY) {
    with (self) instance_destroy();
}


