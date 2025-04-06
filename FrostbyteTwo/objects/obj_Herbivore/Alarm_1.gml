if (canCheckForFood)
{
    ds_list_clear(nearbyFoodSources);
    collision_circle_list(x, y, foodCheckRange, [obj_Plant], false, true, nearbyFoodSources, true);
    if (ds_list_size(nearbyFoodSources) > 0) 
    { 
        foodFound = true;
        targetFoodSource = nearbyFoodSources[| 0]; 
    }
    else 
    { 
        foodFound = false;
        targetFoodSource = noone; 
    }

    alarm[1] = irandom_range(15, 30);
}