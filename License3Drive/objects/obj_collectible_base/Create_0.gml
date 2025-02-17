// Inherit the parent event
event_inherited();

itemType = undefined;
itemCount = irandom_range(1, 3);


function OnInteract() {
    if (itemType == undefined) return;
    obj_player.AddItem(itemType, itemCount);
    
    var item = new ItemData(ItemTypeToString(itemType), itemCount, new Vector2(x, y))
    var text = instance_create_layer(item.pickUpLocation.x, item.pickUpLocation.y, "GUI", obj_pickUpText);
    text.Init(item);
    
    instance_destroy();
}