var minch_obj = argument0;

var jump_distance = minch_obj.markerDistance * (minch_obj.jumpTicker / minch_obj.jumpDuration);

minch_obj.x = minch_obj.jumpStartingPosX + cos(minch_obj.legsAngle) * jump_distance;
minch_obj.y = minch_obj.jumpStartingPosY + sin(minch_obj.legsAngle) * jump_distance;

minch_obj.y -= sin(pi * (minch_obj.jumpTicker / minch_obj.jumpDuration)) * 10;
