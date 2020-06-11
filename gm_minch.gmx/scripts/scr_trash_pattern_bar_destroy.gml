scr_trash_destroy();
/*
kill spawners
remove deflectors
*/

with (self.leftSpawner) {
    instance_destroy();
}

with (self.rightSpawner) {
    instance_destroy();
}

for (var i = 0; i < ds_list_size(self.topDeflectors); i++) {
    var deflector = ds_list_find_value(self.topDeflectors, i);
    scr_boom(deflector.x, deflector.y, 3, 64);
    with (deflector) instance_destroy();
}

for (var i = 0; i < ds_list_size(self.bottomDeflectors); i++) {
    var deflector = ds_list_find_value(self.bottomDeflectors, i);
    scr_boom(deflector.x, deflector.y, 3, 64);
    with (deflector) instance_destroy();
}
