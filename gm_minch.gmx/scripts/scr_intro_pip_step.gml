// PiP follow camera
self.x = view_xview[0] + self.screenX;
self.y = view_yview[0] + self.screenY;

// Fade image
if (self.fadeOut) {
    if (self.fadeValue > 0) {
        self.fadeValue -= self.fadeSpeed;
    } else {
        with (self) instance_destroy();
    }
} else {
    if (self.fadeValue < 1) {
        self.fadeValue += self.fadeSpeed;
    } else {
        self.fadeValue = 1;
    }
}

self.image_alpha = self.fadeValue;
