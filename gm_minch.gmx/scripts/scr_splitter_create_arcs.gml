self.numBranches = argument0;
self.arcLength = argument1;

var kill_existing = argument2;

if (kill_existing)
{
    scr_splitter_clear_parts();// Removes all extra parts of splitter
}

self.arcs = ds_grid_create(numBranches, arcLength);

for (var i = 0; i < self.numBranches; i++)
{
    for (var j = 0; j < self.arcLength; j++)
    {
        var arc_instance = instance_create(0, 0, obj_arc);
        arc_instance.depth = self.depth - i;
        arc_instance.image_index = j % self.arcLength;
        arc_instance.image_speed = 0.5;
        ds_grid_add(self.arcs, i, j, arc_instance);
    }
}

// Top
self.topHat = instance_create(self.x, self.y, obj_splitter_top);
self.topHat.depth = self.depth - (self.numBranches * self.arcLength) - 1;

// Recalculate ticker limit
self.tickerLimit = floor(abs(self.tickerLimitBase / self.rotationMultiplier));
