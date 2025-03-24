isUndead = false;

canMove = false;
wanderRandomly = false;
moveTowardsFoodSource = false;
fleeing = false;

wanderCounter = 0;
wanderTime = irandom_range(60, 600);
wanderDirection = 0;

canCheckForPredators = false;
canCheckForFood = false;
canEat = false;

predatorsFound = false;
foodFound = false;

predatorCheckRange = 100;
foodCheckRange = 100;
foodEatRange = 10;

closestPredator = noone;
targetFoodSource = noone;
fleePosition = new Vector2(0, 0);

nearbyPredators = ds_list_create();
nearbyFoodSources = ds_list_create();

stats = new StatSystem(irandom_range(2, 5), irandom_range(2, 3), irandom_range(1, 2), id);
inventory = new Inventory(stats, id);
entityHealth = new HealthSystem(stats, inventory, isUndead, id);
stamina = new StaminaSystem(stats, id);
hunger = new HungerSystem(stats, id);
temperature = new TemperatureSystem(stats, entityHealth, id);
entityData = new EntityData(stats, inventory);

xMove = ChooseFromArray([-1, 1]) * entityData.moveSpeed;
yMove = ChooseFromArray([-1, 1]) * entityData.moveSpeed;
collisionObjects = [obj_Wall];

function StartCheckingForPredators()
{
    canCheckForPredators = true;
    alarm[0] = irandom_range(15, 30);
}

function StopCheckingForPredators()
{
    canCheckForPredators = false;
}

function StartCheckingForFood()
{
    canCheckForFood = true;
    alarm[1] = irandom_range(15, 30);
}

function StopCheckingForFood()
{
    canCheckForFood = false;
}

function StartEating()
{
    canEat = true;
    alarm[2] = irandom_range(15, 30);
}

function StopEating()
{
    canEat = false;
}

controller = new HerbivoreAIController(id);

inventory.AddItem(global.vars.RawMeat, irandom_range(1, 3));

