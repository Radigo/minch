scr_trash_destroy();

for (var i = 0; i < ds_list_size(self.spawnerLeft); i++) {
    var spawner = ds_list_find_value(self.spawnerLeft, i);
    instance_destroy(spawner);
}

for (var i = 0; i < ds_list_size(self.spawnerRight); i++) {
    var spawner = ds_list_find_value(self.spawnerRight, i);
    instance_destroy(spawner);
}
