// Inherit the parent event
event_inherited();

requiredNum = irandom_range(30, 55);

var dialogueScene = new DialogueScene()
    .AddDialogue(spr_CPU, "Hey there, pardner. Listen, I need your help.")
    .AddDialogue(spr_CPU, "Because of the upcoming winter storm, we need cherries.")
    .AddDialogue(spr_CPU, "You can find cherry bushes and trees in the forest, if you're careful, but you'll need an axe to cut down the trees.")
    .AddDialogue(spr_CPU, $"Get me {requiredNum} cherries to help feed the camp.")
    .AddDialogue(spr_CPU, "I found this blueprint for an axe. Talk to Steve and see if he'll craft it for you.")
    .AddDialogue(spr_CPU, "Good luck, and be careful out there.");

dialogueQuestCompleted = new DialogueScene()
    .AddDialogue(spr_CPU, "Thank you for the cherries. You've saved the camp from starvation for now.")
    .AddDialogue(spr_CPU, "We still absolutely need to figure out a more permanent solution, though.")
    .AddDialogue(spr_CPU, "See if you can talk to Jeffrey up north. He might have some ideas about our hunting situation.");

AddDialogueToList(dialogueScene);

var _quest = new Quest("Cherry Picking", "Tim needs your help to gather cherries for the camp.", id);
SetQuest(_quest);

function QuestLogic() 
{
    if (quest == undefined) return;
    var _quest = GetQuest(quest.name);
    
    switch (_quest.state) {
        case QuestState.Inactive:
            _quest.state = QuestState.Active;
            DiscoverRecipe(global.vars.AxeRecipe);
            break;
        case QuestState.Active:
            var slot = undefined;
            var slotIndex = playerInRange.inventory.ContainsItem(global.vars.Cherry);
            if (slotIndex != -1) slot = playerInRange.inventory.allItems[slotIndex];
        
            if (slot != undefined and slot.quantity >= requiredNum) 
            {
                _quest.state = QuestState.Completed;
                playerInRange.inventory.RemoveItem(slotIndex, slot.quantity);
                
                Raise("DialogueOpen", [playerInRange.PlayerIndex, dialogueQuestCompleted]);

                var popUp = instance_create_layer(owner.x, owner.y, "GUI", obj_PopUpText);
                popUp.Init($"Quest Completed: Cherry Picking");

                Raise("QuestCompleted", {
                    questName: "Cherry Picking",
                    giver: "Tim"
                });
            }
            else if (slot != undefined and slot.quantity < requiredNum) 
            {
                Raise("DialogueOpen", [playerInRange.PlayerIndex, new DialogueScene().AddDialogue(spr_CPU, $"You need {requiredNum - slot.quantity} more cherries. But I'll take what you have for now.")]);
                playerInRange.inventory.RemoveItem(slotIndex, slot.quantity);
                requiredNum -= slot.quantity;
            }
            else
            {
                Raise("DialogueOpen", [playerInRange.PlayerIndex, new DialogueScene().AddDialogue(spr_CPU, "You don't have any cherries on ya.")]);
            }
            break;
        case QuestState.Completed:
            break;
    }
}