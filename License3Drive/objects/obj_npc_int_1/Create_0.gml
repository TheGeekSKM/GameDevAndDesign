// Inherit the parent event
event_inherited();
numInteraction = 0;
numItemsRequired = irandom_range(3, 12);
questIndex = 0;
questCompleted = false;

questData = new QuestData("The Missing Documents", string_concat(
"Good Ol'", interactableName, " seems to have lost his-erm I mean, your papers. It looks like you're gonna have to get them. Get [wave][c_yellow]", numItemsRequired, " documents[/wave][c_white] so that Jeffrey will let you take your test!"
));

questData2 = new QuestData("Find Jeremy", 
    string_concat(
        "In a clearly not so nice tone,", interactableName, " pointed you across the asphalt pond to find Jeremy...", 
        "I suppose you don't have much choice..."
    )
)

questStartingText = string_concat("Good Morning! It appears you're hear for your Driver's Test, yes? Well, it seems I have lost ",
"your documents, hehehehee. I need at least, [wave][c_yellow]", numItemsRequired, " documents[/wave][c_white] before I let you take the test. Bring them to me once ", 
"you have collected them! [wave]Mwahhaahahha!!![/wave]");

questOnGoingText = [
    "Oh, you're back? And yet… still utterly useless.",
    "Let me guess—you got distracted by traffic? Boo-hoo. Get back out there.",
    "I require *exactly* the number I asked for. Not a page less. Not a page more. Try again.",
    "You must enjoy wasting my time. Unfortunately for you, I have *infinite* patience. Do you?",
    "Did I stutter? Bring. Me. The. Documents.",
    "Ah yes, the smell of incompetence. Bring the correct number, or don't come back.",
    "Do you think I'm running a charity? The DMV demands perfection, and you bring… *this*?",
    "I'd tell you to take a number, but your number is already *failure*.",
    "Look, I don't make the rules. I just enforce them with *soul-crushing precision*.",
    "If you don't return with the right amount next time, I might just *lose* your paperwork… forever."
];

questCompletedText = "Hmph. Fine. Find Jeremy [c_yellow][wave]directly on the other side [/wave][c_white]and he'll help you...ugh..."


image_blend = make_color_hsv(irandom(255), 200, 255);
counter = 0;
image_speed = 0;

function OnInteract()
{
    if (global.pause) return;
    if (numInteraction == 0)
    {
        questIndex = array_length(obj_player.QuestLibrary)
        array_push(obj_player.QuestLibrary, questData);
        Raise("NotificationIn", "New Quest Added");
        Raise("Dialogue", new DialogueData(image_blend, questStartingText));
        numInteraction++;
    }
    else if (obj_player.QuestLibrary[questIndex].questState == QuestState.Started)
    {
        if (obj_player.paperAmount >= numItemsRequired)
        {
            obj_player.paperAmount -= numItemsRequired;
            obj_player.QuestLibrary[questIndex].questState = QuestState.Completed;
            Raise("Dialogue", new DialogueData(image_blend, questCompletedText));
            questCompleted = true;
        }
        else Raise("Dialogue", new DialogueData(image_blend, questOnGoingText[irandom_range(0, 9)]));
    }
    else if (obj_player.QuestLibrary[questIndex].questState == QuestState.Completed)
    {
        Raise("Dialogue", new DialogueData(image_blend, "Get away from me..."));
    }
}