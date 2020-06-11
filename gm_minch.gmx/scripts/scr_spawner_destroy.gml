// Extra FX
part_type_speed(self.pt_fx, 0.1, 2, -0.05, 0);
part_type_life(self.pt_fx, 20, 60);
part_type_gravity(self.pt_fx, 0, -90);
part_type_direction(self.pt_fx, 0, 360, 0, 1);
part_emitter_burst(global.ps_ground, self.em_fx, self.pt_fx, 40);
// Stop particles stream
part_emitter_destroy(global.ps_ground, self.em_fx);
