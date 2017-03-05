/**
Boss tanker
Elements:
- left protection (blue)
- right protection (magenta)
- base

Weapons:
A. Arms canons
B. 4 spheres
C. Shoulder canons
D. Front canons
E. Tubes

Patterns:
1. With 2 protections:
    A. Alternate shots
    B. Light aimed shots
    E. Hard rotary spread when MinCH goes behind boss

2. With 1 protection left:
    A. Alternate shots, the broken protection side shots harder
    B. Medium aimed shots
    C. Medium spread
    D. Medium aimed spread
    E. Hard rotary spread when MinCH goes behind boss

3. With no protections left:
    A. Simultaneous shots
    B. Hard aimed shots
    C. Medium spread
    D. Medium aimed spread
    E. Hard rotary spread when MinCH goes behind boss & Hard rotary pattern
*/


if (!self.switchTriggered)
{
    return false;
}

if (!self.hasFocus)
{
    scr_switch_machine(2);
    self.hasFocus = true;
    
    global.nextBGM = bgm_boss_1;
    global.bgmSequencing = global.bgmSequenceInstant;
    audio_stop_sound(global.currentBGM);
    scr_play_bgm();
}

scr_ai_step();

// Global pattern
if (obj_minch.y < (self.y - 32))
{
    if ((self.ticker % 8) == 0)
    {
        scr_bullet_shot((self.x + 20), (self.y - 32), scr_aim_at_minch(self, 5, 20, -32), 5, 2);
        scr_bullet_shot((self.x - 20), (self.y - 32), scr_aim_at_minch(self, 5, -20, -32), 5, 2);
    }
    
    if ((self.ticker % 30) == 0)
    {
        scr_pattern_spread(self.x, (self.y - 24), 90, 3, 3, 36, 150);
    }
}

// Parts dependent patterns
if (self.isIntroSequence == true)
{
    scr_boss_tanker_intro_step();
}
else if (instance_exists(obj_boss_tanker_left)
    && instance_exists(obj_boss_tanker_right))
{
    scr_boss_tanker_pattern_one();
}
else if (instance_exists(obj_boss_tanker_base)
    && instance_exists(obj_boss_tanker_left))
{
    scr_boss_tanker_pattern_two("left");
}
else if (instance_exists(obj_boss_tanker_base)
    && instance_exists(obj_boss_tanker_right))
{
    scr_boss_tanker_pattern_two("right");
}
else if (instance_exists(obj_boss_tanker_base))
{
    scr_boss_tanker_pattern_three();
}
else
{
    if (instance_exists(obj_boss_tanker_left))
    {
        with (obj_boss_tanker_left) scr_enemy_death(false, false);
        self.ticker = 1;
    }
    
    if (instance_exists(obj_boss_tanker_right))
    {
        with (obj_boss_tanker_right) scr_enemy_death(false, false);
        self.ticker = 1;
    }
    
    if (self.isDeathSequence == true)
    {
        // Explode
        scr_boss_tanker_death_step();
    }
    else
    {
        show_debug_message("No part remaining");
        // Focus camera off
        scr_switch_machine(3);
        instance_destroy();
        
        return false;
    }
}

// Parts
if (instance_exists(obj_boss_tanker_base))
{
    obj_boss_tanker_base.x = self.x;
    obj_boss_tanker_base.y = self.y;
}

if (instance_exists(obj_boss_tanker_left))
{
    obj_boss_tanker_left.x = self.x;
    obj_boss_tanker_left.y = self.y;
}

if (instance_exists(obj_boss_tanker_right))
{
    obj_boss_tanker_right.x = self.x;
    obj_boss_tanker_right.y = self.y;
}
