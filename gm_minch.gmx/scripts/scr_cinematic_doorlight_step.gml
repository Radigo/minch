if (self.status == "inactive") {
    return false;
}

if (self.image_xscale <= 0) {
    with (self) instance_destroy();
} else {
    self.image_xscale = self.image_xscale - 0.05;
}
