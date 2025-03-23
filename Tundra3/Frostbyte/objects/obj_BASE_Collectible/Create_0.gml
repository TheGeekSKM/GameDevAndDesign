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

    for (var i = 0; i < _itemCount; i += 1) {
        array_push(spr, [x + irandom_range(-8, 8), y + irandom_range(-8, 8), irandom_range(0, 360)]);
    }
}

spr = [];

function OnInteract() {
    if (currentItem == undefined) return;
    playerInRange.inventory.AddItem(currentItem, itemCount);
    
    if (destroyOnPickUp) instance_destroy();
}