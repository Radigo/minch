// Choose legs sprites from angles
var minch = argument0;

switch (global.legsStatus)
{

    case global.LEGS_IDLE:
        switch (minch.legsAngle)
        {
            case pi * 1.75:
                obj_minch_feets.sprite_index = spr_minch_feets_NE;
                break;
            case pi * 1.5:
                obj_minch_feets.sprite_index = spr_minch_feets_N;
                break;
            case pi * 1.25:
                obj_minch_feets.sprite_index = spr_minch_feets_NW;
                break;
            case pi * 1:
                obj_minch_feets.sprite_index = spr_minch_feets_W;
                break;
            case pi * 0.75:
                obj_minch_feets.sprite_index = spr_minch_feets_SW;
                break;
            case pi * 0.5:
                obj_minch_feets.sprite_index = spr_minch_feets_S;
                break;
            case pi * 0.25:
                obj_minch_feets.sprite_index = spr_minch_feets_SE;
                break;
            case 0:
            default:
                obj_minch_feets.sprite_index = spr_minch_feets_E;
                break;
        }
        
        obj_minch_feets.image_index = 0;
        break;
        
    case global.LEGS_WALK:
        switch (minch.legsAngle)
        {
            case pi * 1.75:
                obj_minch_feets.sprite_index = spr_minch_feets_NE;
                break;
            case pi * 1.5:
                obj_minch_feets.sprite_index = spr_minch_feets_N;
                break;
            case pi * 1.25:
                obj_minch_feets.sprite_index = spr_minch_feets_NW;
                break;
            case pi * 1:
                obj_minch_feets.sprite_index = spr_minch_feets_W;
                break;
            case pi * 0.75:
                obj_minch_feets.sprite_index = spr_minch_feets_SW;
                break;
            case pi * 0.5:
                obj_minch_feets.sprite_index = spr_minch_feets_S;
                break;
            case pi * 0.25:
                obj_minch_feets.sprite_index = spr_minch_feets_SE;
                break;
            case 0:
            default:
                obj_minch_feets.sprite_index = spr_minch_feets_E;
                break;
        }
        
        obj_minch_feets.image_speed = 0.1;
        break;
        
    case global.LEGS_JUMP:
        switch (minch.legsAngle)
        {
            case pi * 1.75:
                obj_minch_feets.sprite_index = spr_minch_feets_jump_NE;
                break;
            case pi * 1.5:
                obj_minch_feets.sprite_index = spr_minch_feets_jump_N;
                break;
            case pi * 1.25:
                obj_minch_feets.sprite_index = spr_minch_feets_jump_NW;
                break;
            case pi * 1:
                obj_minch_feets.sprite_index = spr_minch_feets_jump_W;
                break;
            case pi * 0.75:
                obj_minch_feets.sprite_index = spr_minch_feets_jump_SW;
                break;
            case pi * 0.5:
                obj_minch_feets.sprite_index = spr_minch_feets_jump_S;
                break;
            case pi * 0.25:
                obj_minch_feets.sprite_index = spr_minch_feets_jump_SE;
                break;
            case 0:
            default:
                obj_minch_feets.sprite_index = spr_minch_feets_jump_E;
                break;
        }
        
        obj_minch_feets.image_speed = 0.5;
        
        break;
}


obj_minch_feets.x = minch.x;
obj_minch_feets.y = minch.y;
