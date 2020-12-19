var requiredControl = argument0;

if (global.control_type < 0) {
    switch (requiredControl) {
        case global.UP:
            return global.key_up;
        case global.DOWN:
            return global.key_down;
        case global.LEFT:
            return global.key_left;
        case global.RIGHT:
            return global.key_right;
        case global.A:
            return global.key_a;
        case global.B:
            return global.key_b;
        case global.START:
            return global.key_start;
    }
} else {
    switch (requiredControl) {
        case global.UP:
            return global.pad_up;
        case global.DOWN:
            return global.pad_down;
        case global.LEFT:
            return global.pad_left;
        case global.RIGHT:
            return global.pad_right;
        case global.A:
            return global.pad_a;
        case global.B:
            return global.pad_b;
        case global.START:
            return global.pad_start;
    }
}

return false;
