/*
crate id: 5
crate id: 1
crate id: 7
crate id: 2
crate id: 999 <= us!
crate id: 10
crate id: 4
crate id: 3
*/

//show_debug_message("scr_conveyor_collision, direction: " + string(self.conveyDirection) + ", other: " + string(other));

var conveyor_speed = 1;
var movedInstance = other;

// Super specific code about intro crates moving left only...
if ((self.crateId == movedInstance.crateId) && (movedInstance.x <= self.x + 16)) {
    //show_debug_message("dispatching crate to: " + string(self.dispatchVSpeed));
    movedInstance.x = self.x + 16;
    if (self.dispatchVSpeed != 0) {
        movedInstance.conveyorMoveY = conveyor_speed * self.dispatchVSpeed;
    }
    
    return false;
}

scr_conveyor_collision();
