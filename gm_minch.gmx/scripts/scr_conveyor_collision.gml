/*
show_debug_message("scr_conveyor_collision");
show_debug_message(self.conveyDirection);

*/

var conveyor_speed = 1;

switch (self.conveyDirection)
{
    case "up":
        //obj_minch.y -= conveyor_speed;
        obj_minch.conveyorMoveY = -conveyor_speed;
        break;
    case "down":
        //obj_minch.y += conveyor_speed;
        obj_minch.conveyorMoveY = conveyor_speed;
        break;
    case "left":
        //obj_minch.x -= conveyor_speed;
        obj_minch.conveyorMoveX = -conveyor_speed;
        break;
    case "right":
        //obj_minch.x += conveyor_speed;
        obj_minch.conveyorMoveX = conveyor_speed;
        break;
    case "up_left":
        if (obj_minch.y > self.y + 16)
        {
            obj_minch.conveyorMoveY = -conveyor_speed;
        }
        else
        {
            obj_minch.conveyorMoveX = -conveyor_speed;
        }
        break;
    case "up_right":
        if (obj_minch.y > self.y + 16)
        {
            obj_minch.conveyorMoveY = -conveyor_speed;
        }
        else
        {
            obj_minch.conveyorMoveX = conveyor_speed;
        }
        break;
    case "down_left":
        if (obj_minch.y < self.y + 16)
        {
            obj_minch.conveyorMoveY = conveyor_speed;
        }
        else
        {
            obj_minch.conveyorMoveX = -conveyor_speed;
        }
        break;
    case "down_right":
        if (obj_minch.y < self.y + 16)
        {
            obj_minch.conveyorMoveY = conveyor_speed;
        }
        else
        {
            obj_minch.conveyorMoveX = conveyor_speed;
        }
        break;
    case "left_up":
        if (obj_minch.x > self.x + 16)
        {
            obj_minch.conveyorMoveX = -conveyor_speed;
        }
        else
        {
            obj_minch.conveyorMoveY = -conveyor_speed;
        }
        break;
    case "left_down":
        if (obj_minch.x > self.x + 16)
        {
            obj_minch.conveyorMoveX = -conveyor_speed;
        }
        else
        {
            obj_minch.conveyorMoveY = conveyor_speed;
        }
        break;
    case "right_up":
        if (obj_minch.x < self.x + 16)
        {
            obj_minch.conveyorMoveX = conveyor_speed;
        }
        else
        {
            obj_minch.conveyorMoveY = -conveyor_speed;
        }
        break;
    case "right_down":
        if (obj_minch.x < self.x + 16)
        {
            obj_minch.conveyorMoveX = conveyor_speed;
        }
        else
        {
            obj_minch.conveyorMoveY = conveyor_speed;
        }
        break;
}
