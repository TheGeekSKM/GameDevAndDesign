isUndead = false;
canAttack = false;
canMove = true;

paused = false;

collisionObjects = [obj_Wall, obj_Collector, obj_PCManager];
doOnce = false;

target = new Target(id);
targetSprite = spr_target;

stats = global.vars.PlayerStats[PlayerIndex] == undefined ? 
    new StatSystem(irandom_range(3, 8), irandom_range(3, 8), irandom_range(3, 8), id) : 
    new StatSystem(
        global.vars.PlayerStats[PlayerIndex].strength, 
        global.vars.PlayerStats[PlayerIndex].dexterity, 
        global.vars.PlayerStats[PlayerIndex].constitution, id
    );
inventory = new Inventory(stats, id);
entityHealth = new HealthSystem(stats, inventory, isUndead, id);
stamina = new StaminaSystem(stats, id);
hunger = new HungerSystem(stats, id);
temperature = new TemperatureSystem(stats, entityHealth, id, true);
attack = new AttackSystem(stats, inventory, id);
entityData = new EntityData(stats, inventory);

controller = new PlayerController(id);

global.vars.Players[PlayerIndex] = id;

tempInteractableList = ds_list_create();
interactableArray = [];
interactionRange = 30;

targets = [obj_BASE_Entity];

function Pause(_value)
{
    paused = _value;
    controller.stateMachine.change("idle");
}


// inventory.AddItem(global.vars.Sword);
inventory.Equip(inventory.AddItem(global.vars.Bow));
inventory.Equip(inventory.AddItem(global.vars.Arrow2));


