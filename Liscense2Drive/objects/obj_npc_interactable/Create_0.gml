// Inherit the parent event
event_inherited();
image_speed = 0;
speakingSprite = npc1;
speakerName = "Jeffrey";
numPapersRequred = irandom_range(5, 10);
speakingText = string_concat("Hey! If you're here for your driver's test,\nyou're gonna need at least ", numPapersRequred, " documents!\nTurn the documents into me and then, go to Jeremy!")

papersQuest = new QuestData("Get Papers #1", "Jeffrey", "Jeffrey", QuestState.Idle, string_concat("You need at least ", numPapersRequred, " documents."));
questIndex = array_length(global.QuestLibrary);
array_push(global.QuestLibrary, papersQuest);

questInProgressText = [
    string_concat("Mmmm. You still need ", numPapersRequred - global.Inventory, " more papers..."),
    "Uhh..Can I help you",
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
                DialogueManager.SpawnDialogue(speakingSprite, speakerName, "Oh! Thank you! Now head over to Jeffrey.");
            }
            else
            {
                DialogueManager.SpawnDialogue(speakingSprite, speakerName, 
                    questInProgressText[irandom_range(0, array_length(questInProgressText) - 1)]
                );
            } 
            break;
        case QuestState.Completed:
            DialogueManager.SpawnDialogue(speakingSprite, speakerName, "Please...please go to Jeffrey...");
            break;
    }
    
    
    
    
}

