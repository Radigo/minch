
//show_debug_message("ticker: " + string(self.ticker) + " > " + string(self.tickerLimit) + ", self.isIntro: " + string(self.isIntro) + ", move: " + self.move + " / patternTicker: " + string(self.patternTicker) + " > " + string(self.patternTickerLimit) + ", pattern: " + self.pattern);

// Calm before the storm
if (self.isIntro) {
   if (self.ticker > self.tickerLimit) {
      self.move = self.MOVE_RAGING;
      self.pattern = self.PATTERN_RAGING;
      self.ticker = 0;
      self.patternTicker = 0;
      self.isIntro = false;
   }
   
   return false;
}

// Rage on
if (self.move == self.MOVE_RAGING) {
    // Just wait
    if (self.ticker == 1) {
        self.sprite_index = spr_ch1_legs_idle;
        self.tickerLimit = 90;
    }
    
    if (self.ticker > self.tickerLimit) {
        self.move = self.MOVE_STATIC;
    }
} else if (self.move == self.MOVE_STATIC) {
    // Just wait
    if (self.ticker == 1) {
        self.sprite_index = spr_ch1_legs_idle;
        self.tickerLimit = 90;
    }
    
    if (self.ticker > self.tickerLimit) {
        if (self.pattern == self.PATTERN_IDLE) {
            // Jumps only if no pattern is ON
            // Will evolve very soon...
            self.move = self.MOVE_JUMPING;
        }
    }
} else if (self.move == self.MOVE_JUMPING) {
    // Jumps up or down
    if (self.ticker == 1) {
        // TODO: If MinCH is behind, stomp him. Hard
        self.jumpSourceX = self.x;
        self.jumpSourceY = self.y;
        self.jumpTargetX = self.x + 4;
        self.jumpTargetY = self.jumpTargetYMin + random(self.jumpTargetYMax - self.jumpTargetYMin);
        
        if (self.jumpTargetY < self.jumpSourceY) {
            self.sprite_index = spr_ch1_legs_jumpup;
        } else {
            self.sprite_index = spr_ch1_legs_jumpdown;
        }
        self.tickerLimit = 30;
    }
    
    self.x = self.jumpSourceX + (self.ticker / self.tickerLimit) * (self.jumpTargetX - self.jumpSourceX);
    self.y = self.jumpSourceY + (self.ticker / self.tickerLimit) * (self.jumpTargetY - self.jumpSourceY);
    
    if (self.ticker > self.tickerLimit) {
        self.move = self.MOVE_STATIC;
    }
}

if (self.pattern == self.PATTERN_RAGING) {
    if (self.patternTicker == 1) {
        self.body.sprite_index = spr_ch1_body_spread;
        self.patternTickerLimit = 90;
    }
} else if (self.pattern == self.PATTERN_IDLE) {
    if (self.patternTicker == 1) {
        self.body.sprite_index = spr_ch1_body_idle;
        self.patternTickerLimit = 60;
    }
} else if (self.pattern == self.PATTERN_LASERUP) {
    if (self.patternTicker == 1) {
        self.body.sprite_index = spr_ch1_body_laserup;
        self.patternTickerLimit = 60;
    }
} else if (self.pattern == self.PATTERN_LASERDOWN) {
    if (self.patternTicker == 1) {
        self.body.sprite_index = spr_ch1_body_laserdown;
        self.patternTickerLimit = 60;
    }
} else if (self.pattern == self.PATTERN_LASERTWIN) {
    if (self.patternTicker == 1) {
        self.body.sprite_index = spr_ch1_body_lasertwin;
        self.patternTickerLimit = 120;
    }
} else if (self.pattern == self.PATTERN_SPREADUP) {
    if (self.patternTicker == 1) {
        self.body.sprite_index = spr_ch1_body_spreadup;
        self.patternTickerLimit = 90;
    }
} else if (self.pattern == self.PATTERN_SPREADDOWN) {
    if (self.patternTicker == 1) {
        self.body.sprite_index = spr_ch1_body_spreaddown;
        self.patternTickerLimit = 90;
    }
} else if (self.pattern == self.PATTERN_SPREADTWIN) {
    if (self.patternTicker == 1) {
        self.body.sprite_index = spr_ch1_body_spreadtwin;
        self.patternTickerLimit = 180;
    }
} else if (self.pattern == self.PATTERN_SPREADSHOULDER) {
    if (self.patternTicker == 1) {
        self.body.sprite_index = spr_ch1_body_spread;
        self.patternTickerLimit = 500;
    }
}

// SCript will choose what comes next and reset ticker
scr_ch1_setnextpattern();


// Move body with legs
self.body.x = self.x + self.bodyRelativePositionX;
self.body.y = self.y + self.bodyRelativePositionY;
