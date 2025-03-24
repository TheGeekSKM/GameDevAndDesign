// Inherit the parent event
event_inherited();

requiredNum = irandom_range(5, 10);

var dialogueScene = new DialogueScene()
    .AddDialogue(spr_CPU, "Heya pal. Tim sent ya over right?")
    .AddDialogue(spr_CPU, "I've been having trouble finding game in the forest lately.")
    .AddDialogue(spr_CPU, "One of the wolves bit my leg, so I can't hunt as well as I used to.")
    .AddDialogue(spr_CPU, "If you can bring me some meat, I can help you out with some hunting tips.")
    .AddDialogue(spr_CPU, "$I'll need at least {requiredNum} pieces of meat to get started.");

dialogueQuestCompleted = new DialogueScene()
    .AddDialogue(spr_CPU, "Thanks for the meat, pal. I'll be able to help you out now.")
    .AddDialogue(spr_CPU, "Here's a bundle of sticks. Take it over to Steve and he can make you some Cooked Meat.")


Subscribe("QuestCompleted", function(data) {
    if (data.questName == "Cherry Picking") {
        AddDialogueToList(dialogueScene);
        var _quest = new Quest("Meat for Jeffrey", "Jeffrey needs your help to gather meat for the camp.", id);
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
            DiscoverRecipe(global.vars.AxeRecipe);
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