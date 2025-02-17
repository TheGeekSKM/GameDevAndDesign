// Inherit the parent event
event_inherited();

if (playerInRange and !questCompleted)
{
    draw_sprite(spr_exclamationPoint, 0, x, y - 10);
}
