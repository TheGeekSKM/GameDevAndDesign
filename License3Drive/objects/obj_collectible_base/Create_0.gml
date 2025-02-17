// Inherit the parent event
event_inherited();

itemType = undefined;
itemCount = irandom_range(1, 3);


function OnInteract() {
    if (itemType == undefined) return;
    obj_player.AddItem(itemType, itemCount);
    instance_destroy();
}