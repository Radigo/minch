// When enemy is colliding, change enemy's direction depending on deflector's direction
var set_enemy_direction = false;// Change enemy direction when true

if (other.direction == deflectorDirection)
{
    return false;
}

switch(self.deflectorDirection)
{
    case 0:
    case 180:
        // Left/right, check enemy Y
        if (((other.direction % 360) > 0)
            &&((other.direction % 360) < 180))
        {
            // Moving upwards
            if (other.y <= (self.y + 16))
            {
                set_enemy_direction = true;
            }
        }
        else if ((other.direction % 360) > 180)
        {
            // Moving downwards
            if (other.y >= (self.y + 16))
            {
                set_enemy_direction = true;
            }
        }
        break;
    case 90:
    case 270:
        // Up/down, check enemy X
        if (((other.direction % 360) > 90)
            &&((other.direction % 360) < 270))
        {
            // Moving left
            if (other.x <= (self.x + 16))
            {
                set_enemy_direction = true;
            }
        }
        else if (((other.direction % 360) < 90)
            || ((other.direction % 360) > 270))
        {
            // Moving right
            if (other.x >= (self.x + 16))
            {
                set_enemy_direction = true;
            }
        }
        break;
}

if (set_enemy_direction == true)
{
    other.direction = self.deflectorDirection;
}
