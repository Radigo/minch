scr_trash_destroy();

while (instance_number(obj_spiral_deflector_canon) > 0) {
    var deflector = instance_find(obj_spiral_deflector_canon, 0);
    scr_boom(deflector.x, deflector.y, 2, 16);
    instance_destroy(deflector);
}

while (instance_number(obj_spiral_box_cy) > 0) {
    var deflector = instance_find(obj_spiral_box_cy, 0);
    scr_boom(deflector.x, deflector.y, 2, 16);
    instance_destroy(deflector);
}
