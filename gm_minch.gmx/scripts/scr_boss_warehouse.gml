/**
Warehouse Boss
Elements:
- Head
- Front shield
- Base

Weapons:
A. Head canon
B. Head butt
C. Side lasers (base's edges)
D. Side canons
E. Shield spread

Patterns:
1. With shield

2. Without shield

3. Without Head
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

// Parts dependent patterns
if (self.isIntroSequence == true)
{
    scr_boss_warehouse_intro_step();
}
else if (instance_exists(obj_boss_warehouse_shield))
{
    if (self.currentPatternPhase == self.SHIELD_RANDOM)
    {
        scr_boss_warehouse_pattern_shield_random();
    }
    else
    {
        scr_boss_warehouse_pattern_shield_focus();
    }
    
}
else if (instance_exists(obj_boss_warehouse_head))
{
    scr_boss_warehouse_pattern_head();
}
else
{
    if (instance_exists(obj_boss_warehouse_shield))
    {
        with (obj_boss_warehouse_shield) scr_enemy_death(false, false);
        self.ticker = 1;
    }
    
    if (instance_exists(obj_boss_warehouse_head))
    {
        with (obj_boss_warehouse_head) scr_enemy_death(false, false);
        self.ticker = 1;
    }
    
    if (self.isDeathSequence == true)
    {
        // Explode
        scr_boss_warehouse_death_step();
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

// Collision
if ((self.moveDirection > 0) && (collision_point((x + 78), y, obj_wall, false, true)))// Hit right
{
    x -= self.moveSpeed * 3;
    self.targetSpeed = 0;
    self.moveSpeed *= 0.1;
}
else if (self.moveDirection < 0) && (collision_point((x - 78), y, obj_wall, false, true))// Hit left
{
    x += self.moveSpeed * 3;
    self.targetSpeed = 0;
    self.moveSpeed *= 0.1;
}

// Parts
if (instance_exists(obj_boss_warehouse_base))
{
    obj_boss_warehouse_base.x = self.x;
    obj_boss_warehouse_base.y = self.y;
}

if (instance_exists(obj_boss_warehouse_shield))
{
    obj_boss_warehouse_shield.x = self.x;
    obj_boss_warehouse_shield.y = self.y;
}

if (instance_exists(obj_boss_warehouse_head))
{
    obj_boss_warehouse_head.x = self.x;
    obj_boss_warehouse_head.y = self.y;
}
