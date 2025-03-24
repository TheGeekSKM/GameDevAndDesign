// Inherit the parent event
event_inherited();

requiredNum = irandom_range(5, 10);

var dialogueScene = new DialogueScene()
    .AddDialogue(spr_CPU, "Howdy, friend. I'm just takin' care of the PC that's powering the camp.")
    .AddDialogue(spr_CPU, "I'm running low on CPUs, GPUs, and RAM, though. If you can drop some in the containers, I'll get them piped to the PC.")
    .AddDialogue(spr_CPU, "It's a continuous process, so I'll need you to keep an eye on it.")
    .AddDialogue(spr_CPU, "Head over to the computer and check out how many CPUs, GPUs, and RAM are left.")
    .AddDialogue(spr_CPU, "I'll give you the blueprints for a CPU, GPU, but the RAM blueprints is missing. You'll have to find that one yourself.")
    .AddDialogue(spr_CPU, "Last I heard, the guy who had the RAM Blueprints was sent to check on a plane crash, but he never came back.");


AddDialogueToList(dialogueScene);
var _quest = new Quest("Save the PC", "The camp needs you to maintain the PC", id);
SetQuest(_quest);

function QuestLogic() 
{
    if (quest == undefined) 
    {
        return;
    }
    var _quest = GetQuest(quest.name);
    
    switch (_quest.state) {
        case QuestState.Inactive:
            _quest.state = QuestState.Active;
            DiscoverRecipe(global.vars.CPURecipe);
            DiscoverRecipe(global.vars.GPURecipe);
            break;
        case QuestState.Active:
            var slot = undefined;
            var slotIndex = playerInRange.inventory.ContainsItem(global.vars.RawMeat);
            if (slotIndex != -1) slot = playerInRange.inventory.allItems[slotIndex];
        
            if (slot != undefined and slot.quantity >= requiredNum) 
            {
                _quest.state = QuestState.Completed;
                playerInRange.inventory.RemoveItem(slotIndex, slot.quantity);
                
                Raise("DialogueOpen", [playerInRange.PlayerIndex, dialogueQuestCompleted]);

                var popUp = instance_create_layer(owner.x, owner.y, "GUI", obj_PopUpText);
                popUp.Init($"Quest Completed: Meat for Jeffrey");

                playerInRange.inventory.AddItem(global.vars.Sticks, 10);

                DiscoverRecipe(global.vars.CookedMeatRecipe);

                Raise("QuestCompleted", {
                    questName: "Meat for Jeffrey",
                    giver: "Jeffrey"
                });
            }
            else if (slot != undefined and slot.quantity < requiredNum) 
            {
                Raise("DialogueOpen", [playerInRange.PlayerIndex, new DialogueScene().AddDialogue(spr_CPU, $"You need {requiredNum - slot.quantity} more Raw Meat. But I'll take what you have for now.")]);
                playerInRange.inventory.RemoveItem(slotIndex, slot.quantity);
                requiredNum -= slot.quantity;
            }
            else
            {
                Raise("DialogueOpen", [playerInRange.PlayerIndex, new DialogueScene().AddDialogue(spr_CPU, "You don't have any Raw Meat on ya.")]);
            }
            break;
        case QuestState.Completed:
            break;
    }
}