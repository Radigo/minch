self.pt_fx = part_type_create();
part_type_sprite(self.pt_fx, spr_black_particle, true, true, false);
part_type_speed(self.pt_fx, 0.1, 0.1, -0.02, 0);
part_type_life(self.pt_fx, 10, 20);
part_type_direction(self.pt_fx, 0, 360, 0, 1);
part_type_orientation(self.pt_fx, 0, 0, 0, 0, true);

self.em_fx = part_emitter_create(global.ps_ground);
part_emitter_stream(global.ps_ground, self.em_fx, self.pt_fx, 1);
