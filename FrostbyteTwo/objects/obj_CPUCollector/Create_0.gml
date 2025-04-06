event_inherited();
itemReciever = new ItemReciever
(
    [
        new InventorySlot(global.vars.ItemLibrary.CPU, 2)
    ]
)
.AddSuccessCallback(function (_item, _count) { 
    var popUp = instance_create_layer(x, y, "GUI", obj_PopUpText)
    popUp.Init($"Recieved {_item[$ "name"]} x{_count}");
    echo("Success callback executed!") 
    
    repeat (_count)
    {
        obj_PCManager.AddItem("CPU");
    }
})
.AddUnsatisfiedCallback(function (_item, _count) {
    var popUp = instance_create_layer(x, y, "GUI", obj_PopUpText)
    popUp.Init($"Recieved {_item[$ "name"]} x{_count}");
    echo("Success callback executed!") 
    
    repeat (_count)
    {
        obj_PCManager.AddItem("CPU");
    }
});

image_index = 0;