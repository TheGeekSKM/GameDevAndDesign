// Inherit the parent event
event_inherited();
isUndead = false;

canAttack = false;
attackRange = 32;
attacker = noone;

collisionObjects = [obj_Wall, obj_ItemRequired_INT, obj_Door]
targets = [obj_Herbivore, obj_NPC, obj_Player, obj_Zombie];

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
checkForPreyRange = 800;

stats = new StatSystem(irandom_range(3, 6), irandom_range(2,2), irandom_range(1, 2), id);
inventory = new Inventory(stats, id);
entityHealth = new HealthSystem(stats, inventory, isUndead, id);
stamina = new StaminaSystem(stats, id);
hunger = new HungerSystem(stats, id);
temperature = new TemperatureSystem(stats, entityHealth, id);
attack = new AttackSystem(stats, inventory, id);
entityData = new EntityData(stats, inventory);

if (entityHealth.IsDead()) 
{
    instance_destroy();
}

xMove = ChooseFromArray([-1, 1]) * 3;
yMove = ChooseFromArray([-1, 1]) * 3;


function StartCheckingForPrey() {
    canCheckForPrey = true;
    alarm[0] = irandom_range(20, 30);
}
function StopCheckingForPrey() {
    canCheckForPrey = false;
}

controller = new CarnivoreAIController(id);

inventory.Equip(inventory.AddItem(new MeleeWeaponItem("Claws", c_white, 100, 10, DamageType.PHYSICAL, 10, 2, [], spr_claws)));
inventory.AddItem(global.vars.ItemLibrary.RawMeat, irandom_range(1, 3));
