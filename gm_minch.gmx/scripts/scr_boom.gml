// Displays explosions,s hrapnels and sparkles

var source_x = argument[0];
var source_y = argument[1];
var level = argument[2];
var size = argument[3];
var silent = false;

if (argument_count > 4) {
   silent = argument[4];
}

var em_shrapnels = part_emitter_create(global.ps_air);
var em_rays = part_emitter_create(global.ps_light);

// Particles
part_emitter_region(global.ps_air, em_shrapnels, (source_x - (size / 2)), (source_x + (size / 2)), (source_y - (size / 2)), (source_y + (size / 2)), ps_shape_ellipse, ps_distr_invgaussian);
part_emitter_region(global.ps_light, em_rays, (source_x - (size / 2)), (source_x + (size / 2)), (source_y - (size / 2)), (source_y + (size / 2)), ps_shape_ellipse, ps_distr_invgaussian);

switch (level){
    case 4:
        part_emitter_burst(global.ps_light, em_rays, global.pt_light_ray, 12);
        part_emitter_burst(global.ps_air, em_shrapnels, global.pt_shrapnels_big, 12);
        part_emitter_burst(global.ps_air, em_shrapnels, global.pt_shrapnels_medium, 8);
        part_emitter_burst(global.ps_air, em_shrapnels, global.pt_shrapnels_small, 12);
        var boom_fx = instance_create(source_x, source_y, obj_fx_boom_big);
        boom_fx.image_speed = 0.33;
        if (!silent) {
            scr_play_sound(snd_boom_heavyier, global.SFX_BOOMS, false);
        }
        break;
    case 3:
        part_emitter_burst(global.ps_light, em_rays, global.pt_light_ray, 10);
        part_emitter_burst(global.ps_air, em_shrapnels, global.pt_shrapnels_medium, 12);
        part_emitter_burst(global.ps_air, em_shrapnels, global.pt_shrapnels_small, 12);
        var boom_fx = instance_create(source_x, source_y, obj_fx_boom_small);
        boom_fx.image_speed = 0.33;
        if (!silent) {
            scr_play_sound(snd_boom_heavy, global.SFX_BOOMS, false);
        }
        break;
    case 2:
        part_emitter_burst(global.ps_light, em_rays, global.pt_light_ray, 8);
        part_emitter_burst(global.ps_air, em_shrapnels, global.pt_shrapnels_small, 18);
        var boom_fx = instance_create(source_x, source_y, obj_fx_boom_tiny);
        boom_fx.image_speed = 0.33;
        if (!silent) {
            scr_play_sound(snd_boom_medium, global.SFX_BOOMS, false);
        }
        break;
    case 1:
        part_emitter_burst(global.ps_light, em_rays, global.pt_light_ray, 12);
        var boom_fx = instance_create(source_x, source_y, obj_fx_boom_tiny);
        boom_fx.image_speed = 0.33;
        if (!silent) {
            scr_play_sound(snd_boom_light, global.SFX_BOOMS, false);
        }
        break;
}

// Boom sprite
object_set_depth(obj_fx_boom_small, -20);
