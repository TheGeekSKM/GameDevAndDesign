isUndead = false;
canAttack = false;
canMove = true;

collisionObjects = [obj_Wall];
doOnce = false;

target = new Target(id);
targetSprite = spr_target;

stats = global.vars.PlayerStats[PlayerIndex] == undefined ? new StatSystem(irandom_range(3, 8), irandom_range(3, 8), irandom_range(3, 8)) : global.vars.PlayerStats[PlayerIndex];
inventory = new Inventory(stats, id);
entityHealth = new HealthSystem(stats, inventory, isUndead, id);
stamina = new StaminaSystem(stats, id);
hunger = new HungerSystem(stats, id);
temperature = new TemperatureSystem(stats, entityHealth, id);
attack = new AttackSystem(stats, inventory, id);
entityData = new EntityData(stats, inventory);

controller = new PlayerController(id);

global.vars.Players[PlayerIndex] = id;

tempInteractableList = ds_list_create();
interactableArray = [];
interactionRange = 30;

targets = [obj_BASE_Entity];