var debugPatterns = false;
if (self.patternTicker < self.patternTickerLimit) {
    return false;
}

if (self.hp < self.killSequenceHp) {
    self.isKillSequence = true;
    self.ticker = 0;
    self.patternTicker = 0;
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

self.patternTicker = 0;
