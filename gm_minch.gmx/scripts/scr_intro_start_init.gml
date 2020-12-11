// Inits
self.ticker = 0;


// 1st move
// FG zooms 225% moves -291:-41
// vortex zooms 200% moves -259:-65
// Core zooms 150% moves -130:-29
self.SEQUENCE_ZOOMCORE = "sequenceZoomcore";
self.zoomDuration = 120;

self.logoZoomScaleSource = obj_title.image_xscale;
self.logoZoomScaleTarget = 2.5;
self.logoZoomXSource = obj_title.x;
self.logoZoomYSource = obj_title.y;
self.logoZoomXTarget = -260;
self.logoZoomYTarget = 100;

self.fgZoomScaleSource = obj_title_fg.image_xscale;
self.fgZoomScaleTarget = 2.25;
self.fgZoomXSource = obj_title_fg.x;
self.fgZoomYSource = obj_title_fg.y;
self.fgZoomXTarget = -291;
self.fgZoomYTarget = -41;

self.vortexZoomScaleSource = obj_title_towers.image_xscale;
self.vortexZoomScaleTarget = 2;
self.vortexZoomXSource = obj_title_towers.x;
self.vortexZoomYSource = obj_title_towers.y;
self.vortexZoomXTarget = -259;
self.vortexZoomYTarget = -65;

self.coreZoomScaleSource = obj_title_bg.image_xscale;
self.coreZoomScaleTarget = 1.5;
self.coreZoomXSource = obj_title_bg.x;
self.coreZoomYSource = obj_title_bg.y;
self.coreZoomXTarget = -130;
self.coreZoomYTarget = -10;

// Kill vortex & FG

// 2nd move
// Core zooms 170% moves -214:-424
self.SEQUENCE_MOVEDOWN = "sequenceMovedown";
self.moveDuration = 180;

self.coreMoveScaleSource = self.coreZoomScaleTarget;
self.coreMoveScaleTarget = 1.75;
self.coreMoveXSource = self.coreZoomXTarget;
self.coreMoveYSource = self.coreZoomYTarget;
self.coreMoveXTarget = -120 * self.coreMoveScaleTarget;
self.coreMoveYTarget = -(400 * self.coreMoveScaleTarget) + 240;

// Fade out during 2nd move, ends when move stops
self.coreMoveYFadeStart = self.coreMoveYTarget + 300;

self.currentSequence = self.SEQUENCE_ZOOMCORE;

// Text typing (during move downsequence
self.typeStart = 120;
self.typeStep = 1;// A char every N frames
self.typeStepChars = 1;// N chars typed at once
self.message = scr_text("intro_message");

self.textX = 16;
self.textY = 16;
self.typeTicker = 0;
self.char = 0;
self.typed = "";

// Transition
self.SEQUENCE_INTRO = "sequenceIntro";
// Fade in of intro behind text lasts 80 frames
self.introFadeDuration = 80;
// Text fades after that
self.textFadeStarts = 120;
self.textFadeDuration = 30;

// Reorder depths (objects depths seems automatically managed depending on their Y)
obj_title_bg.depth = 100;
obj_title_towers.depth = 90;
obj_title_fg.depth = 80;
obj_title.depth = 0;

self.depth = -10000;
