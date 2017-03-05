self.ticker++;

if (self.ticker > 10)
{
    image_speed = 0.2;
}

if (self.ticker == 15)
{
    scr_reveal_neighbor();
}

// Loop kill
if (image_index >= image_number - 1)
{
    instance_destroy();
}
