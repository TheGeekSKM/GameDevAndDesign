// Inherit the parent event
event_inherited();

currentItem = undefined;
itemCount = irandom_range(1, 3);
spr = [];

function Initialize(_item, _itemCount)
{
    currentItem = _item;
    itemCount = _itemCount;
    interactableName = currentItem.name;
    sprite_index = currentItem.sprite;

    for (var i = 0; i < _itemCount; i += 1) {
        array_push(spr, [x + irandom_range(-8, 8), y + irandom_range(-8, 8), irandom_range(0, 360)]);
    }

    image_angle = irandom_range(0, 360);    
}

function OnMouseLeftClick() {
    if (currentItem == undefined) return;
        
    if (instance_exists(global.Player) and PlayerIsWithinRange())
    {
        global.Player.inventory.AddItem(currentItem, itemCount);
        instance_destroy();
    }
}