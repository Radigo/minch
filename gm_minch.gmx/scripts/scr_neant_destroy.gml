// Instanciate neant death
instance_create(self.x, self.y, obj_neant_death);

//just in case, kill everybody and cancel all bullets
// All cannons explode
while (instance_number(obj_cannon_a) > 0) {
    instance_destroy(instance_find(obj_cannon_a, 0));
}
while (instance_number(obj_cannon_b) > 0) {
    instance_destroy(instance_find(obj_cannon_b, 0));
}
while (instance_number(obj_cannon_c) > 0) {
    instance_destroy(instance_find(obj_cannon_c, 0));
}
// All rocks explode
while (instance_number(obj_neant_rock) > 0) {
    instance_destroy(instance_find(obj_neant_rock, 0));
}

scr_all_bullet_cancel();

// Extra FX
part_type_speed(self.pt_fx, 0.1, 5, -0.05, 0);
part_type_life(self.pt_fx, 20, 80);
part_type_gravity(self.pt_fx, 0, -90);
part_type_direction(self.pt_fx, 0, 360, 0, 1);
part_emitter_burst(global.ps_ground, self.em_fx, self.pt_fx, 200);
// Stop particles stream
part_emitter_destroy(global.ps_ground, self.em_fx);
