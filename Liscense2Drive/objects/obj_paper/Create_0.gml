// Inherit the parent event

event_inherited();
RemoveExclamation();

value = irandom_range(1, 3);
image_speed = 0;
image_index = (value - 1);

collectStruct = {
    itemName : "Documents",
    itemCount: self.value,
}


OnInteract = function()
{
    global.Inventory += value;
    Raise("Item Collected", collectStruct);
    instance_destroy();
}

TurnToLook = function() {}

LookAtPlayer = function() {}