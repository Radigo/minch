var minch_obj = argument0;

var claw_distance = 12 + ((clawDuration - minch_obj.clawTime) * 1);

minch_obj.clawFX.image_angle = (180 * (-minch_obj.bodyAngle) / pi) + 90;
minch_obj.clawFX.x = minch_obj.x + cos(minch_obj.bodyAngle) * claw_distance;
minch_obj.clawFX.y = minch_obj.y + sin(minch_obj.bodyAngle) * claw_distance;
