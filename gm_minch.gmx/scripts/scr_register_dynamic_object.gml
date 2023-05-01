// Register object into level actions map

self.action_id = argument0;
self.action_rule = argument1;

show_debug_message("adding action id:" + string(self.action_id) + "with action_rule: " + self.action_rule);
show_debug_message("scr_register_dynamic_object > self.id:" + string(self.id));


if (ds_map_exists(global.actions_map, self.action_id))
{
    var dynamic_objects_list = ds_map_find_value(global.actions_map, self.action_id);
}
else
{
    var dynamic_objects_list = ds_list_create();
}

// Because self.id IS the actual instance of the object
ds_list_add(dynamic_objects_list, self.id);

ds_map_add_list(global.actions_map, self.action_id, dynamic_objects_list);
ds_map_add(global.rules_map, self.action_id, self.action_rule);

//show_debug_message("actions map length: " + string(ds_map_size(global.actions)));

// Custom inits by action type
switch (self.action_rule)
{
    case global.CREATE_PLATFORM:
        // Create platform always change a hole for the same sprite, we need to change empty hole by the platform sprite
        switch (self.color) {
            case global.CY:
                self.sprite_index = spr_platform_cy;
                self.visible = true;
                break;
            case global.MA:
                self.sprite_index = spr_platform_ma;
                self.visible = true;
                break;
            case global.YE:
                self.sprite_index = spr_platform_ye;
                self.visible = true;
                break;
            case global.PU:
                self.sprite_index = spr_platform_pu;
                self.visible = true;
                break;
            case global.RG:
                self.sprite_index = spr_platform_or;
                self.visible = true;
                break;
            case global.GR:
                self.sprite_index = spr_platform_gr;
                self.visible = true;
                break;
            default:
                self.sprite_index = spr_platform;
                self.image_speed = 0;
                self.visible = true;
                break;
        }
}
