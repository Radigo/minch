// Describe the spread of the main attack wave

if (self.waveTicker > self.waveDuration)
{
    instance_destroy();
}
else
{
    self.waveTicker ++;
    
    var wave_scale = sin((self.waveTicker / self.waveDuration) * (pi / 2)) * 2.1;
    
    self.image_xscale = wave_scale * self.targetScale;
    self.image_yscale = wave_scale * self.targetScale;
}
