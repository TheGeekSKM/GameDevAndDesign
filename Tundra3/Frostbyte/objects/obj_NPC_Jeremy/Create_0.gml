// Inherit the parent event
event_inherited();

requiredNum = irandom_range(5, 10);

color = make_color_hsv(irandom(255), 150, 150);
image_blend = color;

requiredNum = irandom_range(5, 10);
speakerData = new SpeakerData("Jeremy", color);

var dialogueScene = new DialogueScene()
    .AddDialogue(speakerData, "Howdy, friend. I'm just takin' care of the PC that's powering the camp.")
    .AddDialogue(speakerData, "I'm running low on CPUs, GPUs, and RAM, though. If you can drop some in the containers, I'll get them piped to the PC.")
    .AddDialogue(speakerData, "It's a continuous process, so I'll need you to keep an eye on it.")
    .AddDialogue(speakerData, "Head over to the computer and check out how many CPUs, GPUs, and RAM are left.")
    .AddDialogue(speakerData, "I'll give you the blueprints for a CPU, GPU, but the RAM blueprints is missing. You'll have to find that one yourself.")
    .AddDialogue(speakerData, "Last I heard, the guy who had the RAM Blueprints was sent to check on a plane crash, but he never came back.")
    .AddDialogue(speakerData, "You might want to check the crash site for the blueprints. You might find some other useful blueprints there too.")
    .AddDialogue(speakerData, "Along the way, see if you can keep track of any silicon or copper deposits. We're running low on those too.")
    .AddDialogue(speakerData, "Good luck, friend.")


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
}// Inherit the parent event
event_inherited();

requiredNum = irandom_range(5, 10);

color = make_color_hsv(irandom(255), 150, 150);
image_blend = color;

requiredNum = irandom_range(5, 10);
speakerData = new SpeakerData("Jeremy", color);

var dialogueScene = new DialogueScene()
    .AddDialogue(speakerData, "Howdy, friend. I'm just takin' care of the PC that's powering the camp.")
    .AddDialogue(speakerData, "I'm running low on CPUs, GPUs, and RAM, though. If you can drop some in the containers, I'll get them piped to the PC.")
    .AddDialogue(speakerData, "It's a continuous process, so I'll need you to keep an eye on it.")
    .AddDialogue(speakerData, "Head over to the computer and check out how many CPUs, GPUs, and RAM are left.")
    .AddDialogue(speakerData, "I'll give you the blueprints for a CPU, GPU, but the RAM blueprints is missing. You'll have to find that one yourself.")
    .AddDialogue(speakerData, "Last I heard, the guy who had the RAM Blueprints was sent to check on a plane crash, but he never came back.")
    .AddDialogue(speakerData, "You might want to check the crash site for the blueprints. You might find some other useful blueprints there too.")
    .AddDialogue(speakerData, "Along the way, see if you can keep track of any silicon or copper deposits. We're running low on those too.")
    .AddDialogue(speakerData, "Good luck, friend.")


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