isUndead = false;
canAttack = false;

stats = new StatSystem(irandom_range(3, 8), irandom_range(3, 8), irandom_range(3, 8), id);
inventory = new Inventory(stats, id);
entityHealth = new HealthSystem(stats, inventory, isUndead, id);
stamina = new StaminaSystem(stats, id);
hunger = new HungerSystem(stats, id);
temperature = new TemperatureSystem(stats, entityHealth, id);
attack = new AttackSystem(stats, inventory, id);
entityData = new EntityData(stats, inventory);

targets = [];