// Inherit the parent event
event_inherited();
currentSlotObject = noone;

useButton = noone;
infoButton = noone;
dropButton = noone;
// menu opens when "ItemClicked" event is triggered
Subscribe("ItemClicked", function(_slotObject)
{
    if (instance_exists(useButton)) instance_destroy(useButton);
    if (instance_exists(infoButton)) instance_destroy(infoButton);
    if (instance_exists(dropButton)) instance_destroy(dropButton);


    currentSlotObject = _slotObject;
    endingPos = new Vector2(guiMouseX - (sprite_width / 2) - 10, guiMouseY - (sprite_height / 2) - 10);

    if (_slotObject.inventorySystemRef[$ "owner"] == global.vars.Player) 
    {
        useButton = instance_create_depth(x, topLeft.y + 48, depth - 1, obj_BASE_Button);
        useButton.SetText("Use");
        useButton.SetColors(make_color_rgb(149, 181, 144), make_color_rgb(86, 181, 72));
        useButton.SetSize(140, 42);
        useButton.SetPosition(x, topLeft.y + 48);
        useButton.SetDepth(depth - 1);
        useButton.AddCallback(function() {
            UseItem();
        });

        infoButton = instance_create_depth(x, topLeft.y + 92, depth - 1, obj_BASE_Button);
        infoButton.SetText("Info");
        infoButton.SetColors(make_color_rgb(149, 181, 144), make_color_rgb(86, 181, 72));
        infoButton.SetSize(140, 42);
        infoButton.SetPosition(x, topLeft.y + 92);
        infoButton.SetDepth(depth - 1);
        infoButton.AddCallback(function() {
            ShowInfo();
        });

        dropButton = instance_create_depth(x, topLeft.y + 136, depth - 1, obj_BASE_Button);
        dropButton.SetText("Drop");
        dropButton.SetColors(make_color_rgb(149, 181, 144), make_color_rgb(86, 181, 72));
        dropButton.SetSize(140, 42);
        dropButton.SetPosition(x, topLeft.y + 136);
        dropButton.SetDepth(depth - 1);
        dropButton.AddCallback(function() {
            DropItem();
        });

    }
    else 
    {
        infoButton = instance_create_depth(x, topLeft.y + 92, depth - 1, obj_BASE_Button);
        infoButton.SetText("Info");
        infoButton.SetColors(make_color_rgb(149, 181, 144), make_color_rgb(86, 181, 72));
        infoButton.SetSize(140, 42);
        infoButton.SetPosition(x, topLeft.y + 92);
        infoButton.SetDepth(depth - 1);
        infoButton.AddCallback(function() {
            ShowInfo();
        });
    }
    
    Name = _slotObject.inventorySystemRef.GetSlot(_slotObject.slotIndex).item.name;
    OpenMenu();
});
// use option, info option, and drop option

// use button needs to change name based on the item that is clicked...

function UseItem()
{
    var inventory = currentSlotObject.inventorySystemRef;
    inventory.UseItemByIndex(currentSlotObject.slotIndex, 1);
}

function ShowInfo()
{
    Raise("ItemInfoClicked", currentSlotObject);
}

function DropItem()
{
    var inventory = currentSlotObject.inventorySystemRef;
    inventory.DropItemByIndex(currentSlotObject.slotIndex, 1, true);

}