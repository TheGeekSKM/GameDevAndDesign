isUndead = false;
canAttack = false;
canMove = false;
wanderRandomly = false;
chase = false;

attackRange = 64;
chaseRange = 200

wanderDirection = 0;
wanderCounter = 0;
wanderTime = irandom_range(60, 600);

canCheckForPrey = false;
prey = noone;
nearbyPrey = ds_list_create();

stats = new StatSystem(irandom_range(3, 8), irandom_range(3, 8), irandom_range(1, 2), id);
inventory = new Inventory(stats, id);
entityHealth = new HealthSystem(stats, inventory, isUndead, id);
stamina = new StaminaSystem(stats, id);
hunger = new HungerSystem(stats, id, false);
temperature = new TemperatureSystem(stats, entityHealth, id, false);
attack = new AttackSystem(stats, inventory, id);
entityData = new EntityData(stats, inventory);

xMove = ChooseFromArray([-1, 1]) * entityData.moveSpeed;
yMove = ChooseFromArray([-1, 1]) * entityData.moveSpeed;
collisionObjects = [obj_Wall, obj_Door, obj_ItemReq_CopperDeposit];

function StartCheckingForPrey()
{
    canCheckForPrey = true;
    alarm[0] = 1;
}

function StopCheckingForPrey()
{
    canCheckForPrey = false;
}

controller = new UndeadAIController(id);

targets = [obj_Herbivore, obj_NPC, obj_BASE_Player, obj_Carnivore];

inventory.Equip(inventory.AddItem(global.vars.Items.Arrow));
inventory.Equip(inventory.AddItem(global.vars.Items.Bow));