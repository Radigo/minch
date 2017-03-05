var start_rotation_frame = 10;

if (self.attackTicker > start_rotation_frame)
{
    //start rotating
    self.image_angle = self.image_angle - ((self.attackTicker - start_rotation_frame) * 0.5);
}

self.attackTicker++;
