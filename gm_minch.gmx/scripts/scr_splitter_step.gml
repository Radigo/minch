scr_ai_step();

// Move top
self.topHat.x = self.x;
self.topHat.y = self.y;

// Move arcs
var arc_angle, arc_distance;
var arcs_angle = (self.ticker / self.tickerLimitBase) * (pi * 2) * self.rotationMultiplier;// Base arc angle in radian

for (var i = 0; i < self.numBranches; i++)
{
    arc_angle = ((i / self.numBranches) * (pi * 2)) + arcs_angle;
    
    for (var j = 0; j < self.arcLength; j++)
    {
        arc_distance = j * 8;
        
        arc_instance = ds_grid_get(self.arcs, i, j);
        arc_instance.x = self.x + (sin(arc_angle) * arc_distance);
        arc_instance.y = self.y + (cos(arc_angle) * arc_distance);
        arc_instance.image_angle = radtodeg(arc_angle - (pi * 0.5));
    }
}
