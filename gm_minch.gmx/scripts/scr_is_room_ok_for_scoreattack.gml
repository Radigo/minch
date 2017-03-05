// Is room before globals.lastMap

var room_str = argument0;

var i, room_index, lastroom_index;

room_index = global.NUM_LEVELS;

for (i = 0; i < global.NUM_LEVELS; i++)
{
    if (room_exists(i))
    {
        if (room_get_name(i) == room_str)
        {
            room_index = i;
        }
        
        if (room_get_name(i) == global.lastMap)
        {
            lastroom_index = i;
            
            if (lastroom_index >= room_index)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
    }
}

return false;
