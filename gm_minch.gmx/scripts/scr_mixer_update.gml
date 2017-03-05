// Adds a pair of "color" & "value" to the mixer list of the mix object

var mixer_object = argument0;
var value = argument1;
var color = argument2;

var mix_entry = ds_list_create();
ds_list_add(mix_entry, value);
ds_list_add(mix_entry, color);

//show_debug_message("Mixed " + string(value) + " combo valueto combo color: " + string(color));
//show_debug_message("entry 0 = " + string(ds_list_find_value(mix_entry, 0)));
//show_debug_message("entry 1 = " + string(ds_list_find_value(mix_entry, 1)));

with (mixer_object)
{
    ds_stack_push(self.mixEntries, mix_entry);
}
