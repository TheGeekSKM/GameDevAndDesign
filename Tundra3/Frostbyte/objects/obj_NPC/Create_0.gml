isUndead = false;
canAttack = false;
canMove = false;
fleeing = false;
walkToStartingPos = false;

collisionObjects = [obj_Wall];

attackRange = 64;

image_blend = make_color_hsv(irandom(255), 150, 100);

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

dialogueSceneIndex = 0;
dialogueScenes = [];

function AddDialogueToList(dialogue) {
    array_push(dialogueScenes, dialogue);
}

quest = undefined;
function SetQuest(_quest) {
    quest = _quest;
}


function QuestLogic() { }

function OnInteract() {
    var currentDialogue = dialogueSceneIndex < array_length(dialogueScenes) ? dialogueScenes[dialogueSceneIndex] : undefined;
    if (currentDialogue != undefined) {
        Raise("DialogueOpen", [playerInRange.PlayerIndex, currentDialogue]); 
    }

    if (quest != undefined) {
        if (GetQuest(quest.name) == undefined) {
            AddQuest(quest);
        }
        QuestLogic();
    }
    
    if (dialogueSceneIndex + 1 < array_length(dialogueScenes)) {
        dialogueSceneIndex++;
    }
}

inventory.Equip(inventory.AddItem(global.vars.Bow));
inventory.Equip(inventory.AddItem(global.vars.Arrow));