// Throw particles (objects with embedded sprites) in a direction
// from a source coordinate

var particle_obj = argument0;// The base object to throw
var source_x = argument1;
var source_y = argument2;
var num_particles = argument3;
var angle = argument4;// Main direction (in radian plz)
var arc = argument5;// The +/- spread angle (in radian plz)
var particle_speed = argument6;// Main particle speed
var particle_speed_range = argument7;// The +/- speed factor to apply
var init_distance = argument8;// The distance to place the particle when instanciated

var i = 0;
var particle;

for (i = 0; i < num_particles; i++)
{
    particle = instance_create(source_x, source_y, particle_obj);
    particle.speed = particle_speed;
    particle.direction = angle;
}
