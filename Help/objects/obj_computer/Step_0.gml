if (!found)
{
    if (playerInRange != noone) 
    {
        found = true;
    }
}

if (cpuRequirements <= 0 and gpuRequirements <= 0 and ramRequirements <= 0 and found) 
    Transition(rmWin, seqTrans_In_CornerSlide, seqTrans_Out_CornerSlide);

ds_list_clear(itemList);
collision_circle_list(x, y, itemRange, [obj_computerPart, obj_base_collectible], false, true, itemList, false);

for (var i = 0; i < ds_list_size(itemList); i++)
{
    if (!instance_exists(itemList[| i])) return;
    var item = itemList[| i].currentItem;
    SwallowItem(item);
    instance_destroy(itemList[| i]);
}