if (self.hp < self.PHASE_SUN_HP) {
    self.ticker = 0;
    self.currentPhase = self.PHASE_ROCKS_SUN;
    
    self.orbitCenterX = (self.ROOM_LEFT + self.ROOM_RIGHT) * 0.5;
    self.orbitCenterY = (self.ROOM_TOP + self.ROOM_BOTTOM) * 0.5;
    
    self.sprite_index = spr_neant_flying;
} else {
    if ((self.currentPhase == self.PHASE_THRONE_STANDING) || (self.currentPhase == self.PHASE_ROCKS_TRACES)) {
        self.ticker = 0;
        self.currentPhase = self.PHASE_ROCKS_EXPLODING;
        
        self.orbitCenterX = (self.ROOM_LEFT + self.ROOM_RIGHT) * 0.5;
        self.orbitCenterY = (self.ROOM_TOP + self.ROOM_BOTTOM) * 0.5;
        
        self.sprite_index = spr_neant_flying;
    } else if (self.currentPhase == self.PHASE_ROCKS_EXPLODING) {
        self.ticker = 0;
        self.currentPhase = self.PHASE_ROCKS_TRACES;
        
        self.orbitCenterX = self.x;
        self.orbitCenterY = min(self.y, ((self.ROOM_TOP + self.ROOM_BOTTOM) * 0.5) - 128);
        
        self.sprite_index = spr_neant_flying;
    }
}
