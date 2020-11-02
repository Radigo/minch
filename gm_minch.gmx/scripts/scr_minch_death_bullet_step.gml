// Explosion
if (self.image_index == self.image_number - 1) {
    self.image_speed = 0;
    self.image_alpha = 0
}

if (self.image_index == 1) {
    // Create parts (wait 1 frame to have received angle from death script)
    self.feet = instance_create(self.x, self.y, obj_minch_death_part);
    feet.sprite_index = spr_death_feets;
    
    self.backpack = instance_create(self.x, self.y, obj_minch_death_part);
    backpack.sprite_index = spr_death_backpack;
    
    self.l_arm = instance_create(self.x, self.y, obj_minch_death_part);
    l_arm.sprite_index = spr_death_l_arm;
    
    self.r_arm = instance_create(self.x, self.y, obj_minch_death_part);
    r_arm.sprite_index = spr_death_r_arm;
    
    self.head = instance_create(self.x, self.y, obj_minch_death_part);
    head.sprite_index = spr_death_head;
    
    ds_list_add(self.parts, self.feet, self.backpack, self.l_arm, self.r_arm, self.head);
    
    if (self.shotSpeed < 0) {
        ds_list_add(self.partsDirection, random(pi * 2), random(pi * 2), random(pi * 2), random(pi * 2), random(pi * 2));
    } else {
        var angle = (self.shotAngle * pi / 180);
        var maxTheoriticalBulletSpeed = 4;// Max will have the smallest range
        var speedRatio = (self.shotSpeed / maxTheoriticalBulletSpeed);
        var range = (1 - clamp(speedRatio, 0, 1)) * pi;
        
        ds_list_add(self.partsDirection, scr_get_moreorless(angle, range), scr_get_moreorless(angle, range), scr_get_moreorless(angle, range), scr_get_moreorless(angle, range), scr_get_moreorless(angle, range));
    }
}

// Parts
if (ds_list_empty(self.partsDuration)) {
    with (self) instance_destroy();
    return false;
}

for (var partIndex = 0; partIndex < ds_list_size(self.parts); partIndex++) {
    var part = ds_list_find_value(self.parts, partIndex);
    var partDirection = ds_list_find_value(self.partsDirection, partIndex);
    var partDistance = ds_list_find_value(self.partsDistance, partIndex);
    var partTicker = ds_list_find_value(self.partsTicker, partIndex);
    var partDuration = ds_list_find_value(self.partsDuration, partIndex);
    
    var partX = self.x + cos(partDirection) * ((partTicker / partDuration) * partDistance);
    var partY = self.y - sin(partDirection) * ((partTicker / partDuration) * partDistance);
    // Gravity
    partY -= sin((partTicker / partDuration) * pi) * 16;
    
    part.x = partX;
    part.y = partY;
    // Spiraling part
    var angleIncr = 15;
    if ((partDuration % 2) == 0) {
        angleIncr = -15;
    }
    part.image_angle += (1 - (partTicker / partDuration)) * angleIncr;
    
    partTicker++;
    
    if (partTicker < partDuration) {
        ds_list_replace(self.partsTicker, partIndex, partTicker);
    } else {
        ds_list_delete(self.parts, partIndex);
        ds_list_delete(self.partsDirection, partIndex);
        ds_list_delete(self.partsDistance, partIndex);
        ds_list_delete(self.partsTicker, partIndex);
        ds_list_delete(self.partsDuration, partIndex);
        
        with (part) instance_destroy();
    }
}
