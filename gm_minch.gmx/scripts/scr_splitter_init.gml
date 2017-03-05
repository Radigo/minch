/**
Options to change behavior to add in creation code:

self.rotationMultiplier = -1;// CCW rotation
scr_splitter_create_arcs(3, 7, true);// 3 branches of 7 arcs legth, rebuild branches (mandatory)

*/

scr_ai_init();

self.shield = true;
self.tickerLimitBase = 800;// A complete turn of arcs
self.rotationMultiplier = 1;// rotates CCW if set to negative

// Instanciate arcs
scr_splitter_create_arcs(4, 6, false);
