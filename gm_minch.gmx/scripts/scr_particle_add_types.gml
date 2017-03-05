var level = room_get_name(global.currentRoom);

var system = global.PARTICLE_SYSTEM_GROUND;

switch (system_type)
{
    case global.PARTICLE_SYSTEM_GROUND:
        // Ground particles
        ds_stack_push(global.ground_pt_list, pt);
        break;
    case global.PARTICLE_SYSTEM_AIR:
        // Air particles
        ds_stack_push(global.air_pt_list, pt);
        break;
    case global.PARTICLE_SYSTEM_LIGHT:
        // Light particles
        ds_stack_push(global.light_pt_list, pt);
        break;
}
