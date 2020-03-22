if (image_speed > 0)
{
    show_debug_message(string(image_index) + "/" + string(image_number));
    if (image_index >= image_number - 1)
    {
        image_index = image_number - 3;
    }
}

draw_self();
