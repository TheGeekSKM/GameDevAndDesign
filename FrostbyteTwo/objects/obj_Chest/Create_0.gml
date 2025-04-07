event_inherited();
function OnMouseLeftClick() {
    Raise("PickUp", id);   
    //if (instance_exists(global.vars.Player) and PlayerIsWithinRange())
    //{
        
    //}
}

function Collect(_playerID)
{

    obj_InventoryManager.SpawnInventoryWindow(_playerID.inventory, 400, 224, "Player Inventory", -20);
    obj_InventoryManager.SpawnInventoryWindow(inventory, irandom_range(100, 700), irandom_range(100, 300), Name, -7);
    global.vars.PauseGame(id);
}

stats = new StatSystem(20, 20, 20, id);
inventory = new Inventory(stats, id, 50);