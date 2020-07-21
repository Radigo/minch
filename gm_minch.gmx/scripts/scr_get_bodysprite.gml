/** Returns real sprite instances from sprite names */

var minch = argument0;

minch.shotFX.visible = false;

switch (global.bodyStatus)
{
    
    case global.BODY_CLAW: // Claw attack
        if (minch.bodyAngle <= (pi * 1.875)
            && minch.bodyAngle >= (pi * 1.625))
        {
            minch.sprite_index = spr_minch_body_claw_NE;
        }
        else if (minch.bodyAngle <= (pi * 1.625)
            && minch.bodyAngle >= (pi * 1.375))
        {
            minch.sprite_index = spr_minch_body_claw_N;
        }
        else if (minch.bodyAngle <= (pi * 1.375)
            && minch.bodyAngle >= (pi * 1.125))
        {
            minch.sprite_index = spr_minch_body_claw_NW;
        }
        else if (minch.bodyAngle <= (pi * 1.125)
            && minch.bodyAngle >= (pi * 0.875))
        {
            minch.sprite_index = spr_minch_body_claw_W;
        }
        else if (minch.bodyAngle <= (pi * 0.875)
            && minch.bodyAngle >= (pi * 0.625))
        {
            minch.sprite_index = spr_minch_body_claw_SW;
        }
        else if (minch.bodyAngle <= (pi * 0.625)
            && minch.bodyAngle >= (pi * 0.375))
        {
            minch.sprite_index = spr_minch_body_claw_S;
        }
        else if (minch.bodyAngle <= (pi * 0.375)
            && minch.bodyAngle >= (pi * 0.125))
        {
            minch.sprite_index = spr_minch_body_claw_SE;
        }
        else
        {
            minch.sprite_index = spr_minch_body_claw_E;
        }
        break;
    
    case global.BODY_HOLD: // Holding objects
        if (minch.bodyAngle <= (pi * 1.875)
            && minch.bodyAngle >= (pi * 1.625))
        {
            minch.sprite_index = spr_minch_body_claw_NE;
        }
        else if (minch.bodyAngle <= (pi * 1.625)
            && minch.bodyAngle >= (pi * 1.375))
        {
            minch.sprite_index = spr_minch_body_claw_N;
        }
        else if (minch.bodyAngle <= (pi * 1.375)
            && minch.bodyAngle >= (pi * 1.125))
        {
            minch.sprite_index = spr_minch_body_claw_NW;
        }
        else if (minch.bodyAngle <= (pi * 1.125)
            && minch.bodyAngle >= (pi * 0.875))
        {
            minch.sprite_index = spr_minch_body_claw_W;
        }
        else if (minch.bodyAngle <= (pi * 0.875)
            && minch.bodyAngle >= (pi * 0.625))
        {
            minch.sprite_index = spr_minch_body_claw_SW;
        }
        else if (minch.bodyAngle <= (pi * 0.625)
            && minch.bodyAngle >= (pi * 0.375))
        {
            minch.sprite_index = spr_minch_body_claw_S;
        }
        else if (minch.bodyAngle <= (pi * 0.375)
            && minch.bodyAngle >= (pi * 0.125))
        {
            minch.sprite_index = spr_minch_body_claw_SE;
        }
        else
        {
            minch.sprite_index = spr_minch_body_claw_E;
        }
        break;
    
    case global.BODY_AIM: // Aimed shot towards the fixed target
        if (minch.bodyAngle <= (pi * 1.875)
            && minch.bodyAngle >= (pi * 1.625))
        {
            minch.sprite_index = spr_minch_body_aim_NE;
        }
        else if (minch.bodyAngle <= (pi * 1.625)
            && minch.bodyAngle >= (pi * 1.375))
        {
            minch.sprite_index = spr_minch_body_aim_N;
        }
        else if (minch.bodyAngle <= (pi * 1.375)
            && minch.bodyAngle >= (pi * 1.125))
        {
            minch.sprite_index = spr_minch_body_aim_NW;
        }
        else if (minch.bodyAngle <= (pi * 1.125)
            && minch.bodyAngle >= (pi * 0.875))
        {
            minch.sprite_index = spr_minch_body_aim_W;
        }
        else if (minch.bodyAngle <= (pi * 0.875)
            && minch.bodyAngle >= (pi * 0.625))
        {
            minch.sprite_index = spr_minch_body_aim_SW;
        }
        else if (minch.bodyAngle <= (pi * 0.625)
            && minch.bodyAngle >= (pi * 0.375))
        {
            minch.sprite_index = spr_minch_body_aim_S;
        }
        else if (minch.bodyAngle <= (pi * 0.375)
            && minch.bodyAngle >= (pi * 0.125))
        {
            minch.sprite_index = spr_minch_body_aim_SE;
        }
        else
        {
            minch.sprite_index = spr_minch_body_aim_E;
        }
        break;
        
    case global.BODY_SHOT: // Free shot
    case global.BODY_FIXED: // Fixed shot
    case global.BODY_AIMEDSHOT: // Aimed shot
        if (minch.bodyAngle <= (pi * 1.875)
            && minch.bodyAngle >= (pi * 1.625))
        {
            minch.sprite_index = spr_minch_body_shot_NE;
        }
        else if (minch.bodyAngle <= (pi * 1.625)
            && minch.bodyAngle >= (pi * 1.375))
        {
            minch.sprite_index = spr_minch_body_shot_N;
        }
        else if (minch.bodyAngle <= (pi * 1.375)
            && minch.bodyAngle >= (pi * 1.125))
        {
            minch.sprite_index = spr_minch_body_shot_NW;
        }
        else if (minch.bodyAngle <= (pi * 1.125)
            && minch.bodyAngle >= (pi * 0.875))
        {
            minch.sprite_index = spr_minch_body_shot_W;
        }
        else if (minch.bodyAngle <= (pi * 0.875)
            && minch.bodyAngle >= (pi * 0.625))
        {
            minch.sprite_index = spr_minch_body_shot_SW;
        }
        else if (minch.bodyAngle <= (pi * 0.625)
            && minch.bodyAngle >= (pi * 0.375))
        {
            minch.sprite_index = spr_minch_body_shot_S;
        }
        else if (minch.bodyAngle <= (pi * 0.375)
            && minch.bodyAngle >= (pi * 0.125))
        {
            minch.sprite_index = spr_minch_body_shot_SE;
        }
        else
        {
            minch.sprite_index = spr_minch_body_shot_E;
        }
        
        minch.shotFX.x = minch.x + cos(minch.bodyAngle - (pi * 0.1)) * 8;
        minch.shotFX.y = minch.y + sin(minch.bodyAngle - (pi * 0.1)) * 8;
        minch.shotFX.image_angle = 180 * (-minch.bodyAngle) / pi;
        minch.shotFX.visible = true;
        break;

    case global.BODY_IDLE: // NOTHING
    default:
        if (minch.bodyAngle <= (pi * 1.875)
            && minch.bodyAngle >= (pi * 1.625))
        {
            minch.sprite_index = spr_minch_body_idle_NE;
        }
        else if (minch.bodyAngle <= (pi * 1.625)
            && minch.bodyAngle >= (pi * 1.375))
        {
            minch.sprite_index = spr_minch_body_idle_N;
        }
        else if (minch.bodyAngle <= (pi * 1.375)
            && minch.bodyAngle >= (pi * 1.125))
        {
            minch.sprite_index = spr_minch_body_idle_NW;
        }
        else if (minch.bodyAngle <= (pi * 1.125)
            && minch.bodyAngle >= (pi * 0.875))
        {
            minch.sprite_index = spr_minch_body_idle_W;
        }
        else if (minch.bodyAngle <= (pi * 0.875)
            && minch.bodyAngle >= (pi * 0.625))
        {
            minch.sprite_index = spr_minch_body_idle_SW;
        }
        else if (minch.bodyAngle <= (pi * 0.625)
            && minch.bodyAngle >= (pi * 0.375))
        {
            minch.sprite_index = spr_minch_body_idle_S;
        }
        else if (minch.bodyAngle <= (pi * 0.375)
            && minch.bodyAngle >= (pi * 0.125))
        {
            minch.sprite_index = spr_minch_body_idle_SE;
        }
        else
        {
            minch.sprite_index = spr_minch_body_idle_E;
        }
        break;
}
