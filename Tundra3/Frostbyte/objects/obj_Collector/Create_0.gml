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
        case CollectorType.CPU: return global.vars.Items.CPU; break;
        case CollectorType.GPU: return global.vars.Items.GPU; break;
        case CollectorType.RAM: return global.vars.Items.RAM; break;
    }
}

function OnInteract()
{
    var inventory = playerInRange.inventory;
    var index = inventory.ContainsItem(GetItem());
    if (index != -1)
    {
        inventory.RemoveItem(index, 1);
        switch (currentType)
        {
            case CollectorType.CPU: obj_PCManager.AddItem("CPU"); break;
            case CollectorType.GPU: obj_PCManager.AddItem("GPU"); break;
            case CollectorType.RAM: obj_PCManager.AddItem("RAM"); break;
        }
    }
    else
    {
        str = $"You don't have any {CollectorTypeToString()} to give.";
        Raise("NotificationOpen", [str, playerInRange.PlayerIndex]);
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