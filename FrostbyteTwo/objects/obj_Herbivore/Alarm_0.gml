if (canCheckForPredators)
{
    ds_list_clear(nearbyPredators);
    collision_circle_list(x, y, predatorCheckRange, [obj_Plant, obj_Carnivore, obj_Zombie], false, true, nearbyPredators, true);
    if (ds_list_size(nearbyPredators) > 0) 
    { 
        predatorsFound = true;
        closestPredator = nearbyPredators[| 0]; 
    }
    else 
    { 
        predatorsFound = false; 
        closestPredator = noone;
    }

    alarm[0] = irandom_range(15, 30);
}