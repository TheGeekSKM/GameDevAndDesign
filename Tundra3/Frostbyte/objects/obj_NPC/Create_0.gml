isUndead = false;
canAttack = false;
canMove = false;
fleeing = false;
walkToStartingPos = false;

collisionObjects = [obj_Wall];

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

targets = [obj_Herbivore, obj_Carnivore, obj_BASE_Player, obj_Zombie];

playerInRange = noone;
textToDisplay = $"{Name}\n{InteractText}";

scene = new DialogueScene()
    .AddDialogue(spr_carnivore_1, "Hello there!")
    .AddDialogue(spr_carnivore_1, "I am a carnivore!")
    .AddDialogue(spr_carnivore_1, "I like to eat meat!");



function OnInteract() {
    Raise("DialogueOpen", [playerInRange.PlayerIndex, scene]); 
}

inventory.Equip(inventory.AddItem(global.vars.Bow));
inventory.Equip(inventory.AddItem(global.vars.Arrow));