// Set a full list of all paths in the game

var path_map = argument0;

var path, path_name;


if (!ds_map_exists(path_map, path_name))
{
    ds_map_add(path_map, path_name, path);
}
