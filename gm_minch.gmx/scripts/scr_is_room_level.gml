var roomStr = argument0;
var hasBeenUnlocked = argument1;

switch (roomStr) {
    case "rm_init":
    case "rm_title":
    case "rm_title_start":
    case "rm_intro":
    case "rm_ending":
        return false;
}

if (hasBeenUnlocked) {
    var currentMapIndex = ds_list_find_index(global.orderedLevelNames, roomStr);
    var lastMapIndex = ds_list_find_index(global.orderedLevelNames, global.lastMapName);
    return currentMapIndex <= lastMapIndex;
}

return true;
