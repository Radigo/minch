var minch_obj = argument0;

var max_angle = pi * 0.6;
var claw_distance = 20;
var claw_angle = minch_obj.bodyAngle + (max_angle / 2);

if (minch_obj.clawDuration > minch_obj.clawTime)
{
    claw_angle -= max_angle * ((minch_obj.clawDuration - minch_obj.clawTime) / minch_obj.clawDuration);
    claw_distance -= 2 * sin(pi * ((minch_obj.clawDuration - minch_obj.clawTime) / minch_obj.clawDuration));
}

minch_obj.clawHitbox.x = minch_obj.x + cos(claw_angle) * claw_distance;
minch_obj.clawHitbox.y = minch_obj.y + sin(claw_angle) * claw_distance;
