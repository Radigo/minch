// Room 1-1 custom startup script

show_debug_message("Starting room 1-1");

show_debug_message("Assigning paths...");

path_assign(obj_copter_drone, path_rm11_1);
obj_copter_drone.path_position = 0.5;

path_start(path_rm11_1, 1, 1, true);

show_debug_message("Create enemy generators...");
