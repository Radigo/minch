/*
ps = particle system
pt = particle type
pe = particle emitter
*/

global.PARTICLE_SYSTEM_GROUND = "ground";
global.PARTICLE_SYSTEM_AIR = "air";
global.PARTICLE_SYSTEM_LIGHT = "light";

// Particles displayed under sprites
global.ps_ground = part_system_create();
part_system_depth(1000, global.ps_ground);
global.ground_pt_list = ds_stack_create();

// Particles displayed over sprites
global.ps_air = part_system_create();
part_system_depth(-10, global.ps_air);
global.air_pt_list = ds_stack_create();

// Particles displayed over shades
global.ps_light = part_system_create();
part_system_depth(-15000, global.ps_light);
global.light_pt_list = ds_stack_create();


// Create common particle types
// Jump smoke
global.pt_smoke = part_type_create();
part_type_sprite(global.pt_smoke, spr_fx_smoke_16_0, true, true, false);
part_type_speed(global.pt_smoke, 0.3, 1.5, -0.02, 0);
part_type_life(global.pt_smoke, 20, 50);
part_type_gravity(global.pt_smoke, 0.01, 90);
ds_stack_push(global.ground_pt_list, global.pt_smoke);

// Shots hit (when hitting an enemy)
global.pt_hit_sparkles = part_type_create();
part_type_sprite(global.pt_hit_sparkles, spr_shot_hit_sparkles, true, true, false);
part_type_speed(global.pt_hit_sparkles, 0.2, 3, -0.01, 0);
part_type_life(global.pt_hit_sparkles, 8, 30);
part_type_orientation(global.pt_hit_sparkles, 180, 180, 0, 0, true);
ds_stack_push(global.light_pt_list, global.pt_hit_sparkles);

// Shots block (when hitting invincible things, shields, walls)
global.pt_shot_sparkles = part_type_create();
part_type_sprite(global.pt_shot_sparkles, spr_shot_sparkles, true, true, false);
part_type_speed(global.pt_shot_sparkles, 0.3, 4, -0.015, 0);
part_type_life(global.pt_shot_sparkles, 5, 20);
part_type_orientation(global.pt_shot_sparkles, 180, 180, 0, 0, true);
ds_stack_push(global.light_pt_list, global.pt_shot_sparkles);

// Mechanical parts (exploding enemies)
global.pt_shrapnels_small = part_type_create();
part_type_sprite(global.pt_shrapnels_small, spr_shrapnel_small, true, false, true);
part_type_speed(global.pt_shrapnels_small, 0.15, 2.5, -0.015, 0.1);
part_type_direction(global.pt_shrapnels_small, -45, 225, 0, 0.1);
part_type_life(global.pt_shrapnels_small, 20, 40);
part_type_gravity(global.pt_shrapnels_small, 0.005, -90);
ds_stack_push(global.air_pt_list, global.pt_shrapnels_small);

global.pt_shrapnels_medium = part_type_create();
part_type_sprite(global.pt_shrapnels_medium, spr_shrapnel_medium, true, false, true);
part_type_speed(global.pt_shrapnels_medium, 0.15, 2.5, -0.01, 0.05);
part_type_direction(global.pt_shrapnels_medium, 30, 150, 0, 0.05);
part_type_life(global.pt_shrapnels_medium, 50, 80);
part_type_gravity(global.pt_shrapnels_medium, 0.02, -90);
ds_stack_push(global.air_pt_list, global.pt_shrapnels_medium);

global.pt_shrapnels_big = part_type_create();
part_type_sprite(global.pt_shrapnels_big, spr_shrapnel_big, true, false, true);
part_type_speed(global.pt_shrapnels_big, 0.25, 3, -0.01, 0.05);
part_type_direction(global.pt_shrapnels_big, 45, 135, 0, 0.02);
part_type_life(global.pt_shrapnels_big, 50, 100);
part_type_gravity(global.pt_shrapnels_big, 0.03, -90);
ds_stack_push(global.air_pt_list, global.pt_shrapnels_big);


// Sparkles (lights sparkles in explosions)
global.pt_light_ray = part_type_create();
part_type_sprite(global.pt_light_ray, spr_light_ray, true, true, false);
part_type_speed(global.pt_light_ray, 0.8, 5, -0.1, 0);
part_type_direction(global.pt_light_ray, 0, 360, 0, 0);
part_type_orientation(global.pt_light_ray, 0, 0, 0, 0, true);
part_type_life(global.pt_light_ray, 20, 30);
ds_stack_push(global.light_pt_list, global.pt_light_ray);

// Big bullets particles
global.pt_big_bullets = part_type_create();
part_type_sprite(global.pt_big_bullets, spr_bigbulleparticles, true, true, false);
part_type_speed(global.pt_big_bullets, 0.8, 3, -0.1, 0);
part_type_direction(global.pt_big_bullets, 0, 360, 0, 0);
part_type_life(global.pt_big_bullets, 16, 24);
ds_stack_push(global.light_pt_list, global.pt_big_bullets);
