obj_GDD_Button_Inventory.AddCallback(function() {
    if (instance_exists(global.InventoryManager))
    {
        global.InventoryManager.SpawnInventoryWindow(global.vars.Player.inventory, 400, 224, "Player Inventory");
        global.vars.PauseGame(global.vars.Player.id);
    }
});