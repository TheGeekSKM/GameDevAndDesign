isUndead = false;

canAttack = false;
attackRange = 10;
attacker = noone;

canMove = true;
wanderRandomly = true;
chaseTarget = false;
fleeing = false;

wanderCounter = 0;
wanderTime = irandom_range(300, 600);

fleePosition = new Vector2(0, 0);

canCheckForPrey = false;
nearestPrey = ds_list_create();
preyTarget = noone;
checkForPreyRange = 120;

stats = new StatSystem(irandom_range(3, 8), irandom_range(3, 8), irandom_range(3, 8));
inventory = new Inventory(stats, id);
entityHealth = new HealthSystem(stats, inventory, isUndead, id);
stamina = new StaminaSystem(stats, id);
hunger = new HungerSystem(stats, id);
temperature = new TemperatureSystem(stats, entityHealth, id);
attack = new AttackSystem(stats, inventory, id);
entityData = new EntityData(stats, inventory);

function StartCheckingForPrey() {
    canCheckForPrey = true;
    alarm[0] = irandom_range(20, 30);
}
function StopCheckingForPrey() {
    canCheckForPrey = false;
}