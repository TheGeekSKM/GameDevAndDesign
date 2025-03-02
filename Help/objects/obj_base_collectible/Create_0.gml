// Inherit the parent event
event_inherited();
currentItem = undefined;
itemCount = irandom_range(1, 3);

function Initialize(_item, _itemCount)
{
    currentItem = _item;
    itemCount = _itemCount;
    interactableName = currentItem.name;
    sprite_index = currentItem.sprite;
}

function OnInteract() {
    if (currentItem == undefined) return;
    playerInRange.inventory.AddItem(currentItem, itemCount);
    
    show_message("TODO: Implement pick up text");
    
    instance_destroy();
}
