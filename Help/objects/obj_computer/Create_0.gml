// Inherit the parent event
event_inherited();

gpuRequirements = irandom_range(10, 20);
cpuRequirements = irandom_range(10, 20);
ramRequirements = irandom_range(10, 20);

found = false;

itemList = ds_list_create();
itemRange = 50;

function SwallowItem(_item)
{
    switch (_item.name)
    {
        case "GPU": gpuRequirements--; break;
        case "Motherboard": cpuRequirements--; break;
        case "RAM Stick": ramRequirements--; break;
    }
}

function OnInteract()
{
    Raise("ComputerOpen", playerInRange);
}