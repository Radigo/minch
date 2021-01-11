if (instance_number(obj_mutant_raid) > 40)
{
    instance_destroy(instance_furthest(obj_mutantaid_spawner.x, obj_mutantaid_spawner.y, obj_mutant_raid));
}

mutantraid_instance = instance_create((obj_mutantaid_spawner.x - 64 + random(128)), (obj_mutantaid_spawner.y - 64 + random(128)), obj_mutant_raid);
with (mutantraid_instance)
{
    image_speed = 0.3;
    move_towards_point(x - 400 - 64 + random(128), y + 400 - 64 + random(128), random(2) + 3);
}
