// Inherit the parent event
event_inherited();
image_speed = 0;
speakingSprite = npc2;
speakerName = "Jeremy";
numPapersRequred = irandom_range(5, 10);
speakingText = string_concat("Howdy, partner! Oh I see you got past Jeffrey. \nWell jokes on you, You're gonna need ", numPapersRequred, " more papers with me, buckaroo.")

papersQuest = new QuestData("Get Papers #2", speakerName, speakerName, QuestState.Idle, string_concat("You need at least ", numPapersRequred, " documents."));
questIndex = array_length(global.QuestLibrary);
array_push(global.QuestLibrary, papersQuest);

questInProgressText = [
    string_concat("Pardner, Imma need you to grab ", numPapersRequred - global.Inventory, " more papers..."),
    "yee? haw?",
    "Sir, Imma need you to grab your documents.",
    "Documents?",
    "Yes?",
    "Uh...dude...your documents...?",
];

OnInteract = function()
{
    switch (global.QuestLibrary[questIndex].questState)
    {
        case QuestState.Idle:
            global.QuestLibrary[questIndex].questState = QuestState.Started
            DialogueManager.SpawnDialogue(speakingSprite, speakerName, speakingText);
            break;
        case QuestState.Started:
            if (global.Inventory >= numPapersRequred)
            {
                global.QuestLibrary[questIndex].questState = QuestState.Completed;
                global.Inventory -= numPapersRequred;
                
            }
            else
            {
                DialogueManager.SpawnDialogue(speakingSprite, speakerName, 
                    questInProgressText[irandom_range(0, array_length(questInProgressText) - 1)]
                );
            } 
            break;
        case QuestState.Completed:
            break;
    }
    
    
    
    
}

