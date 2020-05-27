if (image_speed > 0) {
    if (image_index >= image_number - 1) {
        self.triggeredDoorInstance.image_alpha = 1;
    }
} else if (image_speed < 0) {
    if (image_index == 0) {
        self.triggeredDoorInstance.image_alpha = 1;
    }
}

scr_loop_kill();
