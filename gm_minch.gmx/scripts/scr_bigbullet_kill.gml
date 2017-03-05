var emitter_x = argument0;
var emitter_y = argument1;

var em_bigblue = part_emitter_create(global.ps_light);

part_emitter_region(global.ps_light, em_bigblue, (emitter_x - 8), (emitter_x + 8), (emitter_y - 8), (emitter_y + 8), ps_shape_ellipse, ps_distr_invgaussian);
part_emitter_burst(global.ps_light, em_bigblue, global.pt_big_bullets, 8);
