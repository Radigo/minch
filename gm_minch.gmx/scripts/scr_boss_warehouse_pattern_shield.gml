/**
First pattern of Guardian

1. With sield
    A. Moves linearly on tracks, goes back and forth when touch walls
    B. Shoot with sides only
        B1. Parallels bullets
        B2. Random shots
        B3. Aimed line shots
*/

// Movement
if ((self.shieldPatternMoveSpeed > 0)
    && collision_point((x + 78), y, obj_wall, false, true))
{
    self.shieldPatternMoveSpeed = -random(4);
}
else if ((self.shieldPatternMoveSpeed < 0)
    && collision_point((x - 78), y, obj_wall, false, true))
{
    self.shieldPatternMoveSpeed = random(4);
}

x += self.shieldPatternMoveSpeed;
