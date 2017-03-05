// Handle ennemy life and death

var damage = argument0;

show_debug_message("ennemy " + string(self.id) + ", hit by: " + string(damage) + ", hp: " + string(self.hp));

with (other) instance_destroy();

self.hp -= damage;

if (self.hp <= 0)
{
    with (self) instance_destroy();
}
