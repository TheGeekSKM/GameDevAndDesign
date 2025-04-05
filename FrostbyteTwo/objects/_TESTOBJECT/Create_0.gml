event_inherited();
itemReciever = new ItemReciever
(
    [
        new InventorySlot(global.vars.ItemLibrary.CPU, 2)
    ]
).AddSuccessCallback(function () { echo("Success callback executed!") });