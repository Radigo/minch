scr_ai_init();

self.PHASE_THRONE_INTRO = "phaseThroneIntro";
self.PHASE_THRONE = "phaseThrone";
self.PHASE_THRONE_STANDING = "phaseThroneStanding";
self.PHASE_THRONE_TRAVEL = "phaseThroneTravel";
self.PHASE_ROCKS_EXPLODING = "phaseRocksExploding";
self.PHASE_ROCKS_TRACES = "phaseRocksTraces";
self.PHASE_ROCKS_SUN = "phaseRocksSun";
self.PHASE_DEATH = "phaseDeath";

self.currentPhase = self.PHASE_THRONE_INTRO;

self.PHASE_THRONE_HP = 600;
self.PHASE_ROOM_HP = 800;

self.hp = self.PHASE_THRONE_HP + self.PHASE_ROOM_HP;
