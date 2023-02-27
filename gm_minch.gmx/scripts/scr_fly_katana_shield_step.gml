// Reach for midpoint between self and minch

if (!instance_exists(obj_katana_shield)) {
    return false;
}

var napalmX = argument0;
var napalmY = argument1;
var shieldAngle = argument2;
var distance = argument3;
var ease = argument4;// 0: loose, 1: sharp

var katanaPrevX = obj_katana_shield.x;
var katanaPrevY = obj_katana_shield.y;

var targetPosX = dcos(shieldAngle) * distance;
var targetPosY = dsin(shieldAngle) * distance;

var newX = napalmX + targetPosX;
var newY = napalmY - targetPosY;

obj_katana_shield.x = katanaPrevX + ((newX - katanaPrevX) * ease);
obj_katana_shield.y = katanaPrevY + ((newY - katanaPrevY) * ease);
obj_katana_shield.image_angle = shieldAngle - 90;
