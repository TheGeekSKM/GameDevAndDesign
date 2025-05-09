// Inherit the parent event
event_inherited();



color = make_color_hsv(irandom(255), 150, 150);
image_blend = color;

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
            DiscoverRecipe(global.vars.Items.AxeRecipe);
            break;
        case QuestState.Active:
            var slot = undefined;
            var slotIndex = playerInRange.inventory.ContainsItem(global.vars.Items.Cherry);
            if (slotIndex != -1) slot = playerInRange.inventory.allItems[slotIndex];
        
            if (slot != undefined and slot.quantity >= requiredNum) 
            {
                _quest.state = QuestState.Completed;
                playerInRange.inventory.RemoveItem(slotIndex, slot.quantity);
                
                Raise("DialogueOpen", [playerInRange.PlayerIndex, dialogueQuestCompleted]);

                var popUp = instance_create_layer(x, y, "GUI", obj_PopUpText);
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
                Raise("DialogueOpen", [playerInRange.PlayerIndex, new DialogueScene().AddDialogue(speakerData, $"You need {requiredNum - slot.quantity} more cherries. But I'll take what you have for now.")]);
                requiredNum -= slot.quantity;
                playerInRange.inventory.RemoveItem(slotIndex, slot.quantity);
                
            }
            else
            {
                Raise("DialogueOpen", [playerInRange.PlayerIndex, new DialogueScene().AddDialogue(speakerData, "You don't have any cherries on ya.")]);
            }
            break;
        case QuestState.Completed:
            break;
    }
}