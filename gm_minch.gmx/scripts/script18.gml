// Handle ennemy life and death

var damage = argument0;

self.hp -= damage;

if (damage <= 0)
{
    self.instance_destroy();
}
