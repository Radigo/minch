// Used for press/release type switches

var play_sound = argument0;

var isPressed = false;
var pressedSwitch = collision_rectangle(self.bbox_left, self.bbox_top, self.bbox_right, self.bbox_bottom, obj_minch_feets, false, false);

if (pressedSwitch == noone)
{
    if (self.multipleUses)
    {
        self.active = false;
    }
    
    return false;
}
else if (pressedSwitch.id > 0)
{
    isPressed = true;
}

if (isPressed)
{
    if (self.active == false)
    {
        self.active = true;
        image_index = 1;
        
        scr_switch_machine(self.action_id);
        for (i = 0; i < ds_list_size(self.actionList); i++) {
            scr_switch_machine(ds_list_find_value(self.actionList, i));
        }
        
        if (play_sound)
        {
            audio_play_sound(snd_switch, 0, false);
        }
    }
}
else
{
    self.active = false;
}
