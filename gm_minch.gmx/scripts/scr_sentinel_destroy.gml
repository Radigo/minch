if (self.canon != noone)
{
    with (self.canon) instance_destroy();
    self.canon = noone;
}

with (self.target) instance_destroy();
