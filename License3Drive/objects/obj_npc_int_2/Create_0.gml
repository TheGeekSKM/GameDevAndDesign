// Inherit the parent event
event_inherited();
numInteraction = 0;
numItemsRequired = irandom_range(3, 12);
questIndex = 0;
questCompleted = false;

questData = new QuestData("The Missing Documents 2: Boogaloo", string_concat(
interactableName, " seems to have lost some more documents. It looks like you're gonna have to get them...why are they all in traffic?\n", 
"Get ", numItemsRequired, " documents so that ", interactableName, " will test you!"
));

questStartingText = string_concat("Howdy, pardner. I...uh...I lost the papers that you needed....uhhh. ",
"Tell you what, you get me ", numItemsRequired, " documents, and I will test you like none before. Now scurry along, friendo!", 
"you have collected them!");

questOnGoingText = [
    "Well now, lookie here! You're back, but uh… where's the rest of 'em papers? Y'know, them *important* ones?",
    "Ooooh boy. You ain't got the right amount? That's a real shame. See, if I don't follow the rules, the whole dang system falls apart. Probably.",
    "Mmm-hmm. Yeah, see, I *could* just take what ya got… but the folks upstairs say that'd make too much sense.",
    "Now don't get me wrong, I *wanna* help ya, but see, the handbook says I gotta pretend my hands are tied.",
    "Ope, looks like you're *one* short. And wouldn't ya know it, one short is exactly the number that makes my job real easy: 'Denied!'",
    "I tell ya what, if we start makin' exceptions, next thing ya know, dogs'll be drivin' cars, cows'll be runnin' for mayor, and—well, actually, that last one already happened.",
    "Oh, ya don't like these rules? Well, son, neither do I, but I reckon if I start thinkin' too hard, they might make me work harder.",
    "Now, I ain't sayin' this paperwork makes sense, but I *am* sayin' I get paid the same whether I approve it or not.",
    "Y'know, back in the day, we used to just shake hands and get things done. Then some fella invented 'policy,' and now I gotta pretend I can read.",
    "Look, friend, I'd bend the rules if I could, but the last fella who tried disappeared into the back room. Ain't seen him since. Reckon he's still in line."
];

questCompletedText = "Boy, you're really yeeing my haw!! Actually...wait a minute...my car doesn't have any parts in it!!! Can you find [c_yellow][wave] James a bit down south[/wave][c_white] and let him know!?"


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
        Raise("Dialogue", new DialogueData(image_blend, "Have you talked to [c_yellow] James[c_white], yet pardner?"));
    }
}