// Throw back bullets

if ((obj_napalm.currentPhase == obj_napalm.TWO_KATANAS) && (random(1) < 0.5)) {
    scr_bullet_shot(self.x, self.y, scr_get_moreorless(self.image_angle, 20) + 90, random_range(0.5, 2), irandom_range(2, 3));
} else if (obj_napalm.currentPhase == obj_napalm.FOUR_KATANAS) {
    scr_bullet_shot(self.x, self.y, scr_get_moreorless(self.image_angle, 30) + 90, random_range(1, 2.5), irandom_range(1, 3));
}

scr_shot_sparkles(true, other, false);
with (other)
     instance_destroy();
