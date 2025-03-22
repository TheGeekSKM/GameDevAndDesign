// Inherit the parent event
event_inherited();
SetPlayerIndex(0);

currentQuest = undefined;

Subscribe($"Player{playerIndex}QuestSelected", function(index) {
    currentQuest = GetQuestByIndex(index);
});

function DrawGUI()
{
    // text start pos = x, y, wrap = 366
    var textStart = new Vector2(x, y);
    var wrap = 366;

    if (GetNumberOfQuests() == 0)
    {
        scribble("No Quests Available")
            .align(fa_center, fa_middle)
            .starting_format("Font", c_black)
            .transform(1, 1, image_angle)
            .draw(textStart.x, textStart.y);
        return;
    }

    if (currentQuest == undefined) return;
    scribble(currentQuest.description)
        .align(fa_center, fa_middle)
        .starting_format("Font", c_white)
        .transform(0.75, 0.75, image_angle)
        .wrap(wrap)
        .draw(textStart.x, textStart.y);
}