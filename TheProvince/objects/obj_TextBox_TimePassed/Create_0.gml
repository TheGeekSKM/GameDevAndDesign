// Inherit the parent event
event_inherited();

textToDisplay = $"{global.GameManager.MonthsPerTurn * global.GameManager.TurnCount} months have passed...";
Init(textToDisplay);

Subscribe("UpdateTimePassed", function(Count) {
    textToDisplay = $"{global.GameManager.MonthsPerTurn * Count} months have passed...";
    Init(textToDisplay);
});