isUndead = false;
canAttack = false;
canMove = false;
fleeing = false;
walkToStartingPos = false;

collisionObjects = [obj_Wall, obj_Door, obj_ItemRequired_INT];

attackRange = 64;

stats = new StatSystem(irandom_range(3, 8), irandom_range(3, 8), irandom_range(3, 8), id);
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
    echo("quest set")
    quest = _quest;
}


function QuestLogic() { }

function NoQuest() {}

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
    else
    {
        NoQuest();
    }
    
    if (dialogueSceneIndex + 1 < array_length(dialogueScenes)) {
        dialogueSceneIndex++;
    }
}

inventory.Equip(inventory.AddItem(global.vars.Items.Bow));
inventory.Equip(inventory.AddItem(global.vars.Items.Arrow));

alarm[0] = 10;