if (self.patternTicker < self.patternTickerLimit) {
    return false;
}

var staticPatterns = ds_map_create();

if (self.pattern == self.PATTERN_RAGING) {
    self.pattern = self.PATTERN_LASERTWIN;
} else {
    self.pattern = self.staticPatternsList[| irandom(ds_list_size(self.staticPatternsList))];
}

self.staticPatternIndex++;
show_debug_message("Pattern count: " + string(self.staticPatternIndex) + "/" + string(self.staticPatternCount));
if (self.staticPatternIndex == self.staticPatternCount) {
    self.staticPatternIndex = 0;
    self.pattern = self.PATTERN_IDLE;
    self.cycleIndex++;
    show_debug_message("Pattern cycle done: " + string(self.cycleIndex) + "/" + string(self.cycleCount));
    if (self.cycleIndex == self.cycleCount) {
        show_debug_message("All pattern cycles dones");
        self.cycleIndex = 0;
    }
}

show_debug_message("Next pattern is: " + self.pattern);

self.patternTicker = 0;
