// For objects
// Kills sprites after 1 loop

if (image_speed > 0) {
    if (image_index >= image_number - 1) {
        instance_destroy();
    }
} else if (image_speed < 0) {
    if (image_index == 0) {
        instance_destroy();
    }
}
