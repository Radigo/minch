if (self.overlay != noone) {
    instance_destroy(self.overlay);
    self.overlay = noone;
}

if (self.roof != noone) {
    instance_destroy(self.roof);
    self.roof = noone;
    
    scr_boom(self.x, (self.y - 32), 4, 64);
}
