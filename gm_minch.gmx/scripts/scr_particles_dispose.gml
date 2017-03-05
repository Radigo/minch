// Particles displayed under sprites
if (part_system_exists(global.ps_ground))
{
    part_system_destroy(global.ps_ground);
}
// Particles displayed over sprites
if (part_system_exists(global.ps_air))
{
    part_system_destroy(global.ps_air);
}
// Particles displayed over shades
if (part_system_exists(global.ps_light))
{
    part_system_destroy(global.ps_light);
}



// Ground particles
while (!ds_stack_empty(global.ground_pt_list))
{
    var disposed_pt = ds_stack_pop(global.ground_pt_list);
    part_type_destroy(disposed_pt);
}

// Air particles
while (!ds_stack_empty(global.air_pt_list))
{
    var disposed_pt = ds_stack_pop(global.air_pt_list);
    part_type_destroy(disposed_pt);
}


// Light particles
while (!ds_stack_empty(global.light_pt_list))
{
    var disposed_pt = ds_stack_pop(global.light_pt_list);
    part_type_destroy(disposed_pt);
}
