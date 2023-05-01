scr_ai_step();

if (!self.isActive && (distance_to_object(obj_minch) < self.targetLossDistance))
{
    self.isActive = true;
}

if (!self.isActive)
{
    return false;
}

self.prevAimAngle = self.aimAngle;

//show_debug_message("scr_turret_step " + string(self) + " patternmode: " + string(self.patternMode));

switch (self.patternMode)
{
    case self.PATTERN_MODE_FREE:
        scr_turret_step_free();
        break;
    case self.PATTERN_MODE_FIXED:
        scr_turret_step_fixed();
        break;
}
