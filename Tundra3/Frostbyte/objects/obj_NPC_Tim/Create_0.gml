// Inherit the parent event
event_inherited();

requiredNum = irandom_range(30, 40);

var dialogueScene = new DialogueScene()
    .AddDialogue(sprite_index, "Hey there, pardner. Listen, I need your help.")
    .AddDialogue(sprite_index, "Because of the upcoming winter storm, we need cherries.")
    .AddDialogue(sprite_index, "You can find cherry bushes and trees in the forest, if you're careful, but you'll need an axe to cut down the trees.")
    .AddDialogue(sprite_index, $"Get me {requiredNum} cherries to help feed the camp.")
    .AddDialogue(sprite_index, "I found this blueprint for an axe. Talk to Steve and see if he'll craft it for you.")
    .AddDialogue(sprite_index, "Good luck, and be careful out there.");

dialogueQuestCompleted = new DialogueScene()
    .AddDialogue(sprite_index, "Thank you for the cherries. You've saved the camp from starvation for now.")
    .AddDialogue(sprite_index, "And I was able to make a new tent for people who need it.")
    .AddDialogue(sprite_index, "We still absolutely need to figure out a more permanent solution, though.")
    .AddDialogue(sprite_index, "See if you can talk to Jeffrey up north. He might have some ideas about our hunting situation.");

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

                layer_sequence_create("SetDressing", 3139, 1883, SEQ_Tent);

                var popUp2 = instance_create_layer(3139, 1883, "GUI", obj_PopUpText);
                popUp2.Init($"New Tent!");

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