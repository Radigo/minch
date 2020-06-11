var bullet = other;
var hForce = 32 / (bullet.x - self.x);

bullet.vspeed += self.vspeed * 0.1;
bullet.hspeed += hForce * 0.1;

bullet.speed = min(bullet.speed, 2);
