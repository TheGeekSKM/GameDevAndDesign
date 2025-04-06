// Inherit the parent event
event_inherited();

requiredNum = irandom_range(5, 10);
speakerData = new SpeakerData("Jeffrey", color);

dialogueScene = new DialogueScene()
    .AddDialogue(speakerData, "Heya pal. Tim sent ya over right?")
    .AddDialogue(speakerData, "I've been having trouble finding game in the forest lately.")
    .AddDialogue(speakerData, "One of the wolves bit my leg, so I can't hunt as well as I used to.")
    .AddDialogue(speakerData, "If you can bring me some meat, I can help you out with some hunting tips.")
    .AddDialogue(speakerData, "[wave]Tip #1:[/wave] You can usually find some animals in the edges near the fog.")
    .AddDialogue(speakerData, "For some reason, the animals are attracted to the fog, but they never go in.")
    .AddDialogue(speakerData, "They just stare at it...")
    .AddDialogue(speakerData, "[wave]Tip #2:[/wave] When you start attacking, you won't be able to move, so be careful!")
    .AddDialogue(speakerData, $"I'll need at least [wave]{requiredNum}[/wave] pieces of meat to get started.");

dialogueQuestCompleted = new DialogueScene()
    .AddDialogue(speakerData, "Thanks for the meat, pal. I'll be able to help you out now.")
    .AddDialogue(speakerData, "Here's a [wave]bundle of sticks[/wave]. Take it over to Steve and he can make you some Cooked Meat.")


Subscribe("QuestCompleted", function(data) {
    if (data.questName == "Cherry Picking") {
        AddDialogueToList(dialogueScene);
        var _quest = new Quest("Meat for Jeffrey", $"Jeffrey needs your help to gather {requiredNum} meat for the camp.", id);
        SetQuest(_quest);
    }
});

function NoQuest()
{
    var popUp = instance_create_layer(x, y, "GUI", obj_PopUpText);
    popUp.Init($"Jeffrey: Can I help you?", c_white);    
}

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
            DiscoverRecipe(global.vars.ItemLibrary.AxeRecipe);
            break;
        case QuestState.Active:
            if (!instance_exists(global.vars.Player)) return;    
            var player = global.vars.Player;    
        
            var slot = undefined;
            var slotIndex = player.inventory.ContainsItem(global.vars.Items.RawMeat);
            if (slotIndex != -1) slot = player.inventory.allItems[slotIndex];
        
            if (slot != undefined and slot.quantity >= requiredNum) 
            {
                _quest.state = QuestState.Completed;
                player.inventory.RemoveItem(slotIndex, slot.quantity);
                
                Raise("DialogueOpen", dialogueQuestCompleted);

                var popUp = instance_create_layer(x, y, "GUI", obj_PopUpText);
                popUp.Init($"Quest Completed: Meat for Jeffrey");

                player.inventory.AddItem(global.vars.Items.Sticks, 10);

                DiscoverRecipe(global.vars.Items.CookedMeatRecipe);

                Raise("QuestCompleted", {
                    questName: "Meat for Jeffrey",
                    giver: "Jeffrey"
                });
            }
            else if (slot != undefined and slot.quantity < requiredNum) 
            {
                Raise("DialogueOpen", new DialogueScene().AddDialogue(speakerData, $"You need {requiredNum - slot.quantity} more Raw Meat. But I'll take what you have for now."));
                player.inventory.RemoveItem(slotIndex, slot.quantity);
                requiredNum -= slot.quantity;
            }
            else
            {
                Raise("DialogueOpen", new DialogueScene().AddDialogue(speakerData, "You don't have any Raw Meat on ya."));
            }
            break;
        case QuestState.Completed:
            break;
    }
}