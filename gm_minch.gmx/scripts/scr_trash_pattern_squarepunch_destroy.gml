scr_trash_destroy();

for (var i = 0; i < ds_list_size(self.spawnerList); i++) {
    var spawner = ds_list_find_value(self.spawnerList, i);
    instance_destroy(spawner);
}
