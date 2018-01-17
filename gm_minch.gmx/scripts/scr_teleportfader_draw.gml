// Fader
var progress = self.ticker / self.duration;

if (progress < 0.5)
{
    draw_set_alpha(progress * 2);
}
else if (progress < 1)
{
    draw_set_alpha(2 - (progress * 2));
}
else
{
    draw_set_alpha(0);
    instance_destroy();
}

draw_set_colour(c_black);
draw_rectangle(view_xview[0], view_yview[0], view_xview[0] + 320, view_yview[0] + 240, false);

draw_set_alpha(1);// Reinit

self.ticker ++;
