// Inherit the parent event
event_inherited();
numInteraction = 0;
numItemsRequired = irandom_range(3, 12);
questIndex = 0;
questCompleted = false;

questData = new QuestData("The Lost Parts", string_concat(
interactableName, 
" asked you to grab some car parts...You're gonna have to grab them from crashes though...", 
"Get ", 
numItemsRequired, 
" car parts so that ", 
interactableName, 
" will fix [c_yellow][wave]Jeremy's[c_white][/wave] car."
));

questStartingText = string_concat("Huh? Oh. Mornin'. Jeremysent you? Why?",
"..HE DID WHAT??! ARGH!!! Fine. Listen, you're gonna have to get me [c_yellow][wave]", numItemsRequired, " car parts[/wave][c_white]. However, I don't",
" have like a warehouse, so you're gonna have to find [c_red]crashes[c_white]. Here, take this [c_green]Crash Detector[c_white] and [c_green]Compass[c_white].",
" You'll find them in your inventory. Equip them.");

questOnGoingText = [
    "Listen, I don't make the rules. I just suffer under them like everybody else.",
    "Oh great, you're back. And you *still* don't have the right amount? Fantastic. I *love* doing this all day.",
    "Look, I'd let it slide if I could, but the last time I tried using common sense, I got a three-hour lecture on 'protocol.'",
    "You know, when I was a kid, I had *dreams.* Now I have forms. Endless, meaningless forms.",
    "Sigh. If one more person asks me why this rule exists, I might just spontaneously combust.",
    "Okay, so, here's the deal: I could approve this with a single keystroke. But if I do, the system flags it, and then I have to do *more* paperwork. So no.",
    "Honestly? I stopped questioning this job years ago. I just fix things and pray for the weekend.",
    "You think this is bad? Last week, someone got denied for 'incorrectly stapling Form 22-B.' I wish I was joking.",
    "I promise you, no one hates these rules more than I do. But here I am, enforcing them anyway. Ain't life grand?",
    "You ever look at a stack of papers so long you start questioning reality? No? Give it time."
];

previousQuestNotFinishedText = [
    "Huh?",
    "Can I help you?",
    "Excuse me?",
    "You mind?",
    "Hey man, could ya leave me alone for a sec?",
    "Now, where was Form 22-B?"
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
        if (!obj_npc_int_2.questCompleted)
        {
            Raise("Dialogue", new DialogueData(image_blend, choose_from(previousQuestNotFinishedText)));
        }
        else {
            questIndex = array_length(obj_player.QuestLibrary)
            array_push(obj_player.QuestLibrary, questData);
            Raise("NotificationIn", "New Quest Added");
            Raise("Dialogue", new DialogueData(image_blend, questStartingText));
            obj_player.AddItem(ItemType.CrashDetector, 1);
            obj_player.AddItem(ItemType.Compass, 1);
            
            numInteraction++;
        }
    }
    else if (obj_player.QuestLibrary[questIndex].questState == QuestState.Started)
    {
        if (obj_player.carPartsAmount >= numItemsRequired)
        {
            obj_player.carPartsAmount -= numItemsRequired;            
            obj_player.QuestLibrary[questIndex].questState = QuestState.Completed;
            Raise("Dialogue", new DialogueData(image_blend, questCompletedText));
            questCompleted = true;
        }
        else Raise("Dialogue", new DialogueData(image_blend, questOnGoingText[irandom_range(0, 9)]));
    }
    else if (obj_player.QuestLibrary[questIndex].questState == QuestState.Completed)
    {
        Raise("Dialogue", new DialogueData(image_blend, "Have you talked to [c_yellow][wave]Jordan[/wave][c_white] yet?"));
    }
}