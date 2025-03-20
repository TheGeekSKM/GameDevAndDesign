isUndead = false;
canAttack = false;
canMove = false;
fleeing = false;
walkToStartingPos = false;

attackRange = 64;

stats = new StatSystem(irandom_range(3, 8), irandom_range(3, 8), irandom_range(3, 8));
inventory = new Inventory(stats, id);
entityHealth = new HealthSystem(stats, inventory, isUndead, id);
stamina = new StaminaSystem(stats, id);
hunger = new HungerSystem(stats, id, false);
temperature = new TemperatureSystem(stats, entityHealth, id, false);
attack = new AttackSystem(stats, inventory, id);
entityData = new EntityData(stats, inventory);

controller = new NPCAIController(id);

startingPos = new Vector2(x, y);