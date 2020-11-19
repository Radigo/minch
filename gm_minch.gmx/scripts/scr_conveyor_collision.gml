//show_debug_message("scr_conveyor_collision, direction: " + string(self.conveyDirection) + ", other: " + string(other));

var conveyor_speed = 1;
var movedInstance = other;

if (instance_exists(obj_minch_feets) && (other.object_index == obj_minch_feets.object_index)) {
    movedInstance = obj_minch;
}

switch (self.conveyDirection) {
    case "up":
        movedInstance.conveyorMoveY = -conveyor_speed;
        break;
    case "down":
        movedInstance.conveyorMoveY = conveyor_speed;
        break;
    case "left":
        movedInstance.conveyorMoveX = -conveyor_speed;
        break;
    case "right":
        movedInstance.conveyorMoveX = conveyor_speed;
        break;
    case "up_left":
        if (movedInstance.y > self.y + 16) {
            movedInstance.conveyorMoveY = -conveyor_speed;
        } else {
            movedInstance.conveyorMoveX = -conveyor_speed;
        }
        break;
    case "up_right":
        if (movedInstance.y > self.y + 16) {
            movedInstance.conveyorMoveY = -conveyor_speed;
        } else {
            movedInstance.conveyorMoveX = conveyor_speed;
        }
        break;
    case "down_left":
        if (movedInstance.y < self.y + 16) {
            movedInstance.conveyorMoveY = conveyor_speed;
        } else {
            movedInstance.conveyorMoveX = -conveyor_speed;
        }
        break;
    case "down_right":
        if (movedInstance.y < self.y + 16) {
            movedInstance.conveyorMoveY = conveyor_speed;
        } else {
            movedInstance.conveyorMoveX = conveyor_speed;
        }
        break;
    case "left_up":
        if (movedInstance.x > self.x + 16) {
            movedInstance.conveyorMoveX = -conveyor_speed;
        } else {
            movedInstance.conveyorMoveY = -conveyor_speed;
        }
        break;
    case "left_down":
        if (movedInstance.x > self.x + 16) {
            movedInstance.conveyorMoveX = -conveyor_speed;
        } else {
            movedInstance.conveyorMoveY = conveyor_speed;
        }
        break;
    case "right_up":
        if (movedInstance.x < self.x + 16) {
            movedInstance.conveyorMoveX = conveyor_speed;
        } else {
            movedInstance.conveyorMoveY = -conveyor_speed;
        }
        break;
    case "right_down":
        if (movedInstance.x < self.x + 16) {
            movedInstance.conveyorMoveX = conveyor_speed;
        } else {
            movedInstance.conveyorMoveY = conveyor_speed;
        }
        break;
}
