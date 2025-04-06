// Inherit the parent event
event_inherited();
//
Subscribe("QuestOpen", function() {
    OpenMenu();
    global.vars.PauseGame(id);
    UpdateQuestButtons();
});

previousButtonHoverColor = make_color_rgb(215, 255, 204);
previousButtonClickColor = make_color_rgb(149, 255, 119);

nextButtonHoverColor = make_color_rgb(206, 245, 255);
nextButtonClickColor = make_color_rgb(119, 227, 255);

questSpeaker1 = 0;
questSpeaker2 = 0;
questSpeaker3 = 0;


// create previouspage button
previousButton = instance_create_depth(x, 52, depth - 1, obj_BASE_Button)
previousButton.SetText("< Previous")
previousButton.SetColors(previousButtonHoverColor, previousButtonClickColor)
previousButton.SetSize(200, 32)
previousButton.AddCallback(function() {
    DecrementPageIndex();
}) // add the callback to the next button

pageIndex = 0;
numberOfPages = ceil(GetNumberOfQuests() / 3) - 1; // 3 quests per page
echo($"GetNumberOfQuests: {GetNumberOfQuests()} / 3: {GetNumberOfQuests() / 3}, ceil: {ceil(GetNumberOfQuests() / 3)}")

mouseOverQuest1 = false;
mouseOverQuest2 = false;
mouseOverQuest3 = false;

// create nextpage button
nextButton = instance_create_depth(x, 277, depth - 1, obj_BASE_Button)
nextButton.SetText("Next >")
nextButton.SetColors(nextButtonHoverColor, nextButtonClickColor)
nextButton.SetSize(200, 32)
nextButton.AddCallback(function() {
    IncrementPageIndex();
}) // add the callback to the next button

// move it below the previous button

function IncrementPageIndex() {
    pageIndex += 1;
    if (pageIndex > numberOfPages) {
        pageIndex = 0;
    }
    echo(pageIndex)
    UpdateQuestButtons();
}

function DecrementPageIndex() {
    pageIndex -= 1;
    if (pageIndex < 0) {
        pageIndex = numberOfPages;
    }
        echo(pageIndex)
    UpdateQuestButtons();
}

function UpdateQuestButtons()
{
    questSpeaker1 = irandom_range(0, 2);
    questSpeaker2 = irandom_range(0, 2);
    questSpeaker3 = irandom_range(0, 2);
    
    numberOfPages = ceil(GetNumberOfQuests() / 3) - 1; // 3 quests per page
    questDisplay1Index = pageIndex * 3;
    echo(questDisplay1Index)
    questDisplay2Index = questDisplay1Index + 1;
    questDisplay3Index = questDisplay1Index + 2;

    if (questDisplay1Index >= GetNumberOfQuests()) {
        questDisplay1Index = -1; // Set to -1 if no quest is available
        echo(questDisplay1Index)
    }
    if (questDisplay2Index >= GetNumberOfQuests()) {
        questDisplay2Index = -1; // Set to -1 if no quest is available
    }
    if (questDisplay3Index >= GetNumberOfQuests()) {
        questDisplay3Index = -1; // Set to -1 if no quest is available
    }

    if (pageIndex == 0)
    {
        previousButton.SetColors(c_gray, c_gray);
        previousButton.SetText("X"); // Set text to indicate no previous page
    }
    else
    {
        previousButton.SetColors(previousButtonHoverColor, previousButtonClickColor);
        previousButton.SetText("< Previous"); // Reset text to original
    }

    if (pageIndex == numberOfPages)
    {
        nextButton.SetColors(c_gray, c_gray);
        nextButton.SetText("X"); // Set text to indicate no next page
    }
    else
    {
        nextButton.SetColors(nextButtonHoverColor, nextButtonClickColor);
        nextButton.SetText("Next >"); // Reset text to original
    }
}

function OnMouseLeftClick()
{
    if (mouseOverQuest1) 
    {
        Raise("QuestSelected", questDisplay1Index);
    } 
    else if (mouseOverQuest2) 
    {
        Raise("QuestSelected", questDisplay2Index);
    } 
    else if (mouseOverQuest3) 
    {
        Raise("QuestSelected", questDisplay3Index);
    }
    else {
        dragging = true;
        windowMouseOffset.x = guiMouseX - x;
        windowMouseOffset.y = guiMouseY - y;
    }
}


UpdateQuestButtons();

closeButtonCallback = function() {
    with(obj_QuestDetails)
    {
        HideMenu();
    }
    global.vars.ResumeGame(global.vars.Player);
}