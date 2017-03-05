/** Manage colors for combos, switchs... */

var str_in = argument0;

switch (str_in)
{
    case "cy":
        return 1;
    case "ma":
        return 2;
    case "ye":
        return 4;
    case "pu":
        return 3;
    case "gr":
        return 5;
    case "or":
        return 6;
    case "br":
        return 7;
    default:
        return 0;
}
