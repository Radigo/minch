self.ticker++;

var originX = view_xview[0];
var originY = view_yview[0];

if (self.currentSequence == self.SEQUENCE_ZOOMCORE) {
    if (self.ticker < self.zoomDuration) {
        var zoomProgress = self.ticker / self.zoomDuration;
        
        var logoScale = self.logoZoomScaleSource + ((self.logoZoomScaleTarget - self.logoZoomScaleSource) * zoomProgress);
        obj_title_logo.image_xscale = logoScale;
        obj_title_logo.image_yscale = logoScale;
        obj_title_logo.x = originX + self.logoZoomXSource + ((self.logoZoomXTarget - self.logoZoomXSource) * zoomProgress);
        obj_title_logo.y = originY + self.logoZoomYSource + ((self.logoZoomYTarget - self.logoZoomYSource) * zoomProgress);
        
        var fgScale = self.fgZoomScaleSource + ((self.fgZoomScaleTarget - self.fgZoomScaleSource) * zoomProgress);
        obj_title_fg.image_xscale = fgScale;
        obj_title_fg.image_yscale = fgScale;
        obj_title_fg.x = originX + self.fgZoomXSource + ((self.fgZoomXTarget - self.fgZoomXSource) * zoomProgress);
        obj_title_fg.y = originY + self.fgZoomYSource + ((self.fgZoomYTarget - self.fgZoomYSource) * zoomProgress);
        
        var vortexScale = self.vortexZoomScaleSource + ((self.vortexZoomScaleTarget - self.vortexZoomScaleSource) * zoomProgress);
        obj_title_towers.image_xscale = vortexScale;
        obj_title_towers.image_yscale = vortexScale;
        obj_title_towers.x = originX + self.vortexZoomXSource + ((self.vortexZoomXTarget - self.vortexZoomXSource) * zoomProgress);
        obj_title_towers.y = originY + self.vortexZoomYSource + ((self.vortexZoomYTarget - self.vortexZoomYSource) * zoomProgress);
        
        var bgScale = self.coreZoomScaleSource + ((self.coreZoomScaleTarget - self.coreZoomScaleSource) * zoomProgress);
        obj_title_bg.image_xscale = bgScale;
        obj_title_bg.image_yscale = bgScale;
        obj_title_bg.x = originX + self.coreZoomXSource + ((self.coreZoomXTarget - self.coreZoomXSource) * zoomProgress);
        obj_title_bg.y = originY + self.coreZoomYSource + ((self.coreZoomYTarget - self.coreZoomYSource) * zoomProgress);
    } else {
        self.currentSequence = self.SEQUENCE_MOVEDOWN;
        self.ticker = 0;
    }
} else if (self.currentSequence == self.SEQUENCE_MOVEDOWN) {
    if (self.ticker < self.moveDuration) {
        var moveProgress = self.ticker / self.moveDuration;
        
        var bgScale = self.coreMoveScaleSource + ((self.coreMoveScaleTarget - self.coreMoveScaleSource) * moveProgress);
        obj_title_bg.image_xscale = bgScale;
        obj_title_bg.image_yscale = bgScale;
        obj_title_bg.x = originX + self.coreMoveXSource + ((self.coreMoveXTarget - self.coreMoveXSource) * moveProgress);
        obj_title_bg.y = originY + self.coreMoveYSource + ((self.coreMoveYTarget - self.coreMoveYSource) * moveProgress);
    } else {
        instance_destroy(obj_title_bg);
    }
    
    // Text
    if ((self.ticker > self.typeStart) && (string_length(self.typed) < string_length(self.message))) {
        // Fix char steps before going further
        if ((self.typeTicker % self.typeStep) == 0) {
            for (var i = 0; i < self.typeStepChars; i++) {
                self.char++;
                var newChar = string_char_at(self.message, self.char);
                if (newChar == ">") {
                    self.typeStep = 1;
                    self.typeStepChars = 2;
                } else if (newChar == "-") {
                    self.typeStep = 4;
                    self.typeStepChars = 1;
                }
                self.typed += newChar;
            }
            
            if (string_length(self.typed) >= string_length(self.message)) {
                self.currentSequence = self.SEQUENCE_INTRO;
                self.ticker = 0;
                self.typed = self.message;
                room_goto(rm_intro);
            }
        }
        
        self.typeTicker++;
    }
} else if (self.currentSequence == self.SEQUENCE_INTRO) {
    if (self.ticker > (self.textFadeStarts + self.textFadeDuration)) {
        with (self) instance_destroy();
    }
}
