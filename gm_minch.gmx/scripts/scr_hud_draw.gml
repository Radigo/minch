scr_scoring_step();

draw_set_color(c_ltgray);

// COMBO
// Bar
draw_sprite(spr_combobar_bg, global.comboColor, (view_xview[0] + 6), (view_yview[0] + 15));

if (global.comboColorTimer > 0)
{
    draw_sprite_stretched(
        spr_combobar,
        (global.comboColorTimer % 6), (view_xview[0] + 6),
        (view_yview[0] + 15),
        (35 * (global.comboColorTimer / global.comboColorDuration)),
        6);
}
else if (global.comboColor > 0)
{
    draw_sprite(spr_combobar_current, global.comboColor, (view_xview[0] + 6), (view_yview[0] + 15));
    
    // Frame
    draw_sprite(spr_comboframe, global.comboColor, (view_xview[0]), (view_yview[0]));
    draw_sprite(spr_combohalo, global.comboColor, (view_xview[0]), (view_yview[0]));
}

draw_sprite(spr_combobar_frame, 0, (view_xview[0] + 4), (view_yview[0] + 13));

// Combo counter
if (global.comboValue > 1)
{
    //var combo_pos_x = view_xview[0] + 320 - 4 - (string_length(string(global.comboValue)) * 17);
    draw_set_font(global.comboFont);
    draw_set_halign(fa_right);
    draw_text(view_xview[0] + 320 - 4, (view_yview[0] + 4), string(global.comboValue));
}

// SCORE
draw_set_font(global.scoreFont);
draw_set_halign(fa_left);
draw_text((view_xview[0] + 4), (view_yview[0] + 4), string(global.levelScore));

// LIVES
for (i = 0; i < global.lives; i++)
{
    draw_sprite(spr_life, 0, (view_xview[0] + 4 + (i * 8)), (view_yview[0] + 24));
}

// LEVEL ID
var level_name = scr_get_room_id(global.currentRoom);

draw_set_font(font_small);
draw_set_halign(fa_center);
draw_set_color(c_gray);

draw_text((view_xview[0] + 160), (view_yview[0] + 4), level_name);
