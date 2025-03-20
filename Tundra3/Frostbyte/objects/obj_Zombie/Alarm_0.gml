if (canCheckForPrey)
{
    ds_list_clear(nearbyPrey);
    collision_circle_list(x, y, attackRange, [obj_BASE_Player, obj_Herbivore, obj_Carnivore, obj_NPC], false, true, nearbyPrey, true);
    if (ds_list_size(nearbyPrey) > 0)
    {
        prey = nearbyPrey[| 0];
    }
    else
    {
        prey = noone;
    }
    alarm[0] = irandom_range(20, 30);
}