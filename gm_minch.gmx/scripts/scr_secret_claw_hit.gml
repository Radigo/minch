// When we hit a secret area with the claw

// Hack to pretend it's an enemy...
self.explosionSize = 32;

scr_boom((self.x + 16), (self.y + 16), 3, 32);
instance_destroy();

scr_reveal_neighbor();
