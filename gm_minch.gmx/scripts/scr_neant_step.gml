scr_ai_step();

if (self.currentPhase == self.PHASE_THRONE_INTRO) {
    // Sitting on throne, creating rocks, activating cannons
    self.shield = true;
    self.tickerLimit = 90;
    
    if (self.ticker == self.tickerLimit) {
        self.ticker = 0;
        self.currentPhase = self.PHASE_THRONE;
    }
    
} else if (self.currentPhase == self.PHASE_THRONE) {
    // Sitting on throne, rocks turning around
    if (self.hp < self.PHASE_ROOM_HP) {
        self.currentPhase = self.PHASE_THRONE_STANDING;
    }
} else if (self.currentPhase == self.PHASE_THRONE_STANDING) {
    // Stand up on throne, ready to jump in room
    self.shield = true;
    
} else if (self.currentPhase == self.PHASE_THRONE_TRAVEL) {
    // Flying to room center
    
} else if (self.currentPhase == self.PHASE_ROCKS_EXPLODING) {
    // Flying in room, sending rocks in straight lines
    
} else if (self.currentPhase == self.PHASE_ROCKS_TRACES) {
    // FLying in room, sending rocks with curved pathes and leaving bullets
    
} else if (self.currentPhase == self.PHASE_ROCKS_SUN) {
    // FLying in room center, rocks turning around and throwing lasers
    
} else if (self.currentPhase == self.PHASE_DEATH) {
    // Falling dead to room top
    
}
