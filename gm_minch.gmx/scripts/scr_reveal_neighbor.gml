var distance = 32;
var center_offset = 16;
var test_x, test_y, collision_result;

// Test up
test_x = self.x + center_offset;
test_y = self.y + center_offset - distance;
with (collision_point(test_x, test_y, obj_reveal_dark, false, true))
{
    show_debug_message(self);
    instance_change(obj_reveal_dark_anim, true);
}

// Test down
test_x = self.x + center_offset;
test_y = self.y + center_offset + distance;
with (collision_point(test_x, test_y, obj_reveal_dark, false, true))
{
    show_debug_message(self);
    instance_change(obj_reveal_dark_anim, true);
}

// Test left
test_x = self.x + center_offset - distance;
test_y = self.y + center_offset;
with (collision_point(test_x, test_y, obj_reveal_dark, false, true))
{
    show_debug_message(self);
    instance_change(obj_reveal_dark_anim, true);
}

// Test right
test_x = self.x + center_offset + distance;
test_y = self.y + center_offset;
with (collision_point(test_x, test_y, obj_reveal_dark, false, true))
{
    show_debug_message(self);
    instance_change(obj_reveal_dark_anim, true);
}
