var debugPatterns = true;
if (self.patternTicker < self.patternTickerLimit) {
    return false;
}

if (self.hp < self.killSequenceHp) {
    self.isKillSequence = true;
    self.ticker = 0;
    self.patternTicker = 0;
    self.tickerLimit = 300;
    self.patternTickerLimit = 300;
    return false;
}

var staticPatterns = ds_map_create();

if (self.pattern == self.PATTERN_RAGING) {
// Always start with a gooodole lazertwin
    self.pattern = self.PATTERN_LASERTWIN;
} else {
    var randPatternIndex = irandom(ds_list_size(self.staticPatternsList) - 1);
    if (debugPatterns) show_debug_message("randPatternIndex: " + string(randPatternIndex));
    self.pattern = self.staticPatternsList[| randPatternIndex];
}

self.staticPatternIndex++;
if (debugPatterns) show_debug_message("Pattern count: " + string(self.staticPatternIndex) + "/" + string(self.staticPatternCount));
if (self.staticPatternIndex == self.staticPatternCount) {
    self.staticPatternIndex = 0;
    self.pattern = self.PATTERN_IDLE;
    self.cycleIndex++;
    if (debugPatterns) show_debug_message("Pattern cycle done: " + string(self.cycleIndex) + "/" + string(self.cycleCount));
    if (self.cycleIndex == self.cycleCount) {
        if (debugPatterns) show_debug_message("All pattern cycles dones");
        self.cycleIndex = 0;
    }
}

if (debugPatterns) show_debug_message("Next pattern is: " + self.pattern);

if (self.pattern == self.PATTERN_SPREADSHOULDER) {
    self.spreadSoulderIndex++;
    if (debugPatterns) show_debug_message("Incrementing spread shoulder count " + string(self.spreadSoulderIndex));
    if (self.spreadSoulderIndex > self.SPREAD_SHOULDER_COUNT) {
        // Remove from base list (spread shoulder is last
        ds_list_delete(self.staticPatternsList, ds_list_size(self.staticPatternsList) - 1);
        if (debugPatterns) show_debug_message("Spread soulder count reached, remove from list");
    }
}

self.patternTicker = 0;
