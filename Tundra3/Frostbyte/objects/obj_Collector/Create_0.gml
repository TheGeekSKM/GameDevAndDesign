// Inherit the parent event
event_inherited();

enum CollectorType
{
    GPU,
    CPU,
    RAM
}

switch (currentType)
{
    case CollectorType.CPU: image_index = 0; interactableName = "CPU Collector"; break;
    case CollectorType.GPU: image_index = 1; interactableName = "GPU Collector"; break;
    case CollectorType.RAM: image_index = 2; interactableName = "RAM Collector"; break;
}

function GetItem()
{
    switch (currentType)
    {
        case CollectorType.CPU: return global.vars.CPU; break;
        case CollectorType.GPU: return global.vars.GPU; break;
        case CollectorType.RAM: return global.vars.RAM; break;
    }
}

function OnInteract()
{
    var inventory = playerInRange.inventory;
    var index = inventory.ContainsItem(GetItem());
    if (index != -1)
    {
        inventory.RemoveItem(index, 1);
        show_message("TODO: Make Computer Take Part pls!!!")
    }
}

function CollectorTypeToString()
{
    switch (currentType)
    {
        case CollectorType.CPU: return "CPU"; break;
        case CollectorType.GPU: return "GPU"; break;
        case CollectorType.RAM: return "RAM"; break;
    }
}