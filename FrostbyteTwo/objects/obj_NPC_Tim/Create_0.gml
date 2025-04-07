// Inherit the parent event
event_inherited();

requiredNum = irandom_range(5, 15);

speakerData = new SpeakerData("Tim", color);

dialogueScene = new DialogueScene()
    .AddDialogue(speakerData, "Hey there, pardner. Listen, I need your help.")
    .AddDialogue(speakerData, "Because of the upcoming winter storm, we need cherries.")
    .AddDialogue(speakerData, "You can find [wave]cherry bushes[/wave] and [wave]cherry trees[/wave] in the forest, if you're careful, but you'll need an [wave]axe[/wave] to cut down the trees.")
    .AddDialogue(speakerData, $"Get me [wave]{requiredNum} cherries[/wave] to help feed the camp.")
    .AddDialogue(speakerData, "I found this blueprint for an axe. Talk to [wave]Steve[/wave] and see if he'll craft it for you.")
    .AddDialogue(speakerData, "Good luck, and be careful out there.");

dialogueQuestCompleted = new DialogueScene()
    .AddDialogue(speakerData, "Thank you for the cherries. You've saved the camp from starvation for now.")
    .AddDialogue(speakerData, "And I was able to make a new tent for people who need it.")
    .AddDialogue(speakerData, "We still absolutely need to figure out a more permanent solution, though.")
    .AddDialogue(speakerData, "See if you can talk to Jeffrey up north. He might have some ideas about our hunting situation.");

AddDialogueToList(dialogueScene);

var _quest = new Quest("Cherry Picking", $"Tim needs your help to gather {requiredNum} cherries for the camp.", id);
SetQuest(_quest);

function QuestLogic() 
{
    if (quest == undefined) return;
    var _quest = GetQuest(quest.name);
    
    switch (_quest.state) {
        case QuestState.Inactive:
            _quest.state = QuestState.Active;
            DiscoverRecipe(global.vars.ItemLibrary.AxeRecipe);
            break;
        case QuestState.Active:
            if (!instance_exists(global.vars.Player)) return;
            var player = global.vars.Player;    
        
            var slot = undefined;
            var slotIndex = player.inventory.ContainsItem(global.vars.ItemLibrary.Cherry);
            if (slotIndex != -1) slot = player.inventory.allItems[slotIndex];
        
            if (slot != undefined and slot.quantity >= requiredNum) 
            {
                _quest.state = QuestState.Completed;
                player.inventory.RemoveItem(slotIndex, slot.quantity);
                
                Raise("DialogueOpen", dialogueQuestCompleted); 

                var popUp = instance_create_layer(x, y, "GUI", obj_PopUpText);
                popUp.Init($"Quest Completed: Cherry Picking");

                layer_sequence_create("SetDressing", 3200, 1944, SEQ_Tent);

                var popUp2 = instance_create_layer(3200, 1944, "GUI", obj_PopUpText);
                popUp2.Init($"New Tent!");

                Raise("QuestCompleted", {
                    questName: "Cherry Picking",
                    giver: "Tim"
                });
            }
            else if (slot != undefined and slot.quantity < requiredNum) 
            {
                Raise("DialogueOpen", new DialogueScene().AddDialogue(speakerData, $"You need {requiredNum - slot.quantity} more cherries. But I'll take what you have for now."));
                requiredNum -= slot.quantity;
                player.inventory.RemoveItem(slotIndex, slot.quantity);
                
            }
            else
            {
                Raise("DialogueOpen", new DialogueScene().AddDialogue(speakerData, "You don't have any cherries on ya."));
            }
            break;
        case QuestState.Completed:
            break;
    }
}