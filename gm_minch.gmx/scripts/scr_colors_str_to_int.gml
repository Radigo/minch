/** Manage colors for combos, switchs... */

var str_in = argument0;

switch (str_in)
{
    case "cy":
        return global.CY;
    case "ma":
        return global.MA;
    case "ye":
        return global.YE;
    case "pu":
        return global.PU;
    case "gr":
        return global.GR;
    case "or":
        return global.RG;
    case "br":
        return global.BR;
    case "bk":
        return global.BK;
    default:
        return 0;
}
