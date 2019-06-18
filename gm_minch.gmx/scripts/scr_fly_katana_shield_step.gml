// Reach for midpoint between self and minch

var napalmX = argument0;
var napalmY = argument1;
var katanaPrevX = argument2;
var katanaPrevY = argument3;
var shieldAngle = argument4;
var distance = argument5;
var ease = argument6;// 0: loose, 1: sharp

var targetPosX = dcos(shieldAngle) * distance;
var targetPosY = dsin(shieldAngle) * distance;

var newX = napalmX + targetPosX;
var newY = napalmY - targetPosY;

obj_katana_shield.x = katanaPrevX + ((newX - katanaPrevX) * ease);
obj_katana_shield.y = katanaPrevY + ((newY - katanaPrevY) * ease);
obj_katana_shield.image_angle = shieldAngle - 90;
