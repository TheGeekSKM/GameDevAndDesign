// Inherit the parent event
event_inherited();

if (playerInRange and !questCompleted and obj_npc_int_2.questCompleted and obj_npc_int_3.questCompleted)
{
    draw_sprite(spr_exclamationPoint, 0, x, y - 10);
}
