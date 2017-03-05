with (self.topHat) instance_destroy();

for (var i = 0; i < self.numBranches; i++)
{
    for (var j = 0; j < self.arcLength; j++)
    {
        arc_instance = ds_grid_get(self.arcs, i, j);
        with (arc_instance) instance_destroy();
    }
}
