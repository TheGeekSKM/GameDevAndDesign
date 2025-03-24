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
            break;
        case QuestState.Completed:
            break;
    }
}