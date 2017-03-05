/** Returns real sprite instances from sprite names
 * Will definitely be changed when a decent sprites management is done */

var spr_label = argument0;
var minch = argument1;

switch (spr_label)
{
    case "spr_minch_E":
        minch.sprite_index = spr_minch;
        minch.image_index = 0;
        break;
    case "spr_minch_SE":
        minch.sprite_index = spr_minch;
        minch.image_index = 1;
        break;
    case "spr_minch_S":
        minch.sprite_index = spr_minch;
        minch.image_index = 2;
        break;
    case "spr_minch_SW":
        minch.sprite_index = spr_minch;
        minch.image_index = 3;
        break;
    case "spr_minch_W":
        minch.sprite_index = spr_minch;
        minch.image_index = 4;
        break;
    case "spr_minch_NW":
        minch.sprite_index = spr_minch;
        minch.image_index = 5;
        break;
    case "spr_minch_N":
        minch.sprite_index = spr_minch;
        minch.image_index = 6;
        break;
    case "spr_minch_NE":
        minch.sprite_index = spr_minch;
        minch.image_index = 7;
        break;
        
    case "spr_minch_E_claw":
        minch.sprite_index = spr_minch_claw;
        minch.image_index = 0;
        break;
    case "spr_minch_SE_claw":
        minch.sprite_index = spr_minch_claw;
        minch.image_index = 1;
        break;
    case "spr_minch_S_claw":
        minch.sprite_index = spr_minch_claw;
        minch.image_index = 2;
        break;
    case "spr_minch_SW_claw":
        minch.sprite_index = spr_minch_claw;
        minch.image_index = 3;
        break;
    case "spr_minch_W_claw":
        minch.sprite_index = spr_minch_claw;
        minch.image_index = 4;
        break;
    case "spr_minch_NW_claw":
        minch.sprite_index = spr_minch_claw;
        minch.image_index = 5;
        break;
    case "spr_minch_N_claw":
        minch.sprite_index = spr_minch_claw;
        minch.image_index = 6;
        break;
    case "spr_minch_NE_claw":
        minch.sprite_index = spr_minch_claw;
        minch.image_index = 7;
        break;
}

minch.image_speed = 0;
