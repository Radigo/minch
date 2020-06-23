var originX = argument0;
var originY = argument1;
var waveScale = argument2;

var numElements = 10;

for (var i = 0; i < numElements; i++)
{
    var wave_element = instance_create(originX, originY, obj_black_wave_element);
    
    // Each eleemnt has an frame based animation
    wave_element.image_xscale = waveScale;
    wave_element.image_yscale = waveScale;
    
    wave_element.image_angle = (i * 360) / numElements;
    wave_element.image_speed = 0.5;
}

var radialPusher = instance_create(self.x, self.y, obj_trash_radial_pusher);
radialPusher.targetScale = waveScale * 7.5;
