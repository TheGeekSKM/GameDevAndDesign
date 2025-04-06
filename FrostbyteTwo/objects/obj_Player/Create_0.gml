// Inherit the parent event
event_inherited();
isPlayer = true;
stats = global.vars.PlayerStats == undefined ? 
    new StatSystem(irandom_range(3, 8), irandom_range(3, 8), irandom_range(3, 8), id) : 
    new StatSystem(
        global.vars.PlayerStats.strength, 
        global.vars.PlayerStats.dexterity,
        global.vars.PlayerStats.constitution, id
    );

inventory = new Inventory(stats, id);
entityHealth = new HealthSystem(stats, inventory, isUndead, id);
stamina = new StaminaSystem(stats, id);
hunger = new HungerSystem(stats, id);
temperature = new TemperatureSystem(stats, entityHealth, id);
attack = new AttackSystem(stats, inventory, id);
entityData = new EntityData(stats, inventory);

show_message("ESTABLISH TARGETS FOR THE PLAYER")
targets = [];
collisionObjects = [obj_Wall, obj_BASE_Entity, obj_Door];


PlayerIndex = 0;
get_game_camera(0).set_view_size(400, 224)

rightClickHold = false;

get_game_camera(0).set_follow(obj_Player);

attackIndex = 0;
alarm[0] = 30;

global.vars.Player = id;
currentCollectible = noone;
Subscribe("PickUp", function(_id) {
    currentCollectible = _id;
});

inventory.AddItem(global.vars.ItemLibrary.Bow, 1, false)
inventory.Equip(inventory.AddItem(global.vars.ItemLibrary.Sword, 1, false));
inventory.Equip(inventory.AddItem(global.vars.ItemLibrary.Arrow2, 1, false));
inventory.AddItem(global.vars.ItemLibrary.Arrow2, 1, false);
inventory.AddItem(global.vars.ItemLibrary.Arrow2, 1, false);
inventory.AddItem(global.vars.ItemLibrary.Arrow2, 1, false);
inventory.AddItem(global.vars.ItemLibrary.Arrow2, 1, false);
var item = inventory.AddItem(global.vars.ItemLibrary.LeatherArmor, 1, false)
inventory.Equip(item);


function OnMouseLeftClick()
{
    if (instance_exists(global.InventoryManager))
    {
        global.InventoryManager.SpawnInventoryWindow(global.vars.Player.inventory, 400, 224, "Player Inventory");
        global.vars.PauseGame(global.vars.Player.id);
    }
}