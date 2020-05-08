scr_ai_init();

self.PHASE_THRONE_INTRO = "phaseThroneIntro";
self.PHASE_THRONE_ROCKS = "phaseThroneSpawnRocks";
self.PHASE_THRONE = "phaseThrone";
self.PHASE_THRONE_STANDING = "phaseThroneStanding";
self.PHASE_ROCKS_EXPLODING = "phaseRocksExploding";
self.PHASE_ROCKS_TRACES = "phaseRocksTraces";
self.PHASE_ROCKS_SUN = "phaseRocksSun";
self.PHASE_DEATH = "phaseDeath";

self.currentPhase = self.PHASE_THRONE_INTRO;

self.PHASE_THRONE_HP = 600;//600
self.PHASE_ROOM_HP = 2000;//2000
self.PHASE_SUN_HP = 1000;//1000

self.THRONE_INTRO_TICKER_LIMIT = 1000;
self.NUM_THRONE_ROCKS = 12;

self.ORBIT_Y = 48;
self.ORBIT_X = self.ORBIT_Y * 1.35;
self.THRONE_ORBIT_CENTER_Y_OFFSET = -6;

self.ROOM_TOP = 224;
self.ROOM_BOTTOM = 608;
self.ROOM_LEFT = 864;
self.ROOM_RIGHT = 1248;

self.orbitCenterX = 0;
self.orbitCenterY = 0;
self.prevSunCurveRatio = 0;
self.sunNumRocks = 8;

self.hp = self.PHASE_THRONE_HP + self.PHASE_ROOM_HP + self.PHASE_SUN_HP;

// Roof
self.roof = instance_create(self.x, self.y, obj_roof_center);
self.roof.depth = self.depth +1;

// FX
self.pt_fx = part_type_create();
part_type_sprite(self.pt_fx, spr_black_particle, true, true, false);
part_type_speed(self.pt_fx, 0.1, 0.6, -0.02, 0);
part_type_life(self.pt_fx, 20, 80);
part_type_gravity(self.pt_fx, 0.01, -90);
part_type_direction(self.pt_fx, 0, 180, 0, 1);
part_type_orientation(self.pt_fx, 0, 0, 0, 0, true);

self.em_fx = part_emitter_create(global.ps_ground); 
