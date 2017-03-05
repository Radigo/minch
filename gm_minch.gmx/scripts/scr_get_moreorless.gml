var base_value = argument0;
var range = argument1;

if (random(2) > 1)
{
    return base_value + random(range);
}
else
{
    return base_value - random(range);
}
