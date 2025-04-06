// Inherit the parent event
event_inherited();
//
Subscribe("QuestOpen", function() {
    OpenMenu();
    global.vars.PauseGame(id);
    UpdateQuestButtons();
});

function Resume()
{
    obj_GUI_PanelMoveable.HideMenu();
    global.vars.ResumeGame(global.vars.Player);
}

buttonContainer = new ButtonContainer(id, true);
buttonContainer.SetPadding(18);
buttonContainer.SetSpacing(10);

numberOfButtonsPerPage = 4;
pageIndex = 0;

function IncrementPageIndex()
{
    var questCount = GetNumberOfQuests()
    var maxPageIndex = ceil(questCount / numberOfButtonsPerPage) - 1;
    pageIndex += 1;
    if (pageIndex > maxPageIndex) {
        pageIndex = 0;
    }
    UpdateQuestButtons();
}

function DecrementPageIndex()
{
    var questCount = GetNumberOfQuests()
    var maxPageIndex = ceil(questCount / numberOfButtonsPerPage) - 1;
    pageIndex -= 1;
    if (pageIndex < 0) {
        pageIndex = maxPageIndex;
    }
    UpdateQuestButtons();
}

function UpdateQuestButtons()
{

    if (GetNumberOfQuests() == 0) {
        return;
    }

    // start by clearing the button container
    buttonContainer.ClearButtons();

    // get the number of quests to display
    var questCount = GetNumberOfQuests();
    var startIndex = pageIndex * numberOfButtonsPerPage;
    var endIndex = startIndex + numberOfButtonsPerPage - 1;

    
    if (endIndex >= questCount) {
        endIndex = questCount - 1;
    }

    if (startIndex > endIndex) {
        startIndex = endIndex;
    }

    buttonContainer.AddButton("Previous Page", make_color_rgb(175, 145, 142), make_color_rgb(175, 90, 182), DecrementPageIndex);

    // loop through the quests and add buttons for each one
    for (var i = startIndex; i <= endIndex; i += 1) {
        echo(startIndex)
        var quest = GetQuestByIndex(i);
        var buttonText = quest.name;
        
        echo($"i: {i}, buttonText: {GetQuestByIndex(i).name}")
        
        var buttonHoverColor = make_color_rgb(142, 148, 175);
        var buttonClickColor = make_color_rgb(82, 99, 175);
        buttonContainer.AddButton(buttonText, buttonHoverColor, buttonClickColor, function () {});
    }

    buttonContainer.AddButton("Next Page", make_color_rgb(215, 255, 204), make_color_rgb(149, 255, 119), IncrementPageIndex);

    // create the buttons in the button container
    buttonContainer.Create();
}



obj_GUI_PanelMoveable.closeButtonCallback = function() {
    global.vars.ResumeGame(global.vars.Player);
}

AddQuest(new Quest("Test1", "Test1 Description", id));
AddQuest(new Quest("Test2", "Test2 Description", id));
AddQuest(new Quest("Test3", "Test3 Description", id)); 
AddQuest(new Quest("Test4", "Test3 Description", id)); 
AddQuest(new Quest("Test5", "Test3 Description", id)); 
AddQuest(new Quest("Test6", "Test3 Description", id)); 
AddQuest(new Quest("Test7", "Test3 Description", id)); 
AddQuest(new Quest("Test8", "Test3 Description", id)); 
AddQuest(new Quest("Test9", "Test3 Description", id)); 

UpdateQuestButtons();