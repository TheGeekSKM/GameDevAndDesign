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
temperature = new TemperatureSystem(stats, entityHealth, id, true);
attack = new AttackSystem(stats, inventory, id);
entityData = new EntityData(stats, inventory);

controller = new PlayerController(id);


PlayerIndex = 0;
get_game_camera(0).set_view_size(400, 224)
