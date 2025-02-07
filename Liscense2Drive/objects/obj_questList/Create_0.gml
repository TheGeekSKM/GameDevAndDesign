vis = false;
startingX = x + 40;
startingY = y + 80;
gapBetweenY = 20;

quests = [];
selectedIndex = 0;

DrawQuests = function() 
{
    vis = true;
    quests = [];
    
    for (var i = 0; i < (array_length(global.QuestLibrary)); i++) 
    {
        var currentQuest = global.QuestLibrary[i];
        array_push(quests, currentQuest);
    }
}