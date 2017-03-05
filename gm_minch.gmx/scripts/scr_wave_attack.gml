var init_x = argument0;
var init_y = argument1;
var attack_scale = argument2;

var num_elements = 12;
// Create graphic wave elements at start
for (var i = 0; i < num_elements; i++)
{
    var wave_element = instance_create(init_x, init_y, obj_wave_attack_element);
    
    // Each eleemnt has an frame based animation
    wave_element.image_xscale = attack_scale;
    wave_element.image_yscale = attack_scale;
    
    wave_element.image_angle = (i * 360) / num_elements;
    wave_element.image_speed = 0.5;
}

// Create main hit element
var wave_instance = instance_create(init_x, init_y, obj_wave_attack);
wave_instance.targetScale = attack_scale;

var em_wave_smoke = part_emitter_create(global.ps_ground); 
part_emitter_region(global.ps_ground, em_wave_smoke, (init_x - 1), (init_x + 1), (init_y - 1), (init_y + 1), ps_shape_ellipse, ps_distr_invgaussian);
part_type_direction(global.pt_light_ray, 0, 360, 0, 0);
part_emitter_burst(global.ps_ground, em_wave_smoke, global.pt_light_ray, 64);

// Sound
audio_play_sound(snd_wave, 0, false);
