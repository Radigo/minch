scr_trash_destroy();

while (instance_number(obj_trash_bigball) > 0) {
    var deflector = instance_find(obj_trash_bigball, 0);
    instance_destroy(deflector);
}
