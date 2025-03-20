isUndead = false;
canAttack = false;
canMove = false;
wanderRandomly = false;

attackRange = 64;

canCheckForPrey = false;
prey = noone;
nearbyPrey = ds_list_create();

stats = new StatSystem(irandom_range(3, 8), irandom_range(3, 8), irandom_range(3, 8));
inventory = new Inventory(stats, id);
entityHealth = new HealthSystem(stats, inventory, isUndead, id);
stamina = new StaminaSystem(stats, id);
hunger = new HungerSystem(stats, id);
temperature = new TemperatureSystem(stats, entityHealth, id);
attack = new AttackSystem(stats, inventory, id);
entityData = new EntityData(stats, inventory);

controller = new UndeadAIController(id);

function StartCheckingForPrey()
{
    canCheckForPrey = true;
    alarm[0] = irandom_range(300, 600);
}

function StopCheckingForPrey()
{
    canCheckForPrey = false;
}