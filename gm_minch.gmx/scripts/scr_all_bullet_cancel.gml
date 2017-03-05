// Replace all bullets by a cancel sprite

while (instance_number(obj_bullet) > 0)
{
    var bullet = instance_find(obj_bullet, 0);
    with (bullet) scr_bullet_cancel();
}
