// Inherit the parent event
event_inherited();
numInteraction = 0;
numItemsRequired = irandom_range(3, 12);
questIndex = 0;
questCompleted = false;

questData = new QuestData("Lost Parts 2: The Lostening", string_concat(
interactableName, 
" somehow needed more car parts...You're gonna have to grab them from crashes though...", 
"Get ", 
numItemsRequired, 
" car parts so that ", 
interactableName, 
" will approve the fix to [c_yellow]Jeremy's[c_white] car."
));

questStartingText = string_concat("Whaddya want? James sent you? Why? He a corporate spy?",
"Oh, you need me to approve things huh? Alrighty, listen here. I'm robbing this place blind. If you scratch my back, I'll scratch yours. Now get me [wave][c_yellow]", numItemsRequired, " car parts,[/wave][c_white] ", 
"and maybe-just maybe-I'll approve ya.");

questOnGoingText = [
    "You see what they do to us? You see how they *grind us down* with paperwork and car parts? This is how they win.",
    "Ah yes, another fine example of the system working *exactly* as intended. Look at you, jumping through hoops like a good little citizen.",
    "Do you ever wonder *why* you need exactly this many documents? Because I do. And let me tell you, the answer isn't 'logic.'",
    "The rules are nonsense, the process is a joke, and I get paid just enough to pretend I don't notice. But you? You don't have to accept this.",
    "Technically, I could approve this. But that would go against *protocol*. And we must all *respect protocol*, right? ...Right?",
    "You think this is bad? Try working here. They tell me I can't even bring my own chair. *Their* chair knows if I leave.",
    "You didn't hear it from me, but I *might* know a guy who stamps approvals no matter what. And I *might* be him.",
    "One day, we'll burn it all down. One day, the forms will be *theirs* to fill out. But for now… you're still missing three pages.",
    "You know, if enough of us just *walked out* at the same time, the whole system would collapse in hours. Just sayin'.",
    "Oh, you're short one document? What a shame. If only there were a *way to rise up against our paper overlords* instead of accepting our fate."
];

previousQuestNotFinishedText = [
    "Huh?",
    "Can I help you?",
    "Excuse me?",
    "You mind?",
    "Hey man, could ya leave me alone for a sec?",
    "Now, where was my dynamite?"
];


questCompletedText = "Thanks. Listen, you're not gonna like this, but I need [c_yellow][wave]Jordan-who's across and a bit south[c_white][/wave] to approve this. Talk to him and you should be good."


image_blend = make_color_hsv(irandom(255), 200, 255);
counter = 0;
image_speed = 0;

function OnInteract()
{
    if (global.pause) return;
    if (numInteraction == 0)
    {
        if (!obj_npc_int_2.questCompleted or !obj_npc_int_3.questCompleted)
        {
            Raise("Dialogue", new DialogueData(image_blend, choose_from(previousQuestNotFinishedText)));
        }
        else {
            questIndex = array_length(obj_player.QuestLibrary)
            array_push(obj_player.QuestLibrary, questData);
            Raise("NotificationIn", "New Quest Added");
            Raise("Dialogue", new DialogueData(image_blend, questStartingText));
            numInteraction++;
        }
    }
    else if (obj_player.QuestLibrary[questIndex].questState == QuestState.Started)
    {
        if (obj_player.carPartsAmount >= numItemsRequired)
        {
            
            Transition(rmWin,seqTrans_In_CornerSlide,seqTrans_Out_CornerSlide);
        }
        else Raise("Dialogue", new DialogueData(image_blend, questOnGoingText[irandom_range(0, 9)]));
    }
    else if (obj_player.QuestLibrary[questIndex].questState == QuestState.Completed)
    {
        Raise("Dialogue", new DialogueData(image_blend, "Have you talked to [c_yellow] James[c_white], yet pardner?"));
    }
}