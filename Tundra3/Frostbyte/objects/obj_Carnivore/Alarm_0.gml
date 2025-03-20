if (canCheckForPrey)
{
    ds_list_clear(nearestPrey);
    collision_circle_list(x, y, checkForPreyRange, [obj_Herbivore, obj_BASE_Player, obj_NPC], false, false, nearestPrey, true);
    if (ds_list_size(nearestPrey) > 0)
    {
        preyTarget = nearestPrey[| 0];
    }
    else
    {
        preyTarget = noone;
    }

    alarm[0] = irandom_range(20, 30);
}
